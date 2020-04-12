import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  @override
  List<Object> get props => [];
}

/// check if user is already configured
class CheckingUser extends OnboardingState {}

class GotoDashboard extends OnboardingState {}

// user is not configured - ask her, what to do
class OnboardingIntro extends OnboardingState {}

class StartNewGroupInitial extends OnboardingState {}

// goto dashboard
class StartNewGroupSuccess extends OnboardingState {
  final String groupName;

  StartNewGroupSuccess({this.groupName});
}

class StartNewGroupFailedConflict extends OnboardingState {
  final String groupName;

  StartNewGroupFailedConflict({this.groupName});
}

class FindGroupInitial extends OnboardingState {}

class FindGroupSearching extends OnboardingState {}

// goto dashboard
class FindGroupSuccess extends OnboardingState {
  final String groupName;

  FindGroupSuccess({this.groupName});
}

class FindGroupNotFound extends OnboardingState {}
