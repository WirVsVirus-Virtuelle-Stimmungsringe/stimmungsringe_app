import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Sentiment { sunny, sunnyWithClouds, cloudy, windy, cloudyNight, thundery }

Sentiment sentimentFromJson(String sentimentCode) {
  return Sentiment.values
      .firstWhere((type) => type.toString().split(".").last == sentimentCode);
}

extension SentimentExtension on Sentiment {
  IconData get icon {
    switch (this) {
      case Sentiment.sunny:
        return FontAwesomeIcons.sun;
      case Sentiment.sunnyWithClouds:
        return FontAwesomeIcons.cloudSun;
      case Sentiment.cloudy:
        return FontAwesomeIcons.cloud;
      case Sentiment.windy:
        return FontAwesomeIcons.wind;
      case Sentiment.cloudyNight:
        return FontAwesomeIcons.cloudMoon;
      default:
        return FontAwesomeIcons.bolt;
    }
  }

  _SentimentColors get colors {
    switch (this) {
      case Sentiment.sunny:
        return _SentimentColors.good;
      case Sentiment.sunnyWithClouds:
        return _SentimentColors.good;
      case Sentiment.cloudy:
        return _SentimentColors.medium;
      case Sentiment.windy:
        return _SentimentColors.medium;
      case Sentiment.cloudyNight:
        return _SentimentColors.medium;
      default:
        return _SentimentColors.bad;
    }
  }

  String get sentimentCode {
    return toString().split('.').last;
  }
}

class _SentimentColors {
  final Color startColor;
  final Color endColor;

  const _SentimentColors(this.startColor, this.endColor)
      : assert(startColor != null),
        assert(endColor != null);

  static const _SentimentColors good =
      const _SentimentColors(const Color(0xff3c9a6b), const Color(0xff377371));
  static const _SentimentColors medium =
      const _SentimentColors(const Color(0xffedd626), const Color(0xfff2770c));
  static const _SentimentColors bad =
      const _SentimentColors(const Color(0xff951919), const Color(0xffd7670c));
}
