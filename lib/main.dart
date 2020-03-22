import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stimmungsringeapp/pages/overview.dart';


void main() {
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(StimmungslagenApp());
}

class StimmungslagenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Stimmungsringe',
      home: OverviewPage(
        addButtonClick: () {
          debugPrint('add button clicked!');
        },
      ),
    );
  }
}
