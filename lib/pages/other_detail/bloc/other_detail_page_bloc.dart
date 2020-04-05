import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stimmungsringeapp/data/detail_pages.dart';
import 'package:stimmungsringeapp/pages/other_detail/bloc/bloc.dart';
import 'package:stimmungsringeapp/repositories/dashboard_repository.dart';

class OtherDetailPageBloc
    extends Bloc<OtherDetailPageEvent, OtherDetailPageState> {
  final DashboardRepository dashboardRepository;

  OtherDetailPageBloc({this.dashboardRepository});

  @override
  OtherDetailPageState get initialState => OtherDetailPageUninitialized();

  @override
  Stream<OtherDetailPageState> mapEventToState(
      OtherDetailPageEvent event) async* {
    if (event is FetchOtherDetailPage) {
      if (state is OtherDetailPageLoading) {
        return;
      }
      try {
        final otherDetail = await loadOtherDetailPageData(event.otherUserId);
        yield OtherDetailPageLoaded(otherDetail);
        return;
      } catch (_) {
        if (state is OtherDetailPageLoaded) {
          yield OtherDetailPageError();
        } else {
          yield OtherDetailPageError();
        }
      }
    }
  }

  void onTransition(
      Transition<OtherDetailPageEvent, OtherDetailPageState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
