import 'package:stimmungsringeapp/global_constants.dart';

class UserRepository {
  Future<bool> isUserMemberOfGroup() async {
    await chaosMonkeyDelayAsync();
    return !forceOnboarding;
  }

  Future<bool> findGroupByCode(String groupCode) async {
    return groupCode == "1111";
  }
}
