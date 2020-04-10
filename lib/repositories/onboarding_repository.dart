import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stimmungsringeapp/data/onboarding.dart';
import 'package:stimmungsringeapp/global_constants.dart';

void main() {
  //OnboardingRepository().signin("1234").then((response) {
  //  print(response.groupName);
  //});
  //OnboardingRepository().joinGroup("Rasselbande");
  OnboardingRepository().startNewGroup("Cool Gang");
}

class OnboardingRepository {
  /**
   * Unique Device Identifier
   *
   * - persistent UDID across app reinstalls
   */
  Future<String> get udid async {
    // return await FlutterUdid.consistentUdid;
    return "1234"; // Frida
    // return "abba"; // Stefan
  }

  Future<SigninUserResponse> signin(String deviceIdentifier) async {
    final String url = restUrlSignin();

    final http.Response response = await http.put(
      url,
      headers: {
        'X-User-ID': sampleUserMutti,
        "Content-Type": "application/json",
      },
      body: json.encode({
        'deviceIdentifier': deviceIdentifier,
      }),
    );

    final SigninUserResponse signinUserResponse = SigninUserResponse.fromJson(
        json.decode(response.body) as Map<String, dynamic>);

    await chaosMonkeyDelayAsync();
    return signinUserResponse;
  }

  Future<void> startNewGroup(String groupName) async {
    final String url = restUrlStartNewGroup();

    final http.Response response = await http.post(
      url,
      headers: {
        'X-User-ID': sampleUserMutti,
        "Content-Type": "application/json",
      },
      body: json.encode({
        'groupName': groupName,
      }),
    );

    await chaosMonkeyDelayAsync();
    return;
  }

  Future<void> joinGroup(String groupName) async {
    final String url = restUrlJoinGroup();

    final http.Response response = await http.put(
      url,
      headers: {
        'X-User-ID': sampleUserMutti,
        "Content-Type": "application/json",
      },
      body: json.encode({
        'groupName': groupName,
      }),
    );

    await chaosMonkeyDelayAsync();
    return;
  }

  Future<bool> isUserMemberOfGroup() async {
    // print("checking if udid member of group: " + await udid);
    await chaosMonkeyDelayAsync();
    return !forceOnboarding;
  }

  Future<bool> findGroupByCode(String groupCode) async {
    return groupCode == "1111";
  }
}
