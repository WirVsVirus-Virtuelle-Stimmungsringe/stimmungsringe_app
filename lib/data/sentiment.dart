import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Sentiment extends Equatable {
  final String sentimentCode;
  @JsonKey(ignore: true)
  IconData icon;
  @JsonKey(ignore: true)
  _SentimentColors colors;

  factory Sentiment.fromJson(String json) {
    return _fromSentimentCode(json);
  }

  Sentiment(this.sentimentCode)
      : assert(sentimentCode != null),
        super() {
    final Sentiment sentiment = _fromSentimentCode(sentimentCode);
    icon = sentiment.icon;
    colors = sentiment.colors;
  }

  Sentiment._(this.sentimentCode, this.icon, this.colors)
      : assert(sentimentCode != null),
        assert(icon != null),
        assert(colors != null),
        super();

  static final Sentiment sunny =
      Sentiment._('sunny', FontAwesomeIcons.sun, _SentimentColors.good);
  static final Sentiment sunnyWithClouds = Sentiment._(
      'sunnyWithClouds', FontAwesomeIcons.cloudSun, _SentimentColors.good);
  static final Sentiment cloudy =
      Sentiment._('cloudy', FontAwesomeIcons.cloud, _SentimentColors.medium);
  static final Sentiment windy =
      Sentiment._('windy', FontAwesomeIcons.wind, _SentimentColors.medium);
  static final Sentiment cloudyNight = Sentiment._(
      'cloudyNight', FontAwesomeIcons.cloudMoon, _SentimentColors.medium);
  static final Sentiment thundery =
      Sentiment._('thundery', FontAwesomeIcons.bolt, _SentimentColors.bad);

  static final List<Sentiment> all = [
    sunny,
    sunnyWithClouds,
    cloudy,
    windy,
    cloudyNight,
    thundery
  ];

  static Sentiment _fromSentimentCode(String sentimentCode) {
    final Map<String, Sentiment> map = {
      'thundery': thundery,
      'cloudyNight': cloudyNight,
      'windy': windy,
      'cloudy': cloudy,
      'sunnyWithClouds': sunnyWithClouds,
      'sunny': sunny,
    };

    final Sentiment sentiment = map[sentimentCode];
    assert(sentiment != null, 'Undefined sentiment code ' + sentimentCode);
    return sentiment;
  }

  @override
  List<Object> get props => [sentimentCode];
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
