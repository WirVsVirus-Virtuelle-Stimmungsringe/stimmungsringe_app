import 'package:equatable/equatable.dart';
import 'package:stimmungsringeapp/data/detail_pages.dart';

abstract class OtherDetailPageState extends Equatable {
  @override
  List<Object> get props => [];
}

class OtherDetailPageUninitialized extends OtherDetailPageState {}

class OtherDetailPageLoading extends OtherDetailPageState {}

class OtherDetailPageLoaded extends OtherDetailPageState {
  final OtherDetail otherDetail;

  OtherDetailPageLoaded(this.otherDetail);
}

class OtherDetailPageError extends OtherDetailPageState {}
