import 'package:equatable/equatable.dart';

abstract class UserSettingsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadUserSettings extends UserSettingsEvent {}

class UpdateUserSettings extends UserSettingsEvent {
  final String userName;

  UpdateUserSettings({this.userName});

  @override
  List<Object> get props => [userName];
}

class LeaveGroup extends UserSettingsEvent {}
