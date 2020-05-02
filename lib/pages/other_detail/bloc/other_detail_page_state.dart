import 'package:equatable/equatable.dart';
import 'package:stimmungsringeapp/data/dashboard.dart';

abstract class OtherDetailPageState extends Equatable {
  @override
  List<Object> get props => [];
}

class OtherDetailPageUninitialized extends OtherDetailPageState {}

class OtherDetailPageLoading extends OtherDetailPageState {}

class OtherDetailPageLoaded extends OtherDetailPageState {
  final OtherDetail otherDetail;

  OtherDetailPageLoaded(this.otherDetail) : assert(otherDetail != null);

  @override
  List<Object> get props => [otherDetail];
}

class OtherDetailPageError extends OtherDetailPageState {}
