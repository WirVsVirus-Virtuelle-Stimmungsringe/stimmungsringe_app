import 'package:equatable/equatable.dart';

class UserSettings extends Equatable {
  final String userName;
  final bool hasName;

  @override
  List<Object> get props => [userName, hasName];

  static UserSettings fromJson(Map<String, dynamic> jsonMap) {
    return UserSettings(
      jsonMap['userName'] as String,
      jsonMap['hasName'] as bool,
    );
  }

  const UserSettings(this.userName, this.hasName);
}
