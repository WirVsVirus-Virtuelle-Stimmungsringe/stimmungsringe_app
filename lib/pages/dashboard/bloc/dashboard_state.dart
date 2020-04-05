import 'package:equatable/equatable.dart';
import 'package:stimmungsringeapp/data/freezed_classes.dart';

abstract class StateWithDashboard {
  Dashboard get dashboard;
}

abstract class DashboardState extends Equatable {
  @override
  List<Object> get props => [];

  bool get hasDashboard;
}

class DashboardUninitialized extends DashboardState {
  @override
  bool get hasDashboard => false;
}

class DashboardLoading extends DashboardState {
  @override
  bool get hasDashboard => false;
}

class DashboardLoaded extends DashboardState implements StateWithDashboard {
  final Dashboard dashboard;

  DashboardLoaded(this.dashboard) : assert(dashboard != null);

  @override
  List<Object> get props => [dashboard];

  @override
  bool get hasDashboard => true;
}

class DashboardError extends DashboardState implements StateWithDashboard {
  // may be null
  final Dashboard dashboard;

  DashboardError(this.dashboard);

  @override
  List<Object> get props => [dashboard];

  @override
  bool get hasDashboard => dashboard != null;
}
