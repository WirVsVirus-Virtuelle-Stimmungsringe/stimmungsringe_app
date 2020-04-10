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
