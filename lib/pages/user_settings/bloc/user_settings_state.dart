import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:familiarise/data/available_avatars.dart';

abstract class UserSettingsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserSettingsUninitialized extends UserSettingsState {}

class UserSettingsLoading extends UserSettingsState {}

class UserSettingsLoaded extends UserSettingsState {
  final String? userName;
  final bool hasName;
  final String? stockAvatar;
  final BuiltList<StockAvatar> availableAvatars;

  UserSettingsLoaded(
    this.userName,
    this.hasName,
    this.stockAvatar,
    this.availableAvatars,
  );

  @override
  List<Object?> get props => [userName, hasName, stockAvatar, availableAvatars];
}

class GotoOnboarding extends UserSettingsState {}
