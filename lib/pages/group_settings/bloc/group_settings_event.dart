import 'package:equatable/equatable.dart';

abstract class GroupSettingsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadSettings extends GroupSettingsEvent {}

class LeaveGroup extends GroupSettingsEvent {}
