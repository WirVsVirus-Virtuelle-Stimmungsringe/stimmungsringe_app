import 'package:equatable/equatable.dart';
import 'package:familiarise/config.dart';

class UserMinimal extends Equatable {
  final String userId;
  final String displayName;
  final bool hasName;
  final String _avatarUrl;

  @override
  List<Object> get props => [userId, displayName, hasName, _avatarUrl];

  static UserMinimal fromJson(Map<String, dynamic> jsonMap) {
    return UserMinimal(
        jsonMap['userId'] as String,
        jsonMap['displayName'] as String,
        jsonMap['hasName'] as bool,
        jsonMap['avatarUrl'] as String);
  }

  const UserMinimal(
      this.userId, this.displayName, this.hasName, this._avatarUrl);

  String get avatarUrl {
    return Config().backendUrl + _avatarUrl;
  }
}
