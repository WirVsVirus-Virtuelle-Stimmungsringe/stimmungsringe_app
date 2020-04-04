import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stimmungsringeapp/data/dashboard.dart';
import 'package:stimmungsringeapp/pages/dashboard/bloc/bloc.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
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
        final dashboard = await loadDashboardPageData();
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
      print("TODO update sentiment");
    }
  }
}