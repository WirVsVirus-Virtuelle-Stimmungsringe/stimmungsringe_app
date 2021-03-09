import 'package:familiarise/pages/about/impressum_page.dart';
import 'package:flutter/cupertino.dart';

class ImpressumLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ImpressumPage.routeUri);
      },
      child: const Text(
        'Impressum',
        style: TextStyle(
            color: CupertinoColors.link, decoration: TextDecoration.underline),
      ),
    );
  }
}
