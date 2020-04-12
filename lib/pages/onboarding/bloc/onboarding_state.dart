import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  @override
  List<Object> get props => [];
}

/// check if user is already configured
class CheckingUser extends OnboardingState {}

class GotoDashboard extends OnboardingState {}

class OnboardingIntro extends OnboardingState {}

class StartNewGroupInitial extends OnboardingState {}

class StartNewGroupSuccess extends OnboardingState {
  final String groupName;

  StartNewGroupSuccess({this.groupName});
}

class FindGroupInitial extends OnboardingState {}

class FindGroupSearching extends OnboardingState {}

class FindGroupSuccess extends OnboardingState {
  final String groupName;

  FindGroupSuccess({this.groupName});
}

class FindGroupNotFound extends OnboardingState {}
