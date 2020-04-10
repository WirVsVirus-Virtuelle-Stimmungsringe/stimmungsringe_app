import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  @override
  List<Object> get props => [];
}

/// check if user is already configured
class CheckingUser extends OnboardingState {}

class GotoDashboard extends OnboardingState {}

class FindGroupInitial extends OnboardingState {}

class FindGroupSearching extends OnboardingState {}

class FindGroupSuccess extends OnboardingState {}

class FindGroupNotFound extends OnboardingState {}
