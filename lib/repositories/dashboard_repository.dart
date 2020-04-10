import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stimmungsringeapp/data/detail_pages.dart';
import 'package:stimmungsringeapp/data/freezed_classes.dart';
import 'package:stimmungsringeapp/data/sentiment.dart';
import 'package:stimmungsringeapp/global_constants.dart';
import 'package:stimmungsringeapp/session.dart';

class DashboardRepository {
  Future<Dashboard> loadDashboardPageData() async {
    final String url = restUrlDashboard();

    final http.Response response = await http.get(
      url,
      headers: {'X-User-ID': currentUserId},
    );

    final Dashboard dashboard =
        Dashboard.fromJson(json.decode(response.body) as Map<String, dynamic>);

    await chaosMonkeyDelayAsync();
    return dashboard;
  }

  Future<void> setNewSentiment(Sentiment sentiment) async {
    final String url = restUrlStatus();

    final http.Response response = await http.put(url,
        headers: {
          'X-User-ID': currentUserId,
          "Content-Type": "application/json"
        },
        body: json.encode(SentimentUpdate(sentiment.sentimentCode)));
    // TODO response handling

    await chaosMonkeyDelayAsync();
  }

  Future<OtherDetail> loadOtherDetailPageData(String userId) async {
    final String url = restUrlOtherStatus(userId);

    final http.Response response = await http.get(
      url,
      headers: {'X-User-ID': currentUserId},
    );

    //await new Future.delayed(const Duration(seconds: 1));

    final OtherDetail detailPage = OtherDetail.fromJson(
        json.decode(response.body) as Map<String, dynamic>);

    await chaosMonkeyDelayAsync();
    return detailPage;
  }
}
