import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  SharedPrefsService._();
  static final instance = SharedPrefsService._();
  late final SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> saveUserToken(String token) async {
    await _preferences.setString('user_token', token);
  }

  String? getUserToken() {
    return _preferences.getString('user_token');
  }

  Future<void> clearUserToken() async {
    await _preferences.remove('user_token');
  }
}
