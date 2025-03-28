import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  late Map<String, dynamic> _variables;
  late SharedPreferences localStorage;
  double _devicePixelRatio = 1.5;
  String _environment = 'prod';

  AppConfig._internal();

  static final AppConfig _instance = AppConfig._internal();

  static getDevicePixelRatio(queryData) async {
    _instance._devicePixelRatio = queryData.devicePixelRatio;
  }

  static loadEnvVariables({String env = 'prod'}) async {
    final String loadedVariables = await rootBundle.loadString(
      'assets/config/$env.json',
    );
    final json = jsonDecode(loadedVariables);
    _instance._variables = json ?? {};
  }

  static loadLocalStorage() async {
    _instance.localStorage = await SharedPreferences.getInstance();
    return _instance.localStorage;
  }

  static dynamic getLocalStorageInstance() {
    return _instance.localStorage;
  }

  static String platformName() {
    var platformName = '';
    if (kIsWeb) {
      platformName = "web";
    } else {
      if (Platform.isAndroid) {
        platformName = "android";
      } else if (Platform.isIOS) {
        platformName = "ios";
      } else if (Platform.isFuchsia) {
        platformName = "fuchsia";
      } else if (Platform.isLinux) {
        platformName = "linux";
      } else if (Platform.isMacOS) {
        platformName = "macos";
      } else if (Platform.isWindows) {
        platformName = "windows";
      }
    }
    return platformName;
  }

  static dynamic get(String key) {
    if (_instance._variables.containsKey(key)) {
      return _instance._variables[key];
    }
    debugPrint('Config variable not found for key: $key');
    return null;
  }

  static Map<String, dynamic> get variables => Map<String, dynamic>.of(_instance._variables);

  static String get environment => _instance._environment;

  static double get devicePixelRatio => _instance._devicePixelRatio;

  static setEnvironment(String env) {
    _instance._environment = env;
  }

  @visibleForTesting
  static loadValueForTesting(Map<String, dynamic> values) {
    _instance._variables = values;
  }
}
