enum AchievementPageType { avatarWithText, unknownPage }

extension AchievementPageTypeExtension on AchievementPageType {
  static AchievementPageType fromJson(String achievementPageType) {
    return AchievementPageType.values.firstWhere(
      (type) => type.toString().split(".").last == achievementPageType,
      orElse: () => AchievementPageType.unknownPage,
    );
  }
}
