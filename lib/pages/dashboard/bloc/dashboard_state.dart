import 'package:equatable/equatable.dart';
import 'package:familiarise/data/dashboard.dart';
import 'package:familiarise/data/message.dart';

abstract class StateWithDashboard {
  Dashboard get dashboard;
  MessageInbox get inbox;
  DateTime get now;
}

abstract class DashboardState extends Equatable {
  bool get hasDashboard;

  @override
  List<Object> get props => [];
}

class DashboardUninitialized extends DashboardState {
  @override
  bool get hasDashboard => false;
}

class DashboardLoading extends DashboardState implements StateWithDashboard {
  @override
  final Dashboard dashboard;
  @override
  final MessageInbox inbox;
  @override
  final DateTime now;

  DashboardLoading(this.dashboard, this.inbox, this.now)
      : assert(dashboard == null || inbox != null && now != null);

  @override
  bool get hasDashboard => dashboard != null;

  @override
  List<Object> get props => [dashboard, now];
}

class DashboardLoaded extends DashboardState implements StateWithDashboard {
  @override
  final Dashboard dashboard;
  @override
  final MessageInbox inbox;
  @override
  final DateTime now;

  DashboardLoaded(this.dashboard, this.inbox, this.now)
      : assert(dashboard != null),
        assert(inbox != null),
        assert(now != null);

  @override
  bool get hasDashboard => true;

  @override
  List<Object> get props => [dashboard, inbox, now];
}

class DashboardError extends DashboardState implements StateWithDashboard {
  // may be null
  @override
  final Dashboard dashboard;
  @override
  final MessageInbox inbox;
  @override
  final DateTime now;

  DashboardError(this.dashboard, this.inbox, this.now)
      : assert(dashboard == null || inbox != null && now != null);

  @override
  bool get hasDashboard => dashboard != null;

  @override
  List<Object> get props => [dashboard, inbox, now];
}
