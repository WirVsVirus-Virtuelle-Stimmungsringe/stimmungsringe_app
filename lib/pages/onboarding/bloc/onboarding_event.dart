import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckUserEvent extends OnboardingEvent {}

class ShowCreateNewGroupFormEvent extends OnboardingEvent {}

class CreateNewGroupEvent extends OnboardingEvent {
  final String groupName;

  CreateNewGroupEvent(this.groupName);

  @override
  List<Object> get props => [groupName];
}

class ShowJoinGroupFormEvent extends OnboardingEvent {}

class JoinGroupEvent extends OnboardingEvent {
  final String groupCode;

  JoinGroupEvent(this.groupCode);

  @override
  List<Object> get props => [groupCode];
}
