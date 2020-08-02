import 'package:equatable/equatable.dart';

abstract class OtherDetailPageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchOtherDetailPage extends OtherDetailPageEvent {
  final String otherUserId;

  FetchOtherDetailPage(this.otherUserId) : assert(otherUserId != null);

  @override
  List<Object> get props => [otherUserId];
}

class SendMessage extends OtherDetailPageEvent {
  final String otherUserId;
  final String text;

  SendMessage(this.otherUserId, this.text)
      : assert(otherUserId != null),
        assert(text != null);

  @override
  List<Object> get props => [otherUserId, text];
}
