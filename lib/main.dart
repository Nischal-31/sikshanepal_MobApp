import 'package:flutter/material.dart';
import 'package:sikshanepal/routes/app_routes.dart';

void main() {
  runApp(const SikshaNepal());
}

class SikshaNepal extends StatelessWidget {
  const SikshaNepal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Siksha Nepal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/splash',
      routes: AppRoutes.routes,
    );
  }
}
