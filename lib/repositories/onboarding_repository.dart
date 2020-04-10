import 'package:stimmungsringeapp/global_constants.dart';

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

  Future<bool> isUserMemberOfGroup() async {
    // print("checking if udid member of group: " + await udid);
    await chaosMonkeyDelayAsync();
    return !forceOnboarding;
  }

  Future<bool> findGroupByCode(String groupCode) async {
    return groupCode == "1111";
  }
}
