import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static saveBool(String key, bool save) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, save);
  }

  static Future<bool> getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static saveString(String key, String save) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, save);
  }

  static getStringl(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
