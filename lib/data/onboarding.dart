class SigninUserResponse {
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
}

class StartNewGroupResponse {
  final String groupId;
  final String groupName;

  static StartNewGroupResponse fromJson(Map<String, dynamic> jsonMap) {
    return StartNewGroupResponse(
      jsonMap['groupId'] as String,
      jsonMap['groupName'] as String,
    );
  }

  const StartNewGroupResponse(this.groupId, this.groupName);
}

class FindGroupResponse {
  final String groupId;
  final String groupName;

  static FindGroupResponse fromJson(Map<String, dynamic> jsonMap) {
    return FindGroupResponse(
      jsonMap['groupId'] as String,
      jsonMap['groupName'] as String,
    );
  }

  const FindGroupResponse(this.groupId, this.groupName);
}

class UserSettingsResponse {
  final String userName;

  static UserSettingsResponse fromJson(Map<String, dynamic> jsonMap) {
    return UserSettingsResponse(
      jsonMap['userName'] as String,
    );
  }

  const UserSettingsResponse(this.userName);
}

class GroupSettingsResponse {
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
}

String formatLastUpdateTimestamp(DateTime lastUpdated) {
  if (lastUpdated.isAfter(DateTime.now().add(const Duration(seconds: -120)))) {
    return "gerade eben";
  } else if (lastUpdated
      .isAfter(DateTime.now().add(const Duration(hours: -2)))) {
    final minutes = DateTime.now().difference(lastUpdated).inMinutes;
    return "$minutes Minuten";
  } else {
    final hours = DateTime.now().difference(lastUpdated).inHours;
    return "$hours Stunden";
  }
}
