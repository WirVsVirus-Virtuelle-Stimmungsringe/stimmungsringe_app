import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Mood {
  final IconData icon;
  final _MoodColors colors;

  const Mood(this.icon, this.colors);

  static final Mood sunny = Mood(FontAwesomeIcons.sun, _MoodColors.good);
  static final Mood sunnyWithClouds =
      Mood(FontAwesomeIcons.cloudSun, _MoodColors.good);
  static final Mood cloudy = Mood(FontAwesomeIcons.cloud, _MoodColors.medium);
  static final Mood windy = Mood(FontAwesomeIcons.wind, _MoodColors.medium);
  static final Mood cloudyNight =
      Mood(FontAwesomeIcons.cloudMoon, _MoodColors.medium);
  static final Mood thundery = Mood(FontAwesomeIcons.bolt, _MoodColors.bad);
}

class _MoodColors {
  final Color startColor;
  final Color endColor;

  const _MoodColors(this.startColor, this.endColor)
      : assert(startColor != null),
        assert(endColor != null);

  static const _MoodColors good =
      _MoodColors(Color(0xff3c9a6b), Color(0xff377371));
  static const _MoodColors medium =
      _MoodColors(Color(0xffedd626), Color(0xfff2770c));
  static const _MoodColors bad =
      _MoodColors(Color(0xff951919), Color(0xffd7670c));
}
