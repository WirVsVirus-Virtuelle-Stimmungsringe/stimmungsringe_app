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
  final List<OtherTile> otherTiles;
  final UserMinimal user;
  final Sentiment sentiment;

  const Dashboard(this.otherTiles, this.user, this.sentiment);

  Dashboard withSentiment(Sentiment newSentiment) {
    return Dashboard(otherTiles, user, newSentiment ?? sentiment);
  }

  static fromJson(Map<String, dynamic> jsonMap) {
    final MyTile myTile = MyTile.fromJson(jsonMap['myTile']);
    return Dashboard(
        (jsonMap['otherTiles'] as List)
            .map((tileJson) => OtherTile.fromJson(tileJson))
            .toList(),
        myTile.user,
        Sentiment.fromSentimentStatus(myTile.sentimentStatus));
  }

  @override
  List<Object> get props => [otherTiles, user, sentiment];
}
