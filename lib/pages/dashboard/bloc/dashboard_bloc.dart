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
      if (state is DashboardLoading) {
        return;
      }
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
    if (event is SetNewSentiment) {
      // TODO
      print("TODO update sentiment from event -> " + event.sentiment.name);
      yield DashboardLoading();
      try {
        dashboardRepository.setNewStatement(event.sentiment);
        Dashboard loadDashboardPageData =
            await dashboardRepository.loadDashboardPageData();
        yield DashboardLoaded(loadDashboardPageData);
      } catch (_) {
        yield DashboardError((state as DashboardLoaded).dashboard);
      }
    }
  }
}
