import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stimmungsringeapp/data/freezed_classes.dart';
import 'package:stimmungsringeapp/data/sentiment.dart';
import 'package:stimmungsringeapp/global_constants.dart';

class DashboardRepository {
  Future<Dashboard> loadDashboardPageData() async {
    final String url = restUrlDashboard();

    http.Response response = await http.get(
      url,
      headers: {'X-User-ID': sampleUserMutti},
    );

    final Dashboard dashboard =
        Dashboard.fromJson(json.decode(response.body) as Map<String, dynamic>);

    await chaosMonkeyDelayAsync();
    return dashboard;
  }

  Future<void> setNewSentiment(Sentiment sentiment) async {
    final String url = restUrlStatus();

    http.Response response = await http.put(url,
        headers: {
          'X-User-ID': sampleUserMutti,
          "Content-Type": "application/json"
        },
        body: json.encode(SentimentUpdate(sentiment.sentimentCode)));
    // TODO response handling

    await chaosMonkeyDelayAsync();
  }
}