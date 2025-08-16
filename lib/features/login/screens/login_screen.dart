import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:sikshanepal/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    // Clear the fields when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _clearFields();
    });
  }

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _clearFields() {
    _usernameController.clear();
    _passwordController.clear();
    setState(() {
      _isLoading = false;
      _obscurePassword = true;
    });
  }

  void logStoredData() async {
    final prefs = await SharedPreferences.getInstance();

    // Get everything stored
    final keys = prefs.getKeys();
    for (var key in keys) {
      print("$key: ${prefs.get(key)}");
    }
  }

  Future<void> _login() async {
    // Validate input fields
    if (_usernameController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter both username and password'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final url = Uri.parse('http://10.0.2.2:8000/backend/api/token/');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'username': _usernameController.text.trim(),
          'password': _passwordController.text.trim(),
        },
      );

      setState(() => _isLoading = false);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String token = data['token'];
        Map<String, dynamic> user = data['user'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        await prefs.setString('user', json.encode(user)); // Save user info

        logStoredData();

        // Navigate to home and clear navigation stack
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.home,
          (Route<dynamic> route) => false,
        );
      } else {
        String errorMessage = 'Login failed';
        try {
          final errorData = json.decode(response.body);
          errorMessage = errorData['detail'] ?? errorMessage;
        } catch (e) {
          errorMessage = 'Login failed: ${response.statusCode}';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Network error: Please check your connection'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1565C0), // Deep blue
              Color(0xFF42A5F5), // Light blue
              Color(0xFF90CAF9), // Very light blue
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo and App Name
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Image.asset(
                      'assets/images/sikshanepal.png',
                      width: 100,
                      height: 100,
                      color: Colors.white, // Optional if you want to tint it
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'SikshaNepal',
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black26,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Learn • Grow • Enhance',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 48),

                  // Login Form Card
                  Container(
                    padding: EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Welcome Back!',
                          style: TextStyle(
                            fontSize: 24,
                            color: Color(0xFF1565C0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Please sign in to continue',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 32),

                        // Username Field
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _usernameController,
                            enabled: !_isLoading,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: _isLoading
                                  ? Colors.grey[100]
                                  : Colors.grey[50],
                              labelText: 'Username',
                              labelStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                              hintText: 'Enter your username',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xFF1565C0),
                                  width: 2,
                                ),
                              ),
                              prefixIcon: Container(
                                margin: EdgeInsets.all(12),
                                child: Icon(
                                  Icons.person_outline,
                                  color: Color(0xFF1565C0),
                                  size: 20,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        // Password Field
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _passwordController,
                            enabled: !_isLoading,
                            obscureText: _obscurePassword,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: _isLoading
                                  ? Colors.grey[100]
                                  : Colors.grey[50],
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                              hintText: 'Enter your password',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xFF1565C0),
                                  width: 2,
                                ),
                              ),
                              prefixIcon: Container(
                                margin: EdgeInsets.all(12),
                                child: Icon(
                                  Icons.lock_outline,
                                  color: Color(0xFF1565C0),
                                  size: 20,
                                ),
                              ),
                              suffixIcon: IconButton(
                                onPressed: _isLoading
                                    ? null
                                    : () {
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      },
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: Colors.grey[600],
                                  size: 20,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 32),

                        // Login Button
                        _isLoading
                            ? Container(
                                height: 56,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xFF1565C0),
                                    strokeWidth: 3,
                                  ),
                                ),
                              )
                            : Container(
                                width: double.infinity,
                                height: 56,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF1565C0),
                                      Color(0xFF42A5F5),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFF1565C0).withOpacity(0.3),
                                      blurRadius: 15,
                                      offset: Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: _login,
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),

                  // Footer Text
                  Text(
                    '© 2026 SikshaNepal',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
