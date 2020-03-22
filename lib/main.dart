import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stimmungsringeapp/data/dashboard.dart';
import 'package:stimmungsringeapp/pages/overview.dart';
import 'package:stimmungsringeapp/pages/set_my_sentiment.dart';

void main() {
  // TODO: throws exceptions on start
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(StimmungslagenApp());
}


class StimmungslagenApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StimmungslageState();
  }

}


class _StimmungslageState extends State<StimmungslagenApp> {

  Dashboard _dashboard;

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Stimmungsringe',
      routes: {
        '/': (_) => OverviewPage(dashboard: _dashboard),
        'my-sentiment': (_) => SetOwnSentimentPage(),
      },
    );
  }

  @override
  void initState() {

    loadDashboardPageData().then((dashboard) {

      this.setState(() =>
        _dashboard = dashboard
      );

    });
  }

}


