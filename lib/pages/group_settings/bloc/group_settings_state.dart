import 'package:equatable/equatable.dart';

abstract class GroupSettingsState extends Equatable {
  @override
  List<Object> get props => [];
}

class GroupSettingsLoading extends GroupSettingsState {}

class ShowCurrentGroupSettings extends GroupSettingsState {
  final String groupName;
  final String groupCode;

  ShowCurrentGroupSettings(this.groupName, this.groupCode);

  @override
  List<Object> get props => [groupName, groupCode];
}

class GotoOnboarding extends GroupSettingsState {}
