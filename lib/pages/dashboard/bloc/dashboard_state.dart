import 'package:equatable/equatable.dart';
import 'package:familiarise/data/achievement.dart';
import 'package:familiarise/data/dashboard.dart';
import 'package:familiarise/data/message.dart';

abstract class StateWithData {
  Dashboard? get dashboard;

  MessageInbox? get inbox;

  DateTime? get now;
}

abstract class DashboardState extends Equatable {
  bool get hasDashboard;

  @override
  List<Object?> get props => [];
}

class DashboardUninitialized extends DashboardState {
  @override
  bool get hasDashboard => false;
}

class DashboardLoading extends DashboardState implements StateWithData {
  @override
  final Dashboard? dashboard;
  @override
  final MessageInbox? inbox;
  @override
  final DateTime? now;

  DashboardLoading({
    this.dashboard,
    this.inbox,
    this.now,
  }) : assert(
          (dashboard == null && inbox == null && now == null) ||
              (dashboard != null && inbox != null && now != null),
        );

  factory DashboardLoading.fromDashboardState(
    DashboardState dashboardState, {
    Dashboard? dashboard,
    MessageInbox? inbox,
    DateTime? now,
  }) {
    if (dashboardState.hasDashboard) {
      final StateWithData stateWithData = dashboardState as StateWithData;
      return DashboardLoading(
        dashboard: dashboard ?? stateWithData.dashboard,
        inbox: inbox ?? stateWithData.inbox,
        now: now ?? stateWithData.now,
      );
    } else {
      return DashboardLoading();
    }
  }

  @override
  bool get hasDashboard => dashboard != null;

  @override
  List<Object?> get props => [dashboard, inbox, now];
}

class UnseenAchievement extends DashboardState implements StateWithData {
  final Achievement unseenAchievement;
  @override
  final Dashboard? dashboard;
  @override
  final MessageInbox? inbox;
  @override
  final DateTime? now;

  UnseenAchievement({
    required this.unseenAchievement,
    this.dashboard,
    this.inbox,
    this.now,
  }) : assert(
          (dashboard == null && inbox == null && now == null) ||
              (dashboard != null && inbox != null && now != null),
        );

  factory UnseenAchievement.fromDashboardState(
    DashboardState dashboardState, {
    Achievement? unseenAchievement,
    Dashboard? dashboard,
    MessageInbox? inbox,
    DateTime? now,
  }) {
    if (unseenAchievement == null && dashboardState is UnseenAchievement) {
      unseenAchievement = dashboardState.unseenAchievement;
    }
    assert(unseenAchievement != null);

    if (dashboardState.hasDashboard) {
      final StateWithData stateWithData = dashboardState as StateWithData;
      return UnseenAchievement(
        unseenAchievement: unseenAchievement!,
        dashboard: dashboard ?? stateWithData.dashboard,
        inbox: inbox ?? stateWithData.inbox,
        now: now ?? stateWithData.now,
      );
    } else {
      return UnseenAchievement(
        unseenAchievement: unseenAchievement!,
      );
    }
  }

  @override
  bool get hasDashboard => dashboard != null;

  @override
  List<Object?> get props => [unseenAchievement, dashboard, inbox, now];
}

class DashboardLoaded extends DashboardState implements StateWithData {
  @override
  final Dashboard dashboard;
  @override
  final MessageInbox inbox;
  @override
  final DateTime now;

  DashboardLoaded({
    required this.dashboard,
    required this.inbox,
    required this.now,
  });

  factory DashboardLoaded.fromDashboardState(
    DashboardState dashboardState, {
    Dashboard? dashboard,
    MessageInbox? inbox,
    DateTime? now,
  }) {
    assert(dashboardState.hasDashboard);

    final StateWithData stateWithData = dashboardState as StateWithData;
    return DashboardLoaded(
      dashboard: dashboard ?? stateWithData.dashboard!,
      inbox: inbox ?? stateWithData.inbox!,
      now: now ?? stateWithData.now!,
    );
  }

  @override
  bool get hasDashboard => true;

  @override
  List<Object> get props => [dashboard, inbox, now];
}

class DashboardError extends DashboardState implements StateWithData {
  @override
  final Dashboard? dashboard;
  @override
  final MessageInbox? inbox;
  @override
  final DateTime? now;

  DashboardError({this.dashboard, this.inbox, this.now})
      : assert(
          (dashboard == null && inbox == null && now == null) ||
              (dashboard != null && inbox != null && now != null),
        );

  factory DashboardError.fromDashboardState(
    DashboardState dashboardState, {
    Dashboard? dashboard,
    MessageInbox? inbox,
    DateTime? now,
  }) {
    if (dashboardState.hasDashboard) {
      final StateWithData stateWithData = dashboardState as StateWithData;
      return DashboardError(
        dashboard: dashboard ?? stateWithData.dashboard,
        inbox: inbox ?? stateWithData.inbox,
        now: now ?? stateWithData.now,
      );
    } else {
      return DashboardError();
    }
  }

  @override
  bool get hasDashboard => dashboard != null;

  @override
  List<Object?> get props => [dashboard, inbox, now];
}
