import 'dart:convert';
import 'dart:ui';

import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:familiarise/config.dart';
import 'package:familiarise/data/achievement_page_type.dart';
import 'package:familiarise/data/achievement_type.dart';

class Achievement extends Equatable {
  final AchievementType achievementType;
  final int level;
  final AchievementPageType pageType;
  final String headline;
  final String bodyText;
  final String _avatarUrl;
  final BuiltList<Color> gradientColors;

  @override
  List<Object?> get props => [
        achievementType,
        level,
        pageType,
        headline,
        bodyText,
        _avatarUrl,
        gradientColors,
      ];

  static Achievement fromJson(Map<String, dynamic> jsonMap) {
    return Achievement(
      AchievementTypeExtension.fromJson(jsonMap['achievementType'] as String),
      jsonMap['level'] as int,
      AchievementPageTypeExtension.fromJson(
        jsonMap['pageType'] as String,
      ),
      jsonMap['headline'] as String,
      jsonMap['bodyText'] as String,
      jsonMap['avatarUrl'] as String,
      BuiltList.of(
        (jsonMap['gradientColors'] as List<dynamic>).map((dynamic color) {
          final colorEntry = color as Map<String, dynamic>;

          if (colorEntry['rgba'] != null) {
            final rgbaParts = colorEntry['rgba'] as List<dynamic>;
            return Color.fromRGBO(
              rgbaParts[0] as int,
              rgbaParts[1] as int,
              rgbaParts[2] as int,
              rgbaParts[3] as double,
            );
          }

          throw UnsupportedError(
            'unknown color format: ${jsonEncode(colorEntry)}',
          );
        }),
      ),
    );
  }

  const Achievement(
    this.achievementType,
    this.level,
    this.pageType,
    this.headline,
    this.bodyText,
    this._avatarUrl,
    this.gradientColors,
  );

  String get avatarUrl {
    return Config().backendUrl + _avatarUrl;
  }
}
