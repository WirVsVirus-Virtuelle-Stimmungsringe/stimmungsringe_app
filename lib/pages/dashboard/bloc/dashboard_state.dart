import 'package:equatable/equatable.dart';
import 'package:stimmungsringeapp/data/dashboard.dart';

abstract class DashboardState extends Equatable {
  @override
  List<Object> get props => [];
}

class DashboardUninitialized extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final Dashboard dashboard;

  DashboardLoaded(this.dashboard) : assert(dashboard != null);

  @override
  List<Object> get props => [dashboard];
}

class DashboardError extends DashboardState {
  // may be null
  final Dashboard dashboard;

  DashboardError(this.dashboard);

  @override
  List<Object> get props => [dashboard];
}
