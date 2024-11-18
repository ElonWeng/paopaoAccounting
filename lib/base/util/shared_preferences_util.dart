import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static SharedPreferences? _prefs;

  static Future<SharedPreferences> get prefs async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  // 存储String类型数据
  static Future<bool> setString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferencesUtil.prefs;
    return prefs.setString(key, value);
  }

  // 获取String类型数据
  static Future<String?> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferencesUtil.prefs;
    return prefs.getString(key);
  }

  // 存储int类型数据
  static Future<bool> setInt(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferencesUtil.prefs;
    return prefs.setInt(key, value);
  }

  // 获取int类型数据
  static Future<int?> getInt(String key) async {
    final SharedPreferences prefs = await SharedPreferencesUtil.prefs;
    return prefs.getInt(key);
  }

  // 存储bool类型数据
  static Future<bool> setBool(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferencesUtil.prefs;
    return prefs.setBool(key, value);
  }

  // 获取bool类型数据
  static Future<bool?> getBool(String key) async {
    final SharedPreferences prefs = await SharedPreferencesUtil.prefs;
    return prefs.getBool(key);
  }

  // 存储double类型数据
  static Future<bool> setDouble(String key, double value) async {
    final SharedPreferences prefs = await SharedPreferencesUtil.prefs;
    return prefs.setDouble(key, value);
  }

  // 获取double类型数据
  static Future<double?> getDouble(String key) async {
    final SharedPreferences prefs = await SharedPreferencesUtil.prefs;
    return prefs.getDouble(key);
  }


  // 移除指定key的数据
  static Future<bool> remove(String key) async {
    final SharedPreferences prefs = await SharedPreferencesUtil.prefs;
    return prefs.remove(key);
  }

  // 清空所有数据
  static Future<bool> clear() async {
    final SharedPreferences prefs = await SharedPreferencesUtil.prefs;
    return prefs.clear();
  }
}
