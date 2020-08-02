import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Sentiment { sunny, sunnyWithClouds, cloudy, windy, cloudyNight, thundery }

extension SentimentExtension on Sentiment {
  static Sentiment fromJson(String sentimentCode) {
    return Sentiment.values
        .firstWhere((type) => type.toString().split(".").last == sentimentCode);
  }

  IconData get icon {
    switch (this) {
      case Sentiment.sunny:
        return FontAwesomeIcons.solidSun;
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
        return const _SentimentColors(Color(0xfff1db30), Color(0xfff78a07));
      case Sentiment.sunnyWithClouds:
        return const _SentimentColors(Color(0xfff78a07), Color(0xffd55a38));
      case Sentiment.cloudy:
        return const _SentimentColors(Color(0xffd55a38), Color(0xffd95ae6));
      case Sentiment.windy:
        return const _SentimentColors(Color(0xffd95ae6), Color(0xff8e3ecd));
      case Sentiment.cloudyNight:
        return const _SentimentColors(Color(0xff8e3ecd), Color(0xff324398));
      default:
        return const _SentimentColors(Color(0xff324398), Color(0xff05114d));
    }
  }

  Color get avatarIconBackgroundColor {
    switch (this) {
      case Sentiment.sunny:
        return const Color(0xfff78a07);
      case Sentiment.sunnyWithClouds:
        return const Color(0xffd55a38);
      case Sentiment.cloudy:
        return const Color(0xffd95ae6);
      case Sentiment.windy:
        return const Color(0xff903fce);
      case Sentiment.cloudyNight:
        return const Color(0xff324398);
      default:
        return const Color(0xff05114d);
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
}
