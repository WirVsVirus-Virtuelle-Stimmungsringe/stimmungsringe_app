import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yaml/yaml.dart';

Future<Map> _loadConfig() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String configYamlStr = await rootBundle.loadString('config.yaml');
  return loadYaml(configYamlStr) as Map;
}

Future<Map<String, String>> _loadEnv() async {
  await DotEnv().load();
  return DotEnv().env;
}

enum AppEnv { dev, prod }

extension AppEnvExtension on AppEnv {
  static AppEnv fromString(String value) {
    return AppEnv.values.firstWhere((e) => e.toString().split('.')[1] == value);
  }
}

class Config {
  Future<void> loaded;
  final Map<String, dynamic> _config = <String, dynamic>{};

  static final Config _singleton = Config._internal();

  factory Config() {
    return _singleton;
  }

  Config._internal() {
    loaded = Future.wait([_loadConfig(), _loadEnv()]).then((configData) {
      final Map config = configData[0];
      final Map<String, String> env = configData[1] as Map<String, String>;

      _config['env'] = _getString('env', config, env);
      _config['backendUrl'] = _getString('backendUrl', config, env);
      _config['forceOnboarding'] = _getBool('forceOnboarding', config, env);
    });
  }

  AppEnv get env {
    return AppEnvExtension.fromString(_config['env'] as String);
  }

  String get backendUrl {
    return _config['backendUrl'] as String;
  }

  bool get forceOnboarding {
    return _config['forceOnboarding'] as bool;
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
