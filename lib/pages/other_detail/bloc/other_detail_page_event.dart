import 'package:equatable/equatable.dart';

abstract class OtherDetailPageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchOtherDetailPage extends OtherDetailPageEvent {
  final String otherUserId;

  FetchOtherDetailPage(this.otherUserId);

  @override
  List<Object> get props => [otherUserId];
}

class SendMessage extends OtherDetailPageEvent {
  final String otherUserId;
  final String text;

  SendMessage(this.otherUserId, this.text);

  @override
  List<Object> get props => [otherUserId, text];
}
