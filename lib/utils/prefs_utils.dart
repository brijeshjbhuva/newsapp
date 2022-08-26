import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

enum PrefKeys { articles }

class PrefsUtils {
  static SharedPreferences? _prefs;

  static Future<SharedPreferences> get _instance async =>
      _prefs ?? await SharedPreferences.getInstance();

  static Future<SharedPreferences?> init() async {
    _prefs = await _instance;
    return _prefs;
  }

  static String _getPrefKey(PrefKeys key) {
    switch (key) {
      case PrefKeys.articles:
        return 'articles';
      default:
        return 'unknown';
    }
  }

  static String? getString(PrefKeys prefKey) {
    String? key = _getPrefKey(prefKey);

    return _prefs!.getString(key);
  }

  static Future<bool> setString(PrefKeys prefKey, String value) async {
    String key = _getPrefKey(prefKey);

    return _prefs!.setString(key, value);
  }

  static getObject(PrefKeys prefKey) {
    String? key = _getPrefKey(prefKey);
    String data = _prefs!.getString(key) ?? '';
    return jsonDecode(data);
  }

  static setObject(PrefKeys prefKey, value) async {
    String key = _getPrefKey(prefKey);
    _prefs!.setString(key, jsonEncode(value));
  }

  static Future<bool> clear() async {
    return await _prefs!.clear();
  }
}
