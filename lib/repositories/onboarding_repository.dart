import 'dart:convert';
import 'dart:io';

import 'package:familiarise/config.dart';
import 'package:familiarise/data/group_data.dart';
import 'package:familiarise/data/signin_user_response.dart';
import 'package:familiarise/data/user_settings.dart';
import 'package:familiarise/main.dart';
import 'package:familiarise/repositories/chaos_monkey.dart' as chaos_monkey;
import 'package:familiarise/session.dart';
import 'package:familiarise/utils/api_headers.dart';
import 'package:familiarise/utils/response.dart';
import 'package:http/http.dart' as http;

class OnboardingRepository {
  static final OnboardingRepository _singleton =
      OnboardingRepository._internal();

  factory OnboardingRepository() {
    return _singleton;
  }

  OnboardingRepository._internal();

  Future<SigninUserResponse> signin(String deviceIdentifier) async {
    final Uri url = Uri.parse('${Config().backendUrl}/onboarding/signin');

    String? fcmToken;
    if (pushNotificationsManager != null) {
      fcmToken = await pushNotificationsManager!.getFcmToken();
    }

    String deviceType;
    if (Platform.isAndroid) {
      deviceType = 'ANDROID';
    } else if (Platform.isIOS) {
      deviceType = 'IOS';
    } else {
      deviceType = 'UNKNOWN_DEVICE';
    }

    final http.Response response = await http.put(
      url,
      headers: {
        ...public(),
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'deviceIdentifier': deviceIdentifier,
        'deviceType': deviceType,
        'fcmToken': fcmToken
      }),
    );

    assert(response.statusCode == 200);

    final SigninUserResponse signinUserResponse = SigninUserResponse.fromJson(
      decodeResponseBytesToJson(response.bodyBytes),
    );

    await chaos_monkey.delayAsync();
    return signinUserResponse;
  }

  Future<GroupData?> startNewGroup(String groupName) async {
    final Uri url = Uri.parse('${Config().backendUrl}/onboarding/group/start');

    final http.Response response = await http.post(
      url,
      headers: {
        ...authenticated(currentUserId),
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
        GroupData.fromJson(decodeResponseBytesToJson(response.bodyBytes));

    await chaos_monkey.delayAsync();
    return startNewGroupResponse;
  }

  /// return false if user failed to join the group
  Future<GroupData?> joinGroup(String groupCode) async {
    final Uri url = Uri.parse('${Config().backendUrl}/onboarding/group/join');

    final http.Response response = await http.put(
      url,
      headers: {
        ...authenticated(currentUserId),
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
        GroupData.fromJson(decodeResponseBytesToJson(response.bodyBytes));

    await chaos_monkey.delayAsync();
    return findGroupResponse;
  }

  Future<void> leaveGroup(String groupId) async {
    final Uri url = Uri.parse('${Config().backendUrl}/onboarding/group/leave');

    final http.Response response = await http.put(
      url,
      headers: {
        ...authenticated(currentUserId),
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'groupId': groupId,
      }),
    );

    assert(response.statusCode == 200);

    await chaos_monkey.delayAsync();
    return;
  }

  Future<void> updateUserSettings(String? name, String? stockAvatar) async {
    final Uri url =
        Uri.parse('${Config().backendUrl}/onboarding/user/settings');

    final http.Response response = await http.put(
      url,
      headers: {
        ...authenticated(currentUserId),
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': name,
        'stockAvatar': stockAvatar,
      }),
    );

    assert(response.statusCode == 200);

    await chaos_monkey.delayAsync();
    return;
  }

  Future<void> updateGroupSettings(String groupId, String groupName) async {
    final Uri url =
        Uri.parse('${Config().backendUrl}/onboarding/group/$groupId/settings');

    final http.Response response = await http.put(
      url,
      headers: {
        ...authenticated(currentUserId),
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'groupName': groupName,
      }),
    );

    assert(response.statusCode == 200);

    await chaos_monkey.delayAsync();
    return;
  }

  Future<UserSettings> getUserSettings() async {
    final Uri url =
        Uri.parse('${Config().backendUrl}/onboarding/user/settings');

    final http.Response response = await http.get(
      url,
      headers: {
        ...authenticated(currentUserId),
        'Content-Type': 'application/json',
      },
    );

    assert(response.statusCode == 200);

    final UserSettings userSettings =
        UserSettings.fromJson(decodeResponseBytesToJson(response.bodyBytes));

    await chaos_monkey.delayAsync();
    return userSettings;
  }

  Future<GroupData> getGroupSettings(String groupId) async {
    final Uri url =
        Uri.parse('${Config().backendUrl}/onboarding/group/$groupId/settings');

    final http.Response response = await http.get(
      url,
      headers: {
        ...authenticated(currentUserId),
        'Content-Type': 'application/json',
      },
    );

    assert(response.statusCode == 200);

    final GroupData groupSettings =
        GroupData.fromJson(decodeResponseBytesToJson(response.bodyBytes));

    await chaos_monkey.delayAsync();
    return groupSettings;
  }
}
