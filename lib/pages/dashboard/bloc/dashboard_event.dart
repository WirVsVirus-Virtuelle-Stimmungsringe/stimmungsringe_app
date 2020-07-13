import 'package:equatable/equatable.dart';
import 'package:familiarise/data/dashboard.dart';
import 'package:familiarise/data/message.dart';
import 'package:familiarise/data/sentiment.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDashboard extends DashboardEvent {}

class RefreshDashboard extends DashboardEvent {
  final Dashboard newDashboard;
  final MessageInbox newMessageInbox;

  RefreshDashboard({this.newDashboard, this.newMessageInbox})
      : assert(newDashboard != null && newMessageInbox != null ||
            newDashboard == null && newMessageInbox == null);

  @override
  List<Object> get props => [newDashboard, newMessageInbox];
}

class SetNewSentiment extends DashboardEvent {
  final Sentiment sentiment;

  SetNewSentiment(this.sentiment) : assert(sentiment != null);

  @override
  List<Object> get props => [sentiment];
}
