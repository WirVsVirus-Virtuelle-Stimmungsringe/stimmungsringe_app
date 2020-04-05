import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SentimentUi extends Equatable {
  final String sentimentCode;
  @JsonKey(ignore: true)
  IconData icon;
  @JsonKey(ignore: true)
  _SentimentColors colors;

  factory SentimentUi.fromJson(String json) {
    return _fromSentimentCode(json);
  }

  SentimentUi(this.sentimentCode) : assert(sentimentCode != null);

  SentimentUi._(this.sentimentCode, this.icon, this.colors)
      : assert(sentimentCode != null),
        assert(icon != null),
        assert(colors != null);

  static final SentimentUi sunny =
      SentimentUi._('sunny', FontAwesomeIcons.sun, _SentimentColors.good);
  static final SentimentUi sunnyWithClouds = SentimentUi._(
      'sunnyWithClouds', FontAwesomeIcons.cloudSun, _SentimentColors.good);
  static final SentimentUi cloudy =
      SentimentUi._('cloudy', FontAwesomeIcons.cloud, _SentimentColors.medium);
  static final SentimentUi windy =
      SentimentUi._('windy', FontAwesomeIcons.wind, _SentimentColors.medium);
  static final SentimentUi cloudyNight = SentimentUi._(
      'cloudyNight', FontAwesomeIcons.cloudMoon, _SentimentColors.medium);
  static final SentimentUi thundery =
      SentimentUi._('thundery', FontAwesomeIcons.bolt, _SentimentColors.bad);

  static final List<SentimentUi> all = [
    sunny,
    sunnyWithClouds,
    cloudy,
    windy,
    cloudyNight,
    thundery
  ];

  static SentimentUi _fromSentimentCode(String sentimentCode) {
    var map = {
      'thundery': thundery,
      'cloudyNight': cloudyNight,
      'windy': windy,
      'cloudy': cloudy,
      'sunnyWithClouds': sunnyWithClouds,
      'sunny': sunny,
    };

    final SentimentUi sentimentUi = map[sentimentCode];
    assert(sentimentUi != null, 'Undefined sentiment code ' + sentimentCode);
    return sentimentUi;
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
