import 'package:equatable/equatable.dart';

class SigninUserResponse extends Equatable {
  final String userId;
  final bool hasGroup;
  final String groupId;
  final String groupName;

  static SigninUserResponse fromJson(Map<String, dynamic> jsonMap) {
    return SigninUserResponse(
      jsonMap['userId'] as String,
      jsonMap['hasGroup'] as bool,
      jsonMap['groupId'] as String,
      jsonMap['groupName'] as String,
    );
  }

  const SigninUserResponse(
      this.userId, this.hasGroup, this.groupId, this.groupName);

  @override
  List<Object> get props => [userId, hasGroup, groupId, groupName];
}

class StartNewGroupResponse extends Equatable {
  final String groupId;
  final String groupName;

  static StartNewGroupResponse fromJson(Map<String, dynamic> jsonMap) {
    return StartNewGroupResponse(
      jsonMap['groupId'] as String,
      jsonMap['groupName'] as String,
    );
  }

  const StartNewGroupResponse(this.groupId, this.groupName);

  @override
  List<Object> get props => [groupId, groupName];
}

class FindGroupResponse extends Equatable {
  final String groupId;
  final String groupName;

  static FindGroupResponse fromJson(Map<String, dynamic> jsonMap) {
    return FindGroupResponse(
      jsonMap['groupId'] as String,
      jsonMap['groupName'] as String,
    );
  }

  const FindGroupResponse(this.groupId, this.groupName);

  @override
  List<Object> get props => [groupId, groupName];
}

class UserSettingsResponse extends Equatable {
  final String userName;
  final bool hasName;

  static UserSettingsResponse fromJson(Map<String, dynamic> jsonMap) {
    return UserSettingsResponse(
      jsonMap['userName'] as String,
      jsonMap['hasName'] as bool,
    );
  }

  const UserSettingsResponse(this.userName, this.hasName);

  @override
  List<Object> get props => [userName, hasName];
}

class GroupSettingsResponse extends Equatable {
  final String groupId;
  final String groupName;
  final String groupCode;

  static GroupSettingsResponse fromJson(Map<String, dynamic> jsonMap) {
    return GroupSettingsResponse(
      jsonMap['groupId'] as String,
      jsonMap['groupName'] as String,
      jsonMap['groupCode'] as String,
    );
  }

  const GroupSettingsResponse(this.groupId, this.groupName, this.groupCode);

  @override
  List<Object> get props => [groupId, groupName, groupCode];
}
