import 'dart:convert';

import 'package:familiarise/config.dart';
import 'package:familiarise/data/dashboard.dart';
import 'package:familiarise/data/other_detail.dart';
import 'package:familiarise/data/sentiment.dart';
import 'package:familiarise/repositories/chaos_monkey.dart';
import 'package:familiarise/session.dart';
import 'package:http/http.dart' as http;

class DashboardRepository {
  static final DashboardRepository _singleton = DashboardRepository._internal();

  factory DashboardRepository() {
    return _singleton;
  }

  DashboardRepository._internal();

  Future<Dashboard> loadDashboardPageData() async {
    final String url = '${Config().backendUrl}/dashboard';

    final http.Response response = await http.get(
      url,
      headers: {'X-User-ID': currentUserId},
    );

    assert(
        response.statusCode == 200, 'load dashboard -> ${response.statusCode}');

    final Dashboard dashboard = Dashboard.fromJson(
        json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>);

    await ChaosMonkey.delayAsync();
    return dashboard;
  }

  Future<void> setNewSentiment(Sentiment sentiment) async {
    final String url = '${Config().backendUrl}/mystatus';

    final http.Response response = await http.put(url,
        headers: {
          'X-User-ID': currentUserId,
          'Content-Type': 'application/json'
        },
        body: json.encode({'sentiment': sentiment.sentimentCode}));
    // TODO response handling

    assert(response.statusCode == 200);
    await ChaosMonkey.delayAsync();
  }

  Future<OtherDetail> loadOtherDetailPageData(String userId) async {
    final String url = '${Config().backendUrl}/otherstatuspage/$userId';

    final http.Response response = await http.get(
      url,
      headers: {'X-User-ID': currentUserId},
    );

    assert(response.statusCode == 200);

    //await new Future.delayed(const Duration(seconds: 1));

    final OtherDetail detailPage = OtherDetail.fromJson(
        json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>);

    await ChaosMonkey.delayAsync();
    return detailPage;
  }
}
