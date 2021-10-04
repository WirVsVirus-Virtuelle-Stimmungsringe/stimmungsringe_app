import 'package:equatable/equatable.dart';

abstract class UserSettingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUserSettings extends UserSettingsEvent {}

class SaveUserSettings extends UserSettingsEvent {
  final String? userName;
  final String? stockAvatar;

  SaveUserSettings({this.userName, this.stockAvatar});

  @override
  List<Object?> get props => [userName, stockAvatar];
}

class LeaveGroup extends UserSettingsEvent {}
