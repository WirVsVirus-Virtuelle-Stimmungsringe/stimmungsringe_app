import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// check if user is already configured
class CheckingUserState extends OnboardingState {}

class NoOnboardingRequiredState extends OnboardingState {}

// user is not configured - ask her, what to do
class OnboardingIntroState extends OnboardingState {}

class CreateNewGroupFormState extends OnboardingState {}

class CreateNewGroupPendingState extends OnboardingState {}

// goto dashboard
class NewGroupCreatedState extends OnboardingState {
  final String? groupName;

  NewGroupCreatedState({this.groupName});

  @override
  List<Object?> get props => [groupName];
}

class JoinGroupFormState extends OnboardingState {}

class JoinGroupPendingState extends OnboardingState {}

// goto dashboard
class JoinedGroupState extends OnboardingState {
  final String? groupName;

  JoinedGroupState({this.groupName});

  @override
  List<Object?> get props => [groupName];
}

class GroupNotFoundState extends OnboardingState {}
