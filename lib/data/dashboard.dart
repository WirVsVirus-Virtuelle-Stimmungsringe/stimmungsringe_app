import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:stimmungsringeapp/global_constants.dart';

import 'sentiment.dart';
import 'user.dart';

Future<Dashboard> loadDashboardPageData() async {
  final String url = restUrlDashboard();

  http.Response response = await http.get(
    url,
    headers: {'X-User-ID': sampleUserMutti},
  );

  var dashboard = Dashboard.fromJson(json.decode(response.body));

  return dashboard;
}

class MyTile extends Equatable {
  final UserMinimal user;
  final SentimentStatus sentimentStatus;

  static fromJson(Map<String, dynamic> jsonMap) {
    return MyTile(UserMinimal.fromJson(jsonMap['user']),
        SentimentStatus.fromJson(jsonMap['sentimentStatus']));
  }

  const MyTile(this.user, this.sentimentStatus);

  @override
  List<Object> get props => [user, sentimentStatus];
}

class OtherTile extends Equatable {
  final UserMinimal user;
  final SentimentStatus sentimentStatus;

  static fromJson(Map<String, dynamic> jsonMap) {
    return OtherTile(UserMinimal.fromJson(jsonMap['user']),
        SentimentStatus.fromJson(jsonMap['sentimentStatus']));
  }

  const OtherTile(this.user, this.sentimentStatus);

  @override
  List<Object> get props => [user, sentimentStatus];
}

class Dashboard extends Equatable {
  final MyTile myTile;
  final List<OtherTile> otherTiles;

  static fromJson(Map<String, dynamic> jsonMap) {
    return Dashboard(
        MyTile.fromJson(jsonMap['myTile']),
        (jsonMap['otherTiles'] as List)
            .map((tileJson) => OtherTile.fromJson(tileJson))
            .toList());
  }

  const Dashboard(this.myTile, this.otherTiles);

  @override
  List<Object> get props => [myTile, otherTiles];
}
