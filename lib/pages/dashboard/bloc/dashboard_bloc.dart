import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stimmungsringeapp/data/dashboard.dart';
import 'package:stimmungsringeapp/data/sentiment.dart';
import 'package:stimmungsringeapp/pages/dashboard/bloc/bloc.dart';
import 'package:stimmungsringeapp/pages/user_settings/bloc/bloc.dart';
import 'package:stimmungsringeapp/repositories/dashboard_repository.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository dashboardRepository;
  StreamSubscription<UserSettingsState> userSettingsBlocSubscription;

  StreamSubscription<void> _refreshSubscription;

  DashboardBloc({
    @required this.dashboardRepository,
    @required UserSettingsBloc userSettingsBloc,
  })  : assert(dashboardRepository != null),
        assert(userSettingsBloc != null),
        super() {
    userSettingsBlocSubscription = userSettingsBloc.listen((state) {
      if (state is ShowCurrentUserSettings) {
        add(FetchDashboard());
      }
    });

    _refreshSubscription =
        Stream<void>.periodic(const Duration(seconds: 3)).listen((_) {
      add(RefreshDashboard());
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
      yield DashboardLoading(
          (state as StateWithDashboard).dashboard, DateTime.now());
    } else {
      yield DashboardLoading(null, null);
    }

    try {
      final dashboard = await dashboardRepository.loadDashboardPageData();
      yield DashboardLoaded(dashboard, DateTime.now());

      return;
    } catch (ex) {
      print(ex);
      if (state is DashboardLoaded) {
        yield DashboardError(
            (state as DashboardLoaded).dashboard, DateTime.now());
      } else {
        yield DashboardError(null, null);
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

      yield DashboardLoaded(dashboardReloaded, DateTime.now());
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
        yield DashboardLoaded(optimisticUpdate, DateTime.now());
      }

      await dashboardRepository.setNewSentiment(setNewSentiment.sentiment);
      final Dashboard loadDashboardPageData =
          await dashboardRepository.loadDashboardPageData();
      print(
          "reloaded dashboard ${loadDashboardPageData.myTile.sentiment.sentimentCode}");
      yield DashboardLoaded(loadDashboardPageData, DateTime.now());
    } catch (_) {
      yield DashboardError(
          (state as DashboardLoaded).dashboard, DateTime.now());
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
