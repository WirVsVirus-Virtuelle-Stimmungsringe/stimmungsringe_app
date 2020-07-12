import 'dart:async';

import 'package:familiarise/data/dashboard.dart';
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
  final DashboardRepository dashboardRepository;
  final MessageRepository messageRepository;
  StreamSubscription<UserSettingsState> userSettingsBlocSubscription;
  int dashboardHash = 4242;

  StreamSubscription<void> _refreshSubscription;

  DashboardBloc({
    @required this.dashboardRepository,
    @required this.messageRepository,
    @required UserSettingsBloc userSettingsBloc,
  })  : assert(dashboardRepository != null),
        assert(messageRepository != null),
        assert(userSettingsBloc != null),
        super() {
    userSettingsBlocSubscription = userSettingsBloc.listen((state) {
      if (state is UserSettingsLoaded) {
        print("settings sub");
        add(RefreshDashboard());
      }
    });

    _refreshSubscription =
        Stream<void>.periodic(const Duration(seconds: 6)).listen((_) {
      dashboardRepository.loadDashboardPageData().then((value) {
        if (dashboardHash != value.hashCode) {
          dashboardHash = value.hashCode;
          print("queue refresh");
          add(RefreshDashboard());
        }
      });
    });
  }

  @override
  DashboardState get initialState => DashboardUninitialized();

  @override
  void onTransition(Transition<DashboardEvent, DashboardState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is FetchDashboard) {
      yield* _mapFetchDashboardToState(event);
    } else if (event is RefreshDashboard) {
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
          (state as DashboardLoaded).inbox, DateTime.now());
    } else {
      yield DashboardLoading(null, null, null);
    }

    try {
      final dashboard = await dashboardRepository.loadDashboardPageData();
      final inbox = await messageRepository.loadInbox();
      yield DashboardLoaded(dashboard, inbox, DateTime.now());

      return;
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
      RefreshDashboard refresh) async* {
    if (state is! DashboardLoaded) {
      return;
    }
    try {
      final Dashboard dashboardReloaded =
          await dashboardRepository.loadDashboardPageData();
      final inbox = await messageRepository.loadInbox();

      yield DashboardLoaded(dashboardReloaded, inbox, DateTime.now());
    } catch (ex) {
      print(ex);
    }
  }

  Stream<DashboardState> _mapSetNewSentimentToState(
      SetNewSentiment setNewSentiment) async* {
    try {
      if (state is DashboardLoaded) {
        final Dashboard prevDashboard = (state as DashboardLoaded).dashboard;
        final Dashboard optimisticUpdate = prevDashboard.copyWith(
            myTile: prevDashboard.myTile
                .copyWith(sentiment: setNewSentiment.sentiment));
        print(
            "optimistic set ${optimisticUpdate.myTile.sentiment.sentimentCode}");
        yield DashboardLoaded(
            optimisticUpdate, (state as DashboardLoaded).inbox, DateTime.now());

        await dashboardRepository.setNewSentiment(setNewSentiment.sentiment);
        final Dashboard loadDashboardPageData =
            await dashboardRepository.loadDashboardPageData();
        print(
            "reloaded dashboard ${loadDashboardPageData.myTile.sentiment.sentimentCode}");
        yield DashboardLoaded(loadDashboardPageData,
            (state as DashboardLoaded).inbox, DateTime.now());
      }

      if (state is DashboardError) {
        yield DashboardError((state as DashboardLoaded).dashboard,
            (state as DashboardLoaded).inbox, DateTime.now());
      }
    } catch (_) {
      yield DashboardError((state as DashboardLoaded).dashboard,
          (state as DashboardLoaded).inbox, DateTime.now());
    }
  }

  @override
  Future<void> close() {
    userSettingsBlocSubscription.cancel();
    if (_refreshSubscription != null) {
      _refreshSubscription.cancel();
      _refreshSubscription = null;
    }
    return super.close();
  }
}
