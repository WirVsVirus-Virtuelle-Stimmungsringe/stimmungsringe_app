import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stimmungsringeapp/data/onboarding.dart';
import 'package:stimmungsringeapp/global_constants.dart';
import 'package:stimmungsringeapp/session.dart';

class OnboardingRepository {
  // final client = new HttpClient()..connectionTimeout = Duration(seconds: 5);

  Future<FindGroupResponse> findGroupByName(String groupName) async {
    final String url = restUrlFindGroup();

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
    final String url = restUrlSignin();

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
    final String url = restUrlStartNewGroup();

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
    final String url = restUrlJoinGroup();

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

  Future<bool> isUserMemberOfGroup() async {
    // print("checking if udid member of group: " + await udid);
    await chaosMonkeyDelayAsync();
    return !forceOnboarding;
  }
}