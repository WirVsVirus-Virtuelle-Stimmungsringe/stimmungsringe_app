import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Mood {
  final IconData icon;
  final _MoodColors colors;

  const Mood(this.icon, this.colors);

  static final Mood sunny = const Mood(FontAwesomeIcons.sun, _MoodColors.good);
  static final Mood sunnyWithClouds =
      const Mood(FontAwesomeIcons.cloudSun, _MoodColors.good);
  static final Mood cloudy =
      const Mood(FontAwesomeIcons.cloud, _MoodColors.medium);
  static final Mood windy =
      const Mood(FontAwesomeIcons.wind, _MoodColors.medium);
  static final Mood cloudyNight =
      const Mood(FontAwesomeIcons.cloudMoon, _MoodColors.medium);
  static final Mood thundery =
      const Mood(FontAwesomeIcons.bolt, _MoodColors.bad);

  static final List<Mood> allMoods = [
    sunny,
    sunnyWithClouds,
    cloudy,
    windy,
    cloudyNight,
    thundery
  ];
}

class _MoodColors {
  final Color startColor;
  final Color endColor;

  const _MoodColors(this.startColor, this.endColor)
      : assert(startColor != null),
        assert(endColor != null);

  static const _MoodColors good =
      const _MoodColors(const Color(0xff3c9a6b), const Color(0xff377371));
  static const _MoodColors medium =
      const _MoodColors(const Color(0xffedd626), const Color(0xfff2770c));
  static const _MoodColors bad =
      const _MoodColors(const Color(0xff951919), const Color(0xffd7670c));
}
