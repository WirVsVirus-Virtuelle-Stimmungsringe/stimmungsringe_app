import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user.dart';
import 'package:stimmungsringeapp/global_constants.dart';

Future<Dashboard> loadDashboardPageData() async {
  final String url = restUrlDashboard();

  http.Response response = await http.get(
    url,
    headers: {'X-User-ID': sampleUserTimmy},
  );

  var dashboard = Dashboard.fromJson(json.decode(response.body));

  return dashboard;
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
    this.otherTiles = _otherTiles
        .map((tileJson) => new OtherTile.fromJson(tileJson))
        .toList();
  }
}
