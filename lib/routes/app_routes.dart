import 'package:flutter/material.dart';
import 'package:sikshanepal/features/home/screens/home_screen.dart';
import 'package:sikshanepal/features/login/screens/login_screen.dart';
import 'package:sikshanepal/features/splash/screens/splash_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String login = '/login';

  static final Map<String, WidgetBuilder> routes = {
    splash: (context) => SplashScreen(),
    home: (context) => HomeScreen(),
    login: (context) => LoginScreen(),
  };
}
