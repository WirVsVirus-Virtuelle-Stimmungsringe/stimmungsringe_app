import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SentimentStatus {
  String sentimentCode;

  SentimentStatus.fromJson(Map<String, dynamic> jsonMap) {
    // e.g .CLOUD_RAIN
    this.sentimentCode = jsonMap['sentiment']['sentimentCode'];
  }
}

class Sentiment {
  final String name;
  final IconData icon;
  final _SentimentColors colors;

  const Sentiment(this.name, this.icon, this.colors)
      : assert(name != null),
        assert(icon != null),
        assert(colors != null);

  static final Sentiment sunny =
      const Sentiment('sunny', FontAwesomeIcons.sun, _SentimentColors.good);
  static final Sentiment sunnyWithClouds = const Sentiment(
      'sunnyWithClouds', FontAwesomeIcons.cloudSun, _SentimentColors.good);
  static final Sentiment cloudy = const Sentiment(
      'cloudy', FontAwesomeIcons.cloud, _SentimentColors.medium);
  static final Sentiment windy =
      const Sentiment('windy', FontAwesomeIcons.wind, _SentimentColors.medium);
  static final Sentiment cloudyNight = const Sentiment(
      'cloudyNight', FontAwesomeIcons.cloudMoon, _SentimentColors.medium);
  static final Sentiment thundery =
      const Sentiment('thundery', FontAwesomeIcons.bolt, _SentimentColors.bad);

  static final List<Sentiment> all = [
    sunny,
    sunnyWithClouds,
    cloudy,
    windy,
    cloudyNight,
    thundery
  ];

  static Sentiment fromSentimentStatus(SentimentStatus sentimentStatus) {
    var map = {
      // old compat mapping
      'SNOWFLAKE': Sentiment.thundery,
      'SMOG': Sentiment.cloudyNight,
      'CLOUD_RAIN': Sentiment.windy,
      'CLOUD': Sentiment.cloudy,
      'CLOUD_SUN': sunnyWithClouds,
      'SUN': Sentiment.sunny,
      // new mapping
      'thundery': thundery,
      'cloudyNight': cloudyNight,
      'windy': windy,
      'cloudy': cloudy,
      'sunnyWithClouds': sunnyWithClouds,
      'sunny': sunny,
    };

    final Sentiment sentiment = map[sentimentStatus.sentimentCode];
    assert(sentiment != null,
        'Undefined sentiment code ' + sentimentStatus.sentimentCode);
    return sentiment;
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
