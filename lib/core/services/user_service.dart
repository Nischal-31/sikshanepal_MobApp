import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sikshanepal/models/user_model.dart';

class UserService {
  final String baseUrl = "http://192.168.1.66:8000/backend";

  /// Fetch the currently logged-in user
  Future<User?> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) return null; // Not logged in

    final response = await http.get(
      Uri.parse("$baseUrl/profile/"), // Endpoint for current user
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token', // TokenAuthentication
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return User.fromJson(data);
    } else {
      print('Failed to fetch current user: ${response.statusCode}');
      return null;
    }
  }

  /// Update user profile information
  Future<bool> updateUser(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token == null) return false;

    final response = await http.put(
      Uri.parse("$baseUrl/user-update/"), // no ID in URL
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      },
      body: json.encode(data),
    );

    return response.statusCode == 200;
  }
}
