import 'package:flutter/material.dart';
import 'Screens/Auth/SplashScreen.dart';


class SolarIQ extends StatelessWidget {
  const SolarIQ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SolarIQ',
      home: const SplashScreen(),
    );
  }
}