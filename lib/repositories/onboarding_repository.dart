import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stimmungsringeapp/data/onboarding.dart';
import 'package:stimmungsringeapp/global_constants.dart';
import 'package:stimmungsringeapp/session.dart';

class OnboardingRepository {
  // final client = new HttpClient()..connectionTimeout = Duration(seconds: 5);

  Future<FindGroupResponse> findGroupByCode(String groupCode) async {
    final String url = '$backendBaseUrl/onboarding/group-by-code';

    final http.Response response = await http.post(
      url,
      headers: {
        'X-User-ID': currentUserId,
        "Content-Type": "application/json",
      },
      body: json.encode({
        'groupCode': groupCode,
      }),
    );

    if (response.statusCode == 204) {
      return null;
    }

    assert(response.statusCode == 200);

    final FindGroupResponse findGroupResponse = FindGroupResponse.fromJson(
        json.decode(response.body) as Map<String, dynamic>);

    await chaosMonkeyDelayAsync();
    return findGroupResponse;
  }

  Future<SigninUserResponse> signin(String deviceIdentifier) async {
    final String url = '$backendBaseUrl/onboarding/signin';

    final http.Response response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode({
        'deviceIdentifier': deviceIdentifier,
      }),
    );

    assert(response.statusCode == 200);

    final SigninUserResponse signinUserResponse = SigninUserResponse.fromJson(
        json.decode(response.body) as Map<String, dynamic>);

    await chaosMonkeyDelayAsync();
    return signinUserResponse;
  }

  Future<StartNewGroupResponse> startNewGroup(String groupName) async {
    final String url = '$backendBaseUrl/onboarding/group/start';

    final http.Response response = await http.post(
      url,
      headers: {
        'X-User-ID': currentUserId,
        "Content-Type": "application/json",
      },
      body: json.encode({
        'groupName': groupName,
      }),
    );

    if (response.statusCode == 409) {
      return null;
    }

    assert(response.statusCode == 200);

    final StartNewGroupResponse startNewGroupResponse =
        StartNewGroupResponse.fromJson(
            json.decode(response.body) as Map<String, dynamic>);

    await chaosMonkeyDelayAsync();
    return startNewGroupResponse;
  }

  Future<void> joinGroup(String groupId) async {
    final String url = '$backendBaseUrl/onboarding/group/join';

    final http.Response response = await http.put(
      url,
      headers: {
        'X-User-ID': currentUserId,
        "Content-Type": "application/json",
      },
      body: json.encode({
        'groupId': groupId,
      }),
    );

    assert(response.statusCode == 200);

    await chaosMonkeyDelayAsync();
    return;
  }

  Future<void> leaveGroup(String groupId) async {
    final String url = '$backendBaseUrl/onboarding/group/leave';

    final http.Response response = await http.put(
      url,
      headers: {
        'X-User-ID': currentUserId,
        "Content-Type": "application/json",
      },
      body: json.encode({
        'groupId': groupId,
      }),
    );

    assert(response.statusCode == 200);

    await chaosMonkeyDelayAsync();
    return;
  }

  Future<void> updateUserSettings(String name) async {
    final String url = '$backendBaseUrl/onboarding/user/settings';

    final http.Response response = await http.put(
      url,
      headers: {
        'X-User-ID': currentUserId,
        "Content-Type": "application/json",
      },
      body: json.encode({
        'name': name,
      }),
    );

    assert(response.statusCode == 200);

    await chaosMonkeyDelayAsync();
    return;
  }

  Future<void> updateGroupSettings(String groupId, String groupName) async {
    final String url = '$backendBaseUrl/onboarding/group/${groupId}/settings';

    final http.Response response = await http.put(
      url,
      headers: {
        'X-User-ID': currentUserId,
        "Content-Type": "application/json",
      },
      body: json.encode({
        'groupName': groupName,
      }),
    );

    assert(response.statusCode == 200);

    await chaosMonkeyDelayAsync();
    return;
  }

  Future<GroupSettingsResponse> getGroupSettings(String groupId) async {
    final String url = '$backendBaseUrl/onboarding/group/$groupId/settings';

    final http.Response response = await http.get(
      url,
      headers: {
        'X-User-ID': currentUserId,
        "Content-Type": "application/json",
      },
    );

    assert(response.statusCode == 200);

    final GroupSettingsResponse groupSettings = GroupSettingsResponse.fromJson(
        json.decode(response.body) as Map<String, dynamic>);

    await chaosMonkeyDelayAsync();
    return groupSettings;
  }
}
