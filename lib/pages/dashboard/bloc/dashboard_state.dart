import 'package:equatable/equatable.dart';
import 'package:stimmungsringeapp/data/dashboard.dart';

abstract class DashboardState extends Equatable {
  @override
  List<Object> get props => [];
}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final Dashboard dashboard;

  DashboardLoaded(this.dashboard);

  @override
  List<Object> get props => [];
}

class DashboardError extends DashboardState {}
