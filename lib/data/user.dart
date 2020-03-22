

class UserMinimal {
  String userId;
  String displayName;

  UserMinimal.fromJson(Map<String, dynamic> jsonMap) {
    this.userId = jsonMap['userId'];
    this.displayName = jsonMap['displayName'];
  }
}

class SentimentStatus {
  String sentimentCode;

  SentimentStatus.fromJson(Map<String, dynamic> jsonMap) {
    // e.g .CLOUD_RAIN
    this.sentimentCode = jsonMap['sentiment']['sentimentCode'];
  }
}
