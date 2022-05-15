import 'package:equatable/equatable.dart';
import 'package:familiarise/config.dart';

class UserMinimal extends Equatable {
  final String userId;
  final String? displayName;
  final bool hasName;
  final String _avatarSvgUrl;

  @override
  List<Object?> get props => [userId, displayName, hasName, _avatarSvgUrl];

  static UserMinimal fromJson(Map<String, dynamic> jsonMap) {
    return UserMinimal(
      jsonMap['userId'] as String,
      jsonMap['displayName'] as String?,
      jsonMap['hasName'] as bool,
      jsonMap['avatarSvgUrl'] as String,
    );
  }

  const UserMinimal(
    this.userId,
    this.displayName,
    this.hasName,
    this._avatarSvgUrl,
  ) : assert(hasName == (displayName != null));

  String get avatarSvgUrl {
    return Config().backendUrl + _avatarSvgUrl;
  }
}
