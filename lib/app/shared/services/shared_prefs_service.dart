import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  late final SharedPreferences preferences;

  Future<void> init() async {
    preferences =
        await SharedPreferences.getInstance();
  }

  Future<void> saveUserToken(String token) async {
    await preferences.setString(
      'user_token',
      token,
    );
  }

  String? getUserToken() {
    return preferences.getString('user_token');
  }

  Future<void> clearUserToken() async {
    await preferences.remove('user_token');
  }
}
