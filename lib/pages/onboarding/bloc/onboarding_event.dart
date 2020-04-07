import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckUser extends OnboardingEvent {}

class SearchGroup extends OnboardingEvent {
  final String groupCode;

  SearchGroup(this.groupCode) : assert(groupCode != null);

  @override
  List<Object> get props => [groupCode];
}
