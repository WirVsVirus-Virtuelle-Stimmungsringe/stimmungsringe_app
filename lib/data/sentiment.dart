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
        return const _SentimentColors(Color(0xfffcd16f), Color(0xfff85600));
      case Sentiment.sunnyWithClouds:
        return const _SentimentColors(Color(0xfffcd16f), Color(0xffb1beca));
      case Sentiment.cloudy:
        return const _SentimentColors(Color(0xffc0dff5), Color(0xffb1beca));
      case Sentiment.windy:
        return const _SentimentColors(Color(0xff8a919b), Color(0xff23262d));
      case Sentiment.cloudyNight:
        return const _SentimentColors(Color(0xff09436f), Color(0xff00223b));
      default:
        return const _SentimentColors(Color(0xff1e2848), Color(0xff5c2f57));
    }
  }

  Color get avatarIconBackgroundColor {
    switch (this) {
      case Sentiment.sunny:
        return const Color(0xff7494ab);
      case Sentiment.sunnyWithClouds:
        return const Color(0xff7494ab);
      case Sentiment.cloudy:
        return const Color(0xff7494ab);
      case Sentiment.windy:
        return const Color(0xff7494ab);
      case Sentiment.cloudyNight:
        return const Color(0xff7494ab);
      default:
        return const Color(0xff7494ab);
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
