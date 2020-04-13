import 'package:equatable/equatable.dart';

abstract class UserSettingsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadUserSettings extends UserSettingsEvent {}

class SaveUserSettings extends UserSettingsEvent {
  final String userName;

  SaveUserSettings({this.userName});

  @override
  List<Object> get props => [userName];
}

class LeaveGroup extends UserSettingsEvent {}
