import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stimmungsringeapp/data/freezed_classes.dart';
import 'package:stimmungsringeapp/pages/dashboard/bloc/bloc.dart';
import 'package:stimmungsringeapp/repositories/dashboard_repository.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository dashboardRepository;

  DashboardBloc({this.dashboardRepository});

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
    } else if (event is SetNewSentiment) {
      yield* _mapSetNewSentimentToState(event);
    }
  }

  Stream<DashboardState> _mapFetchDashboardToState(
      FetchDashboard fetch) async* {
    if (state is DashboardLoading) {
      return;
    }
    yield DashboardLoading();
    try {
      final dashboard = await dashboardRepository.loadDashboardPageData();
      yield DashboardLoaded(dashboard);
      return;
    } catch (_) {
      if (state is DashboardLoaded) {
        yield DashboardError((state as DashboardLoaded).dashboard);
      } else {
        yield DashboardError(null);
      }
    }
  }

  Stream<DashboardState> _mapSetNewSentimentToState(
      SetNewSentiment setNewSentiment) async* {
    try {
      if (state is DashboardLoaded) {
        Dashboard prevDashboard = (state as DashboardLoaded).dashboard;
        //prevDashboard.copyWith(
        //   myTile:
        //  prevDashboard.myTile.copyWith(sentimentStatus: setNewSentiment.sentiment.name)));
      }

      dashboardRepository.setNewSentiment(setNewSentiment.sentiment);
      Dashboard loadDashboardPageData =
          await dashboardRepository.loadDashboardPageData();
      yield DashboardLoaded(loadDashboardPageData);
    } catch (_) {
      yield DashboardError((state as DashboardLoaded).dashboard);
    }
  }
}
