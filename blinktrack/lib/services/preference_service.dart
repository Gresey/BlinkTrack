import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static const String _isLoggedInKey = 'is_logged_in';

  static Future<bool> isUserLogin() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(_isLoggedInKey) ?? false;
  }

  static Future<void> setUserLogin() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(_isLoggedInKey, true);
    print('user login status: $_isLoggedInKey');
  }

  static Future<void> logout() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(_isLoggedInKey);
  }
}
