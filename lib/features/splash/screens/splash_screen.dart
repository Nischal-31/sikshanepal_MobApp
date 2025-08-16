import 'package:flutter/material.dart';
import 'package:sikshanepal/core/services/auth_service.dart';
import 'package:sikshanepal/features/splash/widgets/splash_widgets.dart';
import 'package:sikshanepal/routes/app_routes.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService _authService = AuthService(); // Instance of service

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    bool loggedIn = await _authService.isLoggedIn();

    if (loggedIn) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashContent(),
      backgroundColor: Colors.blueAccent, // Optional background color
    );
  }
}
