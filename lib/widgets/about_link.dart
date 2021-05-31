import 'package:familiarise/pages/about/about_page.dart';
import 'package:flutter/cupertino.dart';

class AboutLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AboutPage.routeUri);
      },
      child: const Text(
        'Impressum / Datenschutz',
        style: TextStyle(
            color: CupertinoColors.link, decoration: TextDecoration.underline),
      ),
    );
  }
}
