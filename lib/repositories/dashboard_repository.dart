import 'dart:convert';

import 'package:familiarise/config.dart';
import 'package:familiarise/data/achievement.dart';
import 'package:familiarise/data/dashboard.dart';
import 'package:familiarise/data/other_detail.dart';
import 'package:familiarise/data/sentiment.dart';
import 'package:familiarise/repositories/chaos_monkey.dart' as chaos_monkey;
import 'package:familiarise/session.dart';
import 'package:familiarise/utils/api_headers.dart';
import 'package:familiarise/utils/response.dart';
import 'package:http/http.dart' as http;

class DashboardRepository {
  static final DashboardRepository _singleton = DashboardRepository._internal();

  factory DashboardRepository() {
    return _singleton;
  }

  DashboardRepository._internal();

  Future<Achievement?> loadUnseenAchievementForSplash() async {
    final Uri url =
        Uri.parse('${Config().backendUrl}/achievement/splash/unseen');

    final http.Response response = await http.get(
      url,
      headers: authenticated(currentUserId),
    );

    assert(
      response.statusCode == 200 || response.statusCode == 404,
      'load unseen achievements for splash -> ${response.statusCode}',
    );

    final Achievement? achievement = response.statusCode == 200
        ? Achievement.fromJson(decodeResponseBytesToJson(response.bodyBytes))
        : null;

    await chaos_monkey.delayAsync();
    return achievement;
  }

  Future<void> ackUnseenAchievement(Achievement achievement) async {
    final Uri url = Uri.parse(
      '${Config().backendUrl}/achievement/splash/${achievement.achievementType.name}/ack',
    );

    final http.Response response = await http.post(
      url,
      headers: {
        ...authenticated(currentUserId),
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'level': achievement.level,
      }),
    );

    assert(
      response.statusCode == 200,
      'ack unseen achievements for splash -> ${response.statusCode}',
    );

    await chaos_monkey.delayAsync();
  }

  Future<Dashboard> loadDashboardPageData() async {
    final Uri url = Uri.parse('${Config().backendUrl}/dashboard');

    final http.Response response = await http.get(
      url,
      headers: authenticated(currentUserId),
    );

    assert(
      response.statusCode == 200,
      'load dashboard -> ${response.statusCode}',
    );

    final Dashboard dashboard =
        Dashboard.fromJson(decodeResponseBytesToJson(response.bodyBytes));

    await chaos_monkey.delayAsync();
    return dashboard;
  }

  Future<void> setNewSentiment(
    Sentiment sentiment,
    String sentimentText,
  ) async {
    final Uri url = Uri.parse('${Config().backendUrl}/mystatus');

    final http.Response response = await http.put(
      url,
      headers: {
        ...authenticated(currentUserId),
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {'sentiment': sentiment.sentimentCode, 'sentimentText': sentimentText},
      ),
    );
    // TODO response handling

    assert(response.statusCode == 200);
    await chaos_monkey.delayAsync();
  }

  Future<OtherDetail> loadOtherDetailPageData(String userId) async {
    final Uri url = Uri.parse('${Config().backendUrl}/otherstatuspage/$userId');

    final http.Response response = await http.get(
      url,
      headers: authenticated(currentUserId),
    );

    assert(response.statusCode == 200);

    //await new Future.delayed(const Duration(seconds: 1));

    final OtherDetail detailPage =
        OtherDetail.fromJson(decodeResponseBytesToJson(response.bodyBytes));

    await chaos_monkey.delayAsync();
    return detailPage;
  }
}
