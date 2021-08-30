import 'package:equatable/equatable.dart';
import 'package:familiarise/data/sentiment.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDashboard extends DashboardEvent {}

class RefreshDashboardIfNecessary extends DashboardEvent {}

class PropagateDashboardRefreshError extends DashboardEvent {}

class SetNewSentiment extends DashboardEvent {
  final Sentiment sentiment;
  final String sentimentText;

  SetNewSentiment(this.sentiment, this.sentimentText);

  @override
  List<Object> get props => [sentiment, sentimentText];
}
