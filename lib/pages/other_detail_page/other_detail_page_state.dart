import 'package:equatable/equatable.dart';

abstract class OtherDetailPageState extends Equatable {
  @override
  List<Object> get props => [];
}

class OtherDetailPageUninitialized extends OtherDetailPageState {}

class OtherDetailPageLoading extends OtherDetailPageState {}

class OtherDetailPageLoaded extends OtherDetailPageState {}

class OtherDetailPageError extends OtherDetailPageState {}
