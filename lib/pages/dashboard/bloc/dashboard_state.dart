import 'package:equatable/equatable.dart';
import 'package:stimmungsringeapp/data/freezed_classes.dart';

abstract class StateWithDashboard {
  Dashboard get dashboard;
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

class DashboardLoading extends DashboardState {
  @override
  bool get hasDashboard => false;
}

class DashboardLoaded extends DashboardState implements StateWithDashboard {
  @override
  final Dashboard dashboard;

  DashboardLoaded(this.dashboard) : assert(dashboard != null);

  @override
  bool get hasDashboard => true;

  @override
  List<Object> get props => [dashboard];
}

class DashboardError extends DashboardState implements StateWithDashboard {
  // may be null
  @override
  final Dashboard dashboard;

  DashboardError(this.dashboard);

  @override
  bool get hasDashboard => dashboard != null;

  @override
  List<Object> get props => [dashboard];
}
