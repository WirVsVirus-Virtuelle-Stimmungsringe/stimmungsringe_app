import 'package:equatable/equatable.dart';

class UserSettings extends Equatable {
  final String? userName;
  final bool hasName;
  final String? stockAvatar;

  @override
  List<Object?> get props => [userName, hasName, stockAvatar];

  static UserSettings fromJson(Map<String, dynamic> jsonMap) {
    return UserSettings(
      jsonMap['userName'] as String?,
      jsonMap['hasName'] as bool,
      jsonMap['stockAvatar'] as String?,
    );
  }

  const UserSettings(this.userName, this.hasName, this.stockAvatar);
}
