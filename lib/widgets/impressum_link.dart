import 'package:familiarise/pages/about/impressum_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImpressumLink {
  static Widget buildImpressumLink(BuildContext context) {
    return GestureDetector(
      child: Text(
        'Impressum',
        style:
            TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
      ),
      onTap: () {
        Navigator.pushNamed(context, ImpressumPage.routeUri);
      },
    );
  }
}
