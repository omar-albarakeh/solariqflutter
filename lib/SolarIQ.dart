import 'package:flutter/material.dart';
import 'package:solariqflutter/Config/AppColor.dart';
import 'package:solariqflutter/Screens/Auth/LoginScreen.dart';
import 'package:solariqflutter/Screens/Auth/SignUpScreen.dart';
import 'package:solariqflutter/Screens/Auth/UserProfileScreen.dart';
import 'Config/DarkTheme.dart';
import 'Config/LightTheme.dart';
import 'Screens/Auth/SplashScreen.dart';
import 'Screens/Home/HomeScreen.dart';


class SolarIQ extends StatelessWidget {
  const SolarIQ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solariq App',
      theme: LightTheme.lightTheme,
      darkTheme: DarkTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/userprofile': (context) => const Userprofilescreen(),
        '/home':(context)=>const HomeScreen(),
      },
    );
  }
}