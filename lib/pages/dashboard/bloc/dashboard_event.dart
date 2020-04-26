import 'package:equatable/equatable.dart';
import 'package:stimmungsringeapp/data/sentiment.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDashboard extends DashboardEvent {}

class RefreshDashboard extends DashboardEvent {
  final String prevDashboardHashCode;

  RefreshDashboard(this.prevDashboardHashCode)
      : assert(prevDashboardHashCode != null);

  @override
  List<Object> get props => [prevDashboardHashCode];
}

class SetNewSentiment extends DashboardEvent {
  final Sentiment sentiment;

  SetNewSentiment(this.sentiment) : assert(sentiment != null);

  @override
  List<Object> get props => [sentiment];
}
