import 'package:equatable/equatable.dart';

abstract class UserSettingsState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserSettingsLoading extends UserSettingsState {}

class ShowCurrentUserSettings extends UserSettingsState {
  final String userName;

  ShowCurrentUserSettings(this.userName);

  List<Object> get props => [userName];
}

class GotoOnboarding extends UserSettingsState {}
