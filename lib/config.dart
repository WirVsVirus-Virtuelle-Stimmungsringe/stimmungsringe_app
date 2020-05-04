import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yaml/yaml.dart';

Future<Map> _loadConfig() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String configYamlStr =
      await rootBundle.loadString('config/config.yaml');
  return loadYaml(configYamlStr) as Map;
}

Future<Map<String, String>> _loadEnv() async {
  await DotEnv().load('config/.env');
  return DotEnv().env;
}

class Config {
  Future<void> loaded;

  String _backendUrl;
  bool _useFakeDeviceId;
  String _fakeDeviceId;
  bool _chaosMonkeyEnabled;

  static final Config _singleton = Config._internal();

  factory Config() {
    return _singleton;
  }

  Config._internal() {
    loaded = Future.wait([_loadConfig(), _loadEnv()]).then((configData) {
      final Map config = configData[0];
      final Map<String, String> env = configData[1] as Map<String, String>;

      _backendUrl = _getString('backendUrl', config, env);
      _useFakeDeviceId = _getBool('useFakeDeviceId', config, env);
      _fakeDeviceId = _getString('fakeDeviceId', config, env);
      _chaosMonkeyEnabled = _getBool('chaosMonkeyEnabled', config, env);
    });
  }

  String get backendUrl {
    return _backendUrl;
  }

  bool get useFakeDeviceId {
    return _useFakeDeviceId;
  }

  String get fakeDeviceId {
    return _fakeDeviceId;
  }

  bool get chaosMonkeyEnabled {
    return _chaosMonkeyEnabled;
  }

  String _getString(String configKey, Map config, Map<String, String> env) {
    return _getConfigProperty((value) => value, configKey, config, env);
  }

  bool _getBool(String configKey, Map config, Map<String, String> env) {
    return _getConfigProperty(
        (value) => value.toLowerCase() == 'true', configKey, config, env);
  }

  T _getConfigProperty<T>(T Function(String) fromEnv, String configKey,
      Map config, Map<String, String> env) {
    // camelCaseToUpperUnderscore: backendUrl -> BACKEND_URL
    final String envKey = StringUtils.camelCaseToUpperUnderscore(configKey);

    if (env.containsKey(envKey)) {
      return fromEnv(env[envKey]);
    }

    if (config.containsKey(configKey)) {
      return config[configKey] as T;
    }

    return null;
  }
}
