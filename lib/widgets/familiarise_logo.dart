import 'package:flutter/cupertino.dart';

class FamiliariseLogo extends StatelessWidget {
  const FamiliariseLogo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    final bool isDarkTheme = brightnessValue == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Image.asset(
        isDarkTheme
            ? 'assets/images/familiarise_logo_dark_bg.png'
            : 'assets/images/familiarise_logo_light_bg.png',
        width: 250,
      ),
    );
  }
}
