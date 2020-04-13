import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckUser extends OnboardingEvent {}

class BeginStartNewGroup extends OnboardingEvent {}

class StartNewGroup extends OnboardingEvent {
  final String groupName;

  StartNewGroup(this.groupName) : assert(groupName != null);
}

class BeginJoinGroup extends OnboardingEvent {}

class SearchGroup extends OnboardingEvent {
  final String groupCode;

  SearchGroup(this.groupCode) : assert(groupCode != null);

  @override
  List<Object> get props => [groupCode];
}
