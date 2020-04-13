import 'package:equatable/equatable.dart';

abstract class GroupSettingsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadSettings extends GroupSettingsEvent {}

class UpdateGroupSettings extends GroupSettingsEvent {
  final String groupName;
  final String userName; // TODO rename request dto

  UpdateGroupSettings({this.groupName, this.userName});

  @override
  List<Object> get props => [groupName, userName];
}

class LeaveGroup extends GroupSettingsEvent {}
