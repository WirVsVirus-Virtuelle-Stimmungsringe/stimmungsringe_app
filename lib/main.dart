import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:stimmungsringeapp/widgets/avatar_row.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Stimmungsringe',
      home: MyHomePage(title: 'Übersicht'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//  _MyHomePageState() : super() {
//    _updateHello();
//  }
//
//  Future<String> _getHelloFromServer() async {
//    String url =
//        'http://wvsvhackvirtuellestimmungsringe-env.eba-eug7bzt6.eu-central-1.elasticbeanstalk.com/stimmungsring/sample';
//    http.Response response = await http.get(url);
//    return json.decode(response.body)['message'];
//  }
//
//  void _updateHello() {
//    _getHelloFromServer().then((hello) => _hello = hello);
//  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.title),
      ),
      child: SafeArea(
        child: Column(
//          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AvatarRow(
              name: 'Avatar',
              image: NetworkImage(
                  'https://2.bp.blogspot.com/-5lSguULPXW4/Tttrmykan6I/AAAAAAAAB_M/AlKHJLOKKO4/s1600/famosos_avatar.jpg'),
              gradientStartColor: Color(0xff941919),
              gradientEndColor: Color(0xffd7670b),
              icon: FontAwesomeIcons.cloud,
            ),
          ],
        ),
      ),
    );
  }
}
