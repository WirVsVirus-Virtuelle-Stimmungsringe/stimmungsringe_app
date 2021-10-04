import 'package:familiarise/icons/weather_icons.dart';
import 'package:flutter/widgets.dart';

enum Sentiment { sunny, sunnyWithClouds, cloudy, windy, cloudyNight, thundery }

extension SentimentExtension on Sentiment {
  static Sentiment fromJson(String/*!*/ sentimentCode) {
    return Sentiment.values
        .firstWhere((type) => type.toString().split(".").last == sentimentCode);
  }

  IconData get icon {
    switch (this) {
      case Sentiment.sunny:
        return WeatherIcons.sun;
      case Sentiment.sunnyWithClouds:
        return WeatherIcons.cloudSun;
      case Sentiment.cloudy:
        return WeatherIcons.clouds;
      case Sentiment.windy:
        return WeatherIcons.fogCloud;
      case Sentiment.cloudyNight:
        return WeatherIcons.cloudMoon;
      default:
        return WeatherIcons.cloudFlashAlt;
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

  String get defaultSentimentText {
    switch (this) {
      case Sentiment.sunny:
        return "Bin gut drauf";
      case Sentiment.sunnyWithClouds:
        return "Bin heiter";
      case Sentiment.cloudy:
        return "Geht so…";
      case Sentiment.windy:
        return "Ich halte durch";
      case Sentiment.cloudyNight:
        return "Bin müde";
      default:
        return "Frag' lieber nicht…";
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
