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

  OtherDetailPageLoaded copyWith({
    OtherDetail otherDetail,
    AvailableMessages availableMessages,
  }) {
    return OtherDetailPageLoaded(
      otherDetail ?? this.otherDetail,
      availableMessages ?? this.availableMessages,
    );
  }

  @override
  List<Object> get props => [otherDetail, availableMessages];
}

class OtherDetailPageSendingMessage extends OtherDetailPageLoaded {
  final String sendingForMessage;

  OtherDetailPageSendingMessage(
    OtherDetail otherDetail,
    AvailableMessages availableMessages,
    this.sendingForMessage,
  )   : assert(sendingForMessage != null),
        super(otherDetail, availableMessages);

  factory OtherDetailPageSendingMessage.fromOtherDetailPageLoaded(
    OtherDetailPageLoaded otherDetailPageLoaded,
    String sendingForMessage,
  ) {
    return OtherDetailPageSendingMessage(
      otherDetailPageLoaded.otherDetail,
      otherDetailPageLoaded.availableMessages,
      sendingForMessage,
    );
  }

  @override
  List<Object> get props => [sendingForMessage, ...super.props];
}

class OtherDetailPageError extends OtherDetailPageState {}
