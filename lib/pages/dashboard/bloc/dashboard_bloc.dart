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
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  static const _refreshInterval = Duration(seconds: 3);

  final DashboardRepository dashboardRepository;
  final MessageRepository messageRepository;

  late StreamSubscription<UserSettingsState> _userSettingsBlocSubscription;
  int _dashboardHash = 0;
  int _messageInboxHash = 0;
  late StreamSubscription<void> _refreshSubscription;
  StreamSubscription<void>? _errorTimerTickSubscription;

  DashboardBloc({
    required this.dashboardRepository,
    required this.messageRepository,
    required UserSettingsBloc userSettingsBloc,
  }) : super(DashboardUninitialized()) {
    _userSettingsBlocSubscription = userSettingsBloc.stream.listen((state) {
      if (state is UserSettingsLoaded) {
        add(RefreshDashboardIfNecessary());
      }
    });

    _refreshSubscription =
        Stream<void>.periodic(_refreshInterval).listen((_) async {
      try {
        final futures = await Future.wait([
          dashboardRepository.loadDashboardPageData(),
          messageRepository.loadInbox()
        ]);
        final dashboard = futures[0] as Dashboard;
        final messageInbox = futures[1] as MessageInbox;

        _dashboardHash = dashboard.hashCode;
        _messageInboxHash = messageInbox.hashCode;
        add(RefreshDashboardIfNecessary());
      } catch (_) {
        add(PropagateDashboardRefreshError());
      }
    });
  }

  @override
  void onTransition(Transition<DashboardEvent, DashboardState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is PropagateDashboardRefreshError) {
      yield* _mapPropagateDashboardRefreshErrorToState(event);
    } else if (event is IncrementDashboardRefreshErrorDuration) {
      yield* _mapIncrementDashboardRefreshErrorDuration(event);
    } else {
      _errorTimerTickSubscription?.cancel();
      _errorTimerTickSubscription = null;

      if (event is FetchDashboard) {
        yield* _mapFetchDashboardToState(event);
      } else if (event is RefreshDashboardIfNecessary) {
        yield* _mapRefreshDashboardToState(event);
      } else if (event is SetNewSentiment) {
        yield* _mapSetNewSentimentToState(event);
      }
    }
  }

  Stream<DashboardState> _mapFetchDashboardToState(
    FetchDashboard fetch,
  ) async* {
    if (state is DashboardLoading) {
      return;
    }

    yield DashboardLoading.fromDashboardState(state, now: DateTime.now());

    try {
      final futures = await Future.wait([
        dashboardRepository.loadDashboardPageData(),
        messageRepository.loadInbox()
      ]);
      final dashboard = futures[0] as Dashboard;
      final inbox = futures[1] as MessageInbox;
      yield DashboardLoaded(
        dashboard: dashboard,
        inbox: inbox,
        now: DateTime.now(),
      );
    } catch (ex) {
      print(ex);
      yield* _mapPropagateDashboardRefreshErrorToState(
        PropagateDashboardRefreshError(),
      );
    }
  }

  Stream<DashboardState> _mapRefreshDashboardToState(
    RefreshDashboardIfNecessary refresh,
  ) async* {
    if (state is DashboardUninitialized || state is DashboardLoading) {
      return;
    }
    try {
      if (state.hasDashboard) {
        final stateWithData = state as StateWithData;
        if (stateWithData.dashboard.hashCode == _dashboardHash &&
            stateWithData.inbox.hashCode == _messageInboxHash) {
          yield DashboardLoaded.fromDashboardState(state);
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

      yield DashboardLoaded(
        dashboard: dashboard,
        inbox: inbox,
        now: DateTime.now(),
      );
    } catch (ex) {
      print(ex);
      yield* _mapPropagateDashboardRefreshErrorToState(
        PropagateDashboardRefreshError(),
      );
    }
  }

  Stream<DashboardState> _mapSetNewSentimentToState(
    SetNewSentiment setNewSentiment,
  ) async* {
    if (state is! DashboardLoaded) {
      return;
    }

    final dashboardLoadedState = state as DashboardLoaded;

    try {
      final Dashboard prevDashboard = dashboardLoadedState.dashboard;
      final Dashboard optimisticUpdate = prevDashboard.copyWith(
        myTile:
            prevDashboard.myTile.copyWith(sentiment: setNewSentiment.sentiment),
      );
      print(
        "optimistic set ${optimisticUpdate.myTile.sentiment.sentimentCode}",
      );
      yield DashboardLoaded.fromDashboardState(
        dashboardLoadedState,
        dashboard: optimisticUpdate,
        now: DateTime.now(),
      );

      await dashboardRepository.setNewSentiment(
        setNewSentiment.sentiment,
        setNewSentiment.sentimentText,
      );
      final Dashboard loadDashboardPageData =
          await dashboardRepository.loadDashboardPageData();
      print(
        "reloaded dashboard ${loadDashboardPageData.myTile.sentiment.sentimentCode}",
      );
      yield DashboardLoaded.fromDashboardState(
        dashboardLoadedState,
        dashboard: loadDashboardPageData,
        now: DateTime.now(),
      );
    } catch (ex) {
      print(ex);

      yield* _mapPropagateDashboardRefreshErrorToState(
        PropagateDashboardRefreshError(),
      );
    }
  }

  Stream<DashboardState> _mapPropagateDashboardRefreshErrorToState(
    PropagateDashboardRefreshError refreshErrorEvent,
  ) async* {
    _errorTimerTickSubscription ??=
        Stream<void>.periodic(const Duration(seconds: 1))
            .listen((seconds) => add(IncrementDashboardRefreshErrorDuration()));

    yield DashboardError.fromDashboardState(state);
  }

  Stream<DashboardState> _mapIncrementDashboardRefreshErrorDuration(
    IncrementDashboardRefreshErrorDuration incrementDurationEvent,
  ) async* {
    final oldState = state;
    final Duration duration =
        oldState is DashboardError ? oldState.errorDuration : Duration.zero;
    yield DashboardError.fromDashboardState(
      state,
      errorDuration: duration + const Duration(seconds: 1),
    );
  }

  @override
  Future<void> close() {
    _userSettingsBlocSubscription.cancel();
    _refreshSubscription.cancel();
    _errorTimerTickSubscription?.cancel();
    return super.close();
  }
}
