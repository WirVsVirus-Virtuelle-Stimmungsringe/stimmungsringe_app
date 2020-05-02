import 'package:equatable/equatable.dart';

abstract class UserSettingsState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserSettingsUninitialized extends UserSettingsState {}

class UserSettingsLoading extends UserSettingsState {}

class ShowCurrentUserSettings extends UserSettingsState {
  final String userName;
  final bool hasName;

  ShowCurrentUserSettings(this.userName, this.hasName);

  @override
  List<Object> get props => [userName, hasName];
}

class GotoOnboarding extends UserSettingsState {}
