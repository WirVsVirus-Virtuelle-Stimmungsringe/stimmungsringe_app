import 'package:flutter/cupertino.dart';

class FamiliariseLogo extends StatelessWidget {
  final double height;

  const FamiliariseLogo({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      height: height ?? 250,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Image.asset(
        isDarkTheme
            ? 'assets/images/familiarise_logo_dark_bg.png'
            : 'assets/images/familiarise_logo_light_bg.png',
        height: height ?? 250,
      ),
    );
  }
}
