import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stimmungsringeapp/data/freezed_classes.dart';

class SentimentUi {
  final String sentimentCode;
  final IconData icon;
  final _SentimentColors colors;

  const SentimentUi(this.sentimentCode, this.icon, this.colors)
      : assert(sentimentCode != null),
        assert(icon != null),
        assert(colors != null);

  static final SentimentUi sunny =
      const SentimentUi('sunny', FontAwesomeIcons.sun, _SentimentColors.good);
  static final SentimentUi sunnyWithClouds = const SentimentUi(
      'sunnyWithClouds', FontAwesomeIcons.cloudSun, _SentimentColors.good);
  static final SentimentUi cloudy = const SentimentUi(
      'cloudy', FontAwesomeIcons.cloud, _SentimentColors.medium);
  static final SentimentUi windy = const SentimentUi(
      'windy', FontAwesomeIcons.wind, _SentimentColors.medium);
  static final SentimentUi cloudyNight = const SentimentUi(
      'cloudyNight', FontAwesomeIcons.cloudMoon, _SentimentColors.medium);
  static final SentimentUi thundery = const SentimentUi(
      'thundery', FontAwesomeIcons.bolt, _SentimentColors.bad);

  static final List<SentimentUi> all = [
    sunny,
    sunnyWithClouds,
    cloudy,
    windy,
    cloudyNight,
    thundery
  ];

  static SentimentUi fromSentiment(Sentiment sentiment) {
    var map = {
      'thundery': thundery,
      'cloudyNight': cloudyNight,
      'windy': windy,
      'cloudy': cloudy,
      'sunnyWithClouds': sunnyWithClouds,
      'sunny': sunny,
    };

    final SentimentUi sentimentUi = map[sentiment.sentiment];
    assert(
        sentimentUi != null, 'Undefined sentiment code ' + sentiment.sentiment);
    return sentimentUi;
  }

  Sentiment toSentiment() {
    return Sentiment(sentimentCode);
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
