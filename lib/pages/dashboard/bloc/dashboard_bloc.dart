import 'dart:async';

import 'package:familiarise/data/dashboard.dart';
import 'package:familiarise/data/message.dart';
import 'package:familiarise/data/sentiment.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_event.dart';
import 'package:familiarise/pages/dashboard/bloc/dashboard_state.dart';
import 'package:familiarise/pages/user_settings/bloc/user_settings_bloc.dart';
import 'package:familiarise/pages/user_settings/bloc/user_settings_state.dart';
import 'package:familiarise/repositories/dashboard_repository.dart';
import 'package:familiarise/repositories/message_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  static const _refreshInterval = Duration(seconds: 3);

  final DashboardRepository dashboardRepository;
  final MessageRepository messageRepository;

  StreamSubscription<UserSettingsState> _userSettingsBlocSubscription;
  int _dashboardHash = 0;
  int _messageInboxHash = 0;
  StreamSubscription<void> _refreshSubscription;

  DashboardBloc({
    @required this.dashboardRepository,
    @required this.messageRepository,
    @required UserSettingsBloc userSettingsBloc,
  })  : assert(dashboardRepository != null),
        assert(messageRepository != null),
        assert(userSettingsBloc != null),
        super(DashboardUninitialized()) {
    _userSettingsBlocSubscription = userSettingsBloc.listen((state) {
      if (state is UserSettingsLoaded) {
        print("settings sub");
        add(RefreshDashboardIfNecessary());
      }
    });

    _refreshSubscription =
        Stream<void>.periodic(_refreshInterval).listen((_) async {
      final futures = await Future.wait([
        dashboardRepository.loadDashboardPageData(),
        messageRepository.loadInbox()
      ]);
      final dashboard = futures[0] as Dashboard;
      final messageInbox = futures[1] as MessageInbox;

      _dashboardHash = dashboard.hashCode;
      _messageInboxHash = messageInbox.hashCode;
      add(RefreshDashboardIfNecessary());
    });
  }

  @override
  void onTransition(Transition<DashboardEvent, DashboardState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is FetchDashboard) {
      yield* _mapFetchDashboardToState(event);
    } else if (event is RefreshDashboardIfNecessary) {
      yield* _mapRefreshDashboardToState(event);
    } else if (event is SetNewSentiment) {
      yield* _mapSetNewSentimentToState(event);
    }
  }

  Stream<DashboardState> _mapFetchDashboardToState(
      FetchDashboard fetch) async* {
    if (state is DashboardLoading) {
      return;
    }

    if (state.hasDashboard) {
      yield DashboardLoading((state as StateWithDashboard).dashboard,
          (state as StateWithDashboard).inbox, DateTime.now());
    } else {
      yield DashboardLoading(null, null, null);
    }

    try {
      final futures = await Future.wait([
        dashboardRepository.loadDashboardPageData(),
        messageRepository.loadInbox()
      ]);
      final dashboard = futures[0] as Dashboard;
      final inbox = futures[1] as MessageInbox;
      yield DashboardLoaded(dashboard, inbox, DateTime.now());
    } catch (ex) {
      print(ex);
      if (state is DashboardLoaded) {
        yield DashboardError((state as DashboardLoaded).dashboard,
            (state as DashboardLoaded).inbox, DateTime.now());
      } else {
        yield DashboardError(null, null, null);
      }
    }
  }

  Stream<DashboardState> _mapRefreshDashboardToState(
      RefreshDashboardIfNecessary refresh) async* {
    if (state is! DashboardLoaded) {
      return;
    }
    try {
      if (state.hasDashboard) {
        final stateWithDashboard = state as StateWithDashboard;
        if (stateWithDashboard.dashboard.hashCode == _dashboardHash &&
            stateWithDashboard.inbox.hashCode == _messageInboxHash) {
          print("skip refresh");
          return;
        }
      }

      final futures = await Future.wait([
        dashboardRepository.loadDashboardPageData(),
        messageRepository.loadInbox()
      ]);
      final dashboard = futures[0] as Dashboard;
      final inbox = futures[1] as MessageInbox;

      _dashboardHash = dashboard.hashCode;
      _messageInboxHash = inbox.hashCode;

      yield DashboardLoaded(dashboard, inbox, DateTime.now());
    } catch (ex) {
      print(ex);
    }
  }

  Stream<DashboardState> _mapSetNewSentimentToState(
      SetNewSentiment setNewSentiment) async* {
    if (state is! DashboardLoaded) {
      return;
    }

    final dashboardLoadedState = state as DashboardLoaded;

    try {
      final Dashboard prevDashboard = dashboardLoadedState.dashboard;
      final Dashboard optimisticUpdate = prevDashboard.copyWith(
          myTile: prevDashboard.myTile
              .copyWith(sentiment: setNewSentiment.sentiment));
      print(
          "optimistic set ${optimisticUpdate.myTile.sentiment.sentimentCode}");
      yield DashboardLoaded(
        optimisticUpdate,
        dashboardLoadedState.inbox,
        DateTime.now(),
      );

      await dashboardRepository.setNewSentiment(setNewSentiment.sentiment);
      final Dashboard loadDashboardPageData =
          await dashboardRepository.loadDashboardPageData();
      print(
          "reloaded dashboard ${loadDashboardPageData.myTile.sentiment.sentimentCode}");
      yield DashboardLoaded(
        loadDashboardPageData,
        dashboardLoadedState.inbox,
        DateTime.now(),
      );
    } catch (ex) {
      print(ex);

      yield DashboardError(
        dashboardLoadedState.dashboard,
        dashboardLoadedState.inbox,
        DateTime.now(),
      );
    }
  }

  @override
  Future<void> close() {
    _userSettingsBlocSubscription.cancel();
    if (_refreshSubscription != null) {
      _refreshSubscription.cancel();
      _refreshSubscription = null;
    }
    return super.close();
  }
}
