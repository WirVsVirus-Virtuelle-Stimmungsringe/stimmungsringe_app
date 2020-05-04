import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stimmungsringeapp/config.dart';
import 'package:stimmungsringeapp/data/group_data.dart';
import 'package:stimmungsringeapp/data/signin_user_response.dart';
import 'package:stimmungsringeapp/data/user_settings.dart';
import 'package:stimmungsringeapp/repositories/chaos_monkey.dart';
import 'package:stimmungsringeapp/session.dart';

class OnboardingRepository {
  // final client = new HttpClient()..connectionTimeout = Duration(seconds: 5);

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

    final http.Response response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'deviceIdentifier': deviceIdentifier,
      }),
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

  Future<void> updateUserSettings(String name) async {
    final String url = '${Config().backendUrl}/onboarding/user/settings';

    final http.Response response = await http.put(
      url,
      headers: {
        'X-User-ID': currentUserId,
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': name,
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
