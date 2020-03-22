import 'package:flutter/cupertino.dart';
import 'package:stimmungsringeapp/data/dashboard.dart';
import 'package:stimmungsringeapp/pages/overview.dart';
import 'package:stimmungsringeapp/pages/set_my_sentiment.dart';

void main() {
  // TODO: throws exceptions on start
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(SentimentApp());
}

class SentimentApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SentimentAppState();
  }
}

class _SentimentAppState extends State<SentimentApp> {
  Dashboard _dashboard;

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Stimmungsringe',
      routes: {
        '/': (_) => OverviewPage(dashboard: _dashboard),
        'my-sentiment': (_) =>
            SetMySentimentPage(
              dashboard: _dashboard,
              onSentimentChange: (sentiment) {
                if (_dashboard.myTile.sentimentStatus.sentimentCode !=
                    sentiment.name) {
                  setState(() =>
                  _dashboard
                      .myTile.sentimentStatus.sentimentCode = sentiment.name);
                }
              },
            ),
      },
    );
  }

  @override
  void initState() {
    loadDashboardPageData().then((dashboard) {
      this.setState(() => _dashboard = dashboard);
    });
  }
}
