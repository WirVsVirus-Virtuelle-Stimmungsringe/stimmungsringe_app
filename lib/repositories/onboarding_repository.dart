import 'dart:convert';

import 'package:familiarise/config.dart';
import 'package:familiarise/data/group_data.dart';
import 'package:familiarise/data/signin_user_response.dart';
import 'package:familiarise/data/user_settings.dart';
import 'package:familiarise/main.dart';
import 'package:familiarise/repositories/chaos_monkey.dart';
import 'package:familiarise/session.dart';
import 'package:http/http.dart' as http;

class OnboardingRepository {
  static final OnboardingRepository _singleton =
      OnboardingRepository._internal();

  factory OnboardingRepository() {
    return _singleton;
  }

  OnboardingRepository._internal();

  Future<GroupData> findGroupByCode(String groupCode) async {
    final String url = '${Config().backendUrl}/onboarding/group-by-code';

    final http.Response response = await http.post(
      url,
      headers: {
        'X-User-ID': currentUserId,
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'groupCode': groupCode,
      }),
    );

    if (response.statusCode == 204) {
      return null;
    }

    assert(response.statusCode == 200);

    final GroupData findGroupResponse =
        GroupData.fromJson(json.decode(response.body) as Map<String, dynamic>);

    await ChaosMonkey.delayAsync();
    return findGroupResponse;
  }

  Future<SigninUserResponse> signin(String deviceIdentifier) async {
    final String url = '${Config().backendUrl}/onboarding/signin';

    String fcmToken;
    if (pushNotificationsManager != null) {
      fcmToken = await pushNotificationsManager.getFcmToken();
    }

    final http.Response response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json
          .encode({'deviceIdentifier': deviceIdentifier, 'fcmToken': fcmToken}),
    );

    assert(response.statusCode == 200);

    final SigninUserResponse signinUserResponse = SigninUserResponse.fromJson(
        json.decode(response.body) as Map<String, dynamic>);

    await ChaosMonkey.delayAsync();
    return signinUserResponse;
  }

  Future<GroupData> startNewGroup(String groupName) async {
    final String url = '${Config().backendUrl}/onboarding/group/start';

    final http.Response response = await http.post(
      url,
      headers: {
        'X-User-ID': currentUserId,
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'groupName': groupName,
      }),
    );

    if (response.statusCode == 409) {
      return null;
    }

    assert(response.statusCode == 200);

    final GroupData startNewGroupResponse =
        GroupData.fromJson(json.decode(response.body) as Map<String, dynamic>);

    await ChaosMonkey.delayAsync();
    return startNewGroupResponse;
  }

  Future<void> joinGroup(String groupId) async {
    final String url = '${Config().backendUrl}/onboarding/group/join';

    final http.Response response = await http.put(
      url,
      headers: {
        'X-User-ID': currentUserId,
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'groupId': groupId,
      }),
    );

    assert(response.statusCode == 200);

    await ChaosMonkey.delayAsync();
    return;
  }

  Future<void> leaveGroup(String groupId) async {
    final String url = '${Config().backendUrl}/onboarding/group/leave';

    final http.Response response = await http.put(
      url,
      headers: {
        'X-User-ID': currentUserId,
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'groupId': groupId,
      }),
    );

    assert(response.statusCode == 200);

    await ChaosMonkey.delayAsync();
    return;
  }

  Future<void> updateUserSettings(String name, String stockAvatar) async {
    final String url = '${Config().backendUrl}/onboarding/user/settings';

    final http.Response response = await http.put(
      url,
      headers: {
        'X-User-ID': currentUserId,
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': name,
        'stockAvatar': stockAvatar,
      }),
    );

    assert(response.statusCode == 200);

    await ChaosMonkey.delayAsync();
    return;
  }

  Future<void> updateGroupSettings(String groupId, String groupName) async {
    final String url =
        '${Config().backendUrl}/onboarding/group/$groupId/settings';

    final http.Response response = await http.put(
      url,
      headers: {
        'X-User-ID': currentUserId,
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'groupName': groupName,
      }),
    );

    assert(response.statusCode == 200);

    await ChaosMonkey.delayAsync();
    return;
  }

  Future<UserSettings> getUserSettings() async {
    final String url = '${Config().backendUrl}/onboarding/user/settings';

    final http.Response response = await http.get(
      url,
      headers: {
        'X-User-ID': currentUserId,
        'Content-Type': 'application/json',
      },
    );

    assert(response.statusCode == 200);

    final UserSettings userSettings = UserSettings.fromJson(
        json.decode(response.body) as Map<String, dynamic>);

    await ChaosMonkey.delayAsync();
    return userSettings;
  }

  Future<GroupData> getGroupSettings(String groupId) async {
    final String url =
        '${Config().backendUrl}/onboarding/group/$groupId/settings';

    final http.Response response = await http.get(
      url,
      headers: {
        'X-User-ID': currentUserId,
        'Content-Type': 'application/json',
      },
    );

    assert(response.statusCode == 200);

    final GroupData groupSettings =
        GroupData.fromJson(json.decode(response.body) as Map<String, dynamic>);

    await ChaosMonkey.delayAsync();
    return groupSettings;
  }
}
