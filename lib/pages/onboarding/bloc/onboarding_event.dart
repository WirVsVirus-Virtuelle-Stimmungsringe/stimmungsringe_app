import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckUserEvent extends OnboardingEvent {}

class ShowCreateNewGroupFormEvent extends OnboardingEvent {}

class CreateNewGroupEvent extends OnboardingEvent {
  final String groupName;

  CreateNewGroupEvent(this.groupName) : assert(groupName != null);

  @override
  List<Object> get props => [groupName];
}

class ShowJoinGroupFormEvent extends OnboardingEvent {}

class JoinGroupEvent extends OnboardingEvent {
  final String groupCode;

  JoinGroupEvent(this.groupCode) : assert(groupCode != null);

  @override
  List<Object> get props => [groupCode];
}
