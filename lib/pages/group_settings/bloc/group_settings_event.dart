import 'package:equatable/equatable.dart';

abstract class GroupSettingsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadSettings extends GroupSettingsEvent {}

class SaveGroupSettings extends GroupSettingsEvent {
  final String groupName;

  SaveGroupSettings({this.groupName});

  @override
  List<Object> get props => [groupName];
}

class LeaveGroup extends GroupSettingsEvent {}
