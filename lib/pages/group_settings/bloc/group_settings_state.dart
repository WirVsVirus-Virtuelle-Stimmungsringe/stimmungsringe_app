import 'package:equatable/equatable.dart';

abstract class GroupSettingsState extends Equatable {
  @override
  List<Object> get props => [];
}

class SettingsLoading extends GroupSettingsState {}

class ShowCurrentSettings extends GroupSettingsState {
  final String groupName;
  final String groupCode;
  final String userName;

  ShowCurrentSettings(this.groupName, this.groupCode, this.userName);

  List<Object> get props => [groupName, groupCode, userName];
}

class GotoOnboarding extends GroupSettingsState {}
