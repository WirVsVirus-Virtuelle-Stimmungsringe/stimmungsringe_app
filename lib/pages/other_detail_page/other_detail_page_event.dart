import 'package:equatable/equatable.dart';

abstract class OtherDetailPageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchOtherDetailPage extends OtherDetailPageEvent {}
