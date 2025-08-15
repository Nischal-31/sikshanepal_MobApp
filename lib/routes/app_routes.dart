import 'package:flutter/material.dart';
import 'package:sikshanepal/features/about/screens/about_screen.dart';
import 'package:sikshanepal/features/blog/screens/blog_screen.dart';
import 'package:sikshanepal/features/contact/screens/contact_screen.dart';
import 'package:sikshanepal/features/courses/screens/course_screen.dart';
import 'package:sikshanepal/features/home/screens/home_screen.dart';
import 'package:sikshanepal/features/login/screens/login_screen.dart';
import 'package:sikshanepal/features/profile/screens/profile_screen.dart';
import 'package:sikshanepal/features/splash/screens/splash_screen.dart';
import 'package:sikshanepal/features/subscription/screens/subscription_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String login = '/login';
  static const String about = '/about';
  static const String blog = '/blog';
  static const String courses = '/courses';
  static const String contact = '/contact';
  static const String subscription = '/subscription';
  static const String profile = '/profile';

  static final Map<String, WidgetBuilder> routes = {
    splash: (context) => SplashScreen(),
    home: (context) => HomeScreen(),
    login: (context) => LoginScreen(),
    about: (context) => AboutScreen(),
    blog: (context) => BlogScreen(),
    courses: (context) => CourseScreen(),
    contact: (context) => ContactScreen(),
    subscription: (context) => SubscriptionScreen(),
    profile: (context) => ProfileScreen(),
  };
}
