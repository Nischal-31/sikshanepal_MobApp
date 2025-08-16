import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Returns true if user is logged in
  Future<bool> isLoggedIn() async {
    await Future.delayed(const Duration(seconds: 3)); // Splash delay
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    return token != null && token.isNotEmpty;
  }
}
