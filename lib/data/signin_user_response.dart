import 'package:equatable/equatable.dart';

class SigninUserResponse extends Equatable {
  final String userId;
  final bool hasGroup;
  final String? groupId;
  final String? groupName;

  @override
  List<Object?> get props => [userId, hasGroup, groupId, groupName];

  static SigninUserResponse fromJson(Map<String, dynamic> jsonMap) {
    return SigninUserResponse(
      jsonMap['userId'] as String,
      jsonMap['hasGroup'] as bool,
      jsonMap['groupId'] as String?,
      jsonMap['groupName'] as String?,
    );
  }

  const SigninUserResponse(
    this.userId,
    this.hasGroup,
    this.groupId,
    this.groupName,
  );
}
