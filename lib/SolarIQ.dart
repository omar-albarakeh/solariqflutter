import 'package:flutter/material.dart';
import 'Screens/Auth/HomeScreen.dart';
import 'Screens/Auth/SplashScreen.dart';


class SolarIQ extends StatelessWidget {
  const SolarIQ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SolarIQ',
      initialRoute: '/',  // This is where the app starts
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const Homescreen(),  // Define your /home route here
      },
    );
    Navigator.pushReplacementNamed(context, '/home');
  }
}