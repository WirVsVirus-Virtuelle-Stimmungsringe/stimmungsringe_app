class SigninUserResponse {
  final bool hasGroup;
  final String groupName;

  static SigninUserResponse fromJson(Map<String, dynamic> jsonMap) {
    return SigninUserResponse(
      jsonMap['hasGroup'] as bool,
      jsonMap['groupName'] as String,
    );
  }

  const SigninUserResponse(this.hasGroup, this.groupName);
}
