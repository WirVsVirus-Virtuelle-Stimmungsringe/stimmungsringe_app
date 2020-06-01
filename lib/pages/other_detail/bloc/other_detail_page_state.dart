import 'package:equatable/equatable.dart';
import 'package:familiarise/data/message.dart';
import 'package:familiarise/data/other_detail.dart';

abstract class OtherDetailPageState extends Equatable {
  @override
  List<Object> get props => [];
}

class OtherDetailPageUninitialized extends OtherDetailPageState {}

class OtherDetailPageLoading extends OtherDetailPageState {}

class OtherDetailPageLoaded extends OtherDetailPageState {
  final OtherDetail otherDetail;
  final AvailableMessages availableMessages;

  OtherDetailPageLoaded(this.otherDetail, this.availableMessages)
      : assert(otherDetail != null),
        assert(availableMessages != null);

  @override
  List<Object> get props => [otherDetail, availableMessages];
}

class OtherDetailPageError extends OtherDetailPageState {}
