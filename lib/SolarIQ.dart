import 'package:flutter/material.dart';
import 'package:solariqflutter/Screens/Auth/LoginScreen.dart';
import 'package:solariqflutter/Screens/Auth/SignUpScreen.dart';
import 'package:solariqflutter/Screens/Auth/UserProfileScreen.dart';
import 'Screens/Home/HomeScreen.dart';
import 'Screens/Auth/SplashScreen.dart';


class SolarIQ extends StatelessWidget {
  const SolarIQ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SolarIQ',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}