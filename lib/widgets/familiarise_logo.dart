import 'package:flutter/cupertino.dart';

class FamiliariseLogo extends StatelessWidget {
  final double width;

  const FamiliariseLogo({Key key, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Image.asset(
        isDarkTheme
            ? 'assets/images/familiarise_logo_dark_bg.png'
            : 'assets/images/familiarise_logo_light_bg.png',
        width: width ?? 250,
      ),
    );
  }
}
