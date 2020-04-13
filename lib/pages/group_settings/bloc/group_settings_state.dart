import 'package:equatable/equatable.dart';

abstract class GroupSettingsState extends Equatable {
  @override
  List<Object> get props => [];
}

class SettingsLoading extends GroupSettingsState {}

class ShowCurrentSettings extends GroupSettingsState {
  final String groupName;
  final String groupCode;

  ShowCurrentSettings(this.groupName, this.groupCode);

  List<Object> get props => [groupName, groupCode];
}

class GotoOnboarding extends GroupSettingsState {}
