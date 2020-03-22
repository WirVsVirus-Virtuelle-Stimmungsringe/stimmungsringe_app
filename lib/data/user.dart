class UserMinimal {
  String userId;
  String displayName;

  UserMinimal.fromJson(Map<String, dynamic> jsonMap) {
    this.userId = jsonMap['userId'];
    this.displayName = jsonMap['displayName'];
  }
}
