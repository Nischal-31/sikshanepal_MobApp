import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Map<String, dynamic>>> fetchCourses() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('auth_token');

  final response = await http.get(
    Uri.parse('http://192.168.1.66:8000/backend/course-list/'),
    headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    List data = jsonDecode(response.body);
    return List<Map<String, dynamic>>.from(data);
  } else {
    throw Exception('Failed to load courses: ${response.statusCode}');
  }
}
