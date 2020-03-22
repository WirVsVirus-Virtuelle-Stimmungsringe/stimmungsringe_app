import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'datamappings.dart';


class UserMinimal {
  String userId;
  String displayName;

  UserMinimal.fromJson(Map<String, dynamic> jsonMap) {
    this.userId = jsonMap['userId'];
    this.displayName = jsonMap['displayName'];
  }
}

class SentimentStatus {
  String sentimentCode;

  SentimentStatus.fromJson(Map<String, dynamic> jsonMap) {
    // e.g .CLOUD_RAIN
    this.sentimentCode = jsonMap['sentiment']['sentimentCode'];
  }
}

class MyTile {
  UserMinimal user;
  SentimentStatus sentimentStatus;

  MyTile.fromJson(Map<String, dynamic> jsonMap) {
    this.user = UserMinimal.fromJson(jsonMap['user']);
    this.sentimentStatus = SentimentStatus.fromJson(jsonMap['sentimentStatus']);
  }
}

class OtherTile {
  UserMinimal user;
  SentimentStatus sentimentStatus;

  OtherTile.fromJson(Map<String, dynamic> jsonMap) {
    this.user = UserMinimal.fromJson(jsonMap['user']);
    this.sentimentStatus = SentimentStatus.fromJson(jsonMap['sentimentStatus']);
  }
}

class Dashboard {
  MyTile myTile;
  List<OtherTile> otherTiles;

  Dashboard.fromJson(Map<String, dynamic> jsonMap) {
    this.myTile = new MyTile.fromJson(jsonMap['myTile']);

    final _otherTiles = (jsonMap['otherTiles'] as List);
    this.otherTiles = _otherTiles.map((tileJson) =>
      new OtherTile.fromJson(tileJson)
    ).toList();

  }
}




class HierGehtsWeiterPage extends StatefulWidget {
  HierGehtsWeiterPage({Key key, this.title}) : super(key: key) {
    debugPrint('asdfsdfsdf');


  }

  final String title;

  @override
  _HierGehtsWeiterPageState createState() => _HierGehtsWeiterPageState();

}

class _HierGehtsWeiterPageState extends State<HierGehtsWeiterPage> {
  var _textControllerName = TextEditingController();
  var _textControllerEmail = TextEditingController();

  Future<String> loadSampleData() async {

    String url = 'http://wvsvhackvirtuellestimmungsringe-env.eba-eug7bzt6.eu-central-1.elasticbeanstalk.com/stimmungsring/sample';

    http.Response response = await http.get(
        url, headers: {
          'X-User-ID': 'cafecafe-b855-46ba-b907-321d2d38beef'
    });



    //log(dashboard.toString());

    return response.body;
  }



  Future<String> loadDashboardPageData() async {

    String url = 'http://wvsvhackvirtuellestimmungsringe-env.eba-eug7bzt6.eu-central-1.elasticbeanstalk.com/stimmungsring/dashboard';

    http.Response response = await http.get(
        url, headers: {
      'X-User-ID': 'cafecafe-b855-46ba-b907-321d2d38beef'
    });

    const sampleJson = """
    {
          "myTile": {
              "user": {
                  "userId": "cafecafe-b855-46ba-b907-321d2d38beef",
                  "displayName": "Mutti"
              },
              "sentimentStatus": {
                  "sentiment": {
                      "sentimentCode": "CLOUD_RAIN"
                  }
              }
          },
          "otherTiles": [
              {
                  "user": {
                      "userId": "12340000-b855-46ba-b907-321d2d38feeb",
                      "displayName": "Timmy"
                  },
                  "sentimentStatus": {
                      "sentiment": {
                          "sentimentCode": "SMOG"
                      }
                  }
              }
          ]
      }
      """;


    //var user = UserMinimal.fromJson(json.decode(userJson));
    // log(user.toString());

    var dashboard = Dashboard.fromJson(json.decode(sampleJson));
    log(dashboard.toString());



   // log(response.body);


    //var dashboard = Dashboard.fromJson(json.decode(response.body));





    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child:
          Column(
            children: [
              new Text('weiter hfasdfadsfsdfasdfe'),
              RaisedButton(child: Text('Load Data'),
              onPressed: () {
                log('loading..');

                loadDashboardPageData().then((bodyAsString) => log('got body'))
                  .catchError((err) => log('error loading data ' + err.toString()));

              },)
            ],
          )

      ,);
  }
}
