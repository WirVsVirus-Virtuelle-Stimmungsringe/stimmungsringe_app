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
  final IconData icon;
  final _SentimentColors colors;

  const Sentiment(this.icon, this.colors);

  static final Sentiment sunny =
      const Sentiment(FontAwesomeIcons.sun, _SentimentColors.good);
  static final Sentiment sunnyWithClouds =
      const Sentiment(FontAwesomeIcons.cloudSun, _SentimentColors.good);
  static final Sentiment cloudy =
      const Sentiment(FontAwesomeIcons.cloud, _SentimentColors.medium);
  static final Sentiment windy =
      const Sentiment(FontAwesomeIcons.wind, _SentimentColors.medium);
  static final Sentiment cloudyNight =
      const Sentiment(FontAwesomeIcons.cloudMoon, _SentimentColors.medium);
  static final Sentiment thundery =
      const Sentiment(FontAwesomeIcons.bolt, _SentimentColors.bad);

  static final List<Sentiment> all = [
    sunny,
    sunnyWithClouds,
    cloudy,
    windy,
    cloudyNight,
    thundery
  ];

  static Sentiment fromSentiment(SentimentStatus sentimentStatus) {
    //backend SNOWFLAKE, SMOG, CLOUD_RAIN, CLOUD, CLOUD_SUN, SUN
    var map = {
      'SNOWFLAKE': Sentiment.all[5],
      'SMOG': Sentiment.all[4],
      'CLOUD_RAIN': Sentiment.all[3],
      'CLOUD': Sentiment.all[2],
      'CLOUD_SUN': Sentiment.all[1],
      'SUN': Sentiment.all[0],
    };

    final Sentiment sentiment = map[sentimentStatus.sentimentCode];
    assert(sentiment != null);
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
