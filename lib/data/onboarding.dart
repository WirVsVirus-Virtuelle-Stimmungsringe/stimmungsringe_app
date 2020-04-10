class SigninUserResponse {
  final String userId;
  final bool hasGroup;
  final String groupName;

  static SigninUserResponse fromJson(Map<String, dynamic> jsonMap) {
    return SigninUserResponse(
      jsonMap['userId'] as String,
      jsonMap['hasGroup'] as bool,
      jsonMap['groupName'] as String,
    );
  }

  const SigninUserResponse(this.userId, this.hasGroup, this.groupName);
}

class FindGroupResponse {
  final String groupName;

  static FindGroupResponse fromJson(Map<String, dynamic> jsonMap) {
    return FindGroupResponse(
      jsonMap['groupName'] as String,
    );
  }

  const FindGroupResponse(this.groupName);
}
