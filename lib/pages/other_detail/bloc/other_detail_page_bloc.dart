import 'package:familiarise/pages/other_detail/bloc/other_detail_page_event.dart';
import 'package:familiarise/pages/other_detail/bloc/other_detail_page_state.dart';
import 'package:familiarise/repositories/dashboard_repository.dart';
import 'package:familiarise/repositories/message_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtherDetailPageBloc
    extends Bloc<OtherDetailPageEvent, OtherDetailPageState> {
  final DashboardRepository dashboardRepository;
  final MessageRepository messageRepository;

  OtherDetailPageBloc(
      {@required this.dashboardRepository, @required this.messageRepository})
      : assert(dashboardRepository != null),
        assert(messageRepository != null);

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
        final otherDetail = await dashboardRepository
            .loadOtherDetailPageData(event.otherUserId);
        final availableMessages =
            await messageRepository.loadAvailableMessages(event.otherUserId);
        print("available messages:");
        for (var template in availableMessages.messageTemplates) {
          print("- " + template.text);
        }
        yield OtherDetailPageLoaded(otherDetail, availableMessages);
        return;
      } catch (ex) {
        print(ex);

        yield OtherDetailPageError();
      }
    }

    if (event is SendMessage) {
      print("send message to " + event.otherUserId);
      final availableMessages =
          await messageRepository.sendMessage(event.otherUserId, event.text);
      if (state is OtherDetailPageLoaded) {
        print("available messages after send:");
        for (var template in availableMessages.messageTemplates) {
          print("- " + template.text);
        }
        yield OtherDetailPageLoaded(
            (state as OtherDetailPageLoaded).otherDetail, availableMessages);
      }
    }
  }

  @override
  void onTransition(
      Transition<OtherDetailPageEvent, OtherDetailPageState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
