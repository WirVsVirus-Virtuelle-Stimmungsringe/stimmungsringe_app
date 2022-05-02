enum AchievementType { groupSunshineHours, unknownType }

extension AchievementTypeExtension on AchievementType {
  static AchievementType fromJson(String achievementType) {
    return AchievementType.values.firstWhere(
      (type) => type.toString().split(".").last == achievementType,
      orElse: () => AchievementType.unknownType,
    );
  }
}
