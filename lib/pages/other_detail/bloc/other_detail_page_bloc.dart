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
        assert(messageRepository != null),
        super();

  @override
  OtherDetailPageState get initialState => OtherDetailPageUninitialized();

  @override
  Stream<OtherDetailPageState> mapEventToState(
      OtherDetailPageEvent event) async* {
    if (event is FetchOtherDetailPage) {
      yield* _mapFetchOtherDetailEventToState(event);
    } else if (event is SendMessage) {
      yield* _mapSendMessageEventToState(event);
    }
  }

  Stream<OtherDetailPageState> _mapFetchOtherDetailEventToState(
      FetchOtherDetailPage fetchOtherDetailPageEvent) async* {
    if (state is OtherDetailPageLoading) {
      return;
    }
    try {
      final otherDetail = await dashboardRepository
          .loadOtherDetailPageData(fetchOtherDetailPageEvent.otherUserId);
      final availableMessages = await messageRepository
          .loadAvailableMessages(fetchOtherDetailPageEvent.otherUserId);
      yield OtherDetailPageLoaded(otherDetail, availableMessages);
      return;
    } catch (ex) {
      print(ex);

      yield OtherDetailPageError();
    }
  }

  Stream<OtherDetailPageState> _mapSendMessageEventToState(
      SendMessage sendMessageEvent) async* {
    if (state is! OtherDetailPageLoaded) {
      return;
    }

    final loadedState = state as OtherDetailPageLoaded;

    yield OtherDetailPageSendingMessage.fromOtherDetailPageLoaded(
      loadedState,
      sendMessageEvent.text,
    );

    final availableMessages = await messageRepository.sendMessage(
        sendMessageEvent.otherUserId, sendMessageEvent.text);

    yield loadedState.copyWith(availableMessages: availableMessages);
  }

  @override
  void onTransition(
      Transition<OtherDetailPageEvent, OtherDetailPageState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
