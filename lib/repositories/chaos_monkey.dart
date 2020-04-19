import 'package:stimmungsringeapp/config.dart';

class ChaosMonkey {
  static Future<void> delayAsync() async {
    if (Config().env != AppEnv.prod) {
      await Future<void>.delayed(const Duration(milliseconds: 1000));
    }
  }
}
