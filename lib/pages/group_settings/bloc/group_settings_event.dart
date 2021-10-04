import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class GroupSettingsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadSettings extends GroupSettingsEvent {}

class SaveGroupSettings extends GroupSettingsEvent {
  final String groupName;

  SaveGroupSettings({@required this.groupName});

  @override
  List<Object> get props => [groupName];
}

class LeaveGroup extends GroupSettingsEvent {}
