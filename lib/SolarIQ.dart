import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Config/DarkTheme.dart';
import 'Config/LightTheme.dart';
import 'Screens/Auth/SolarUnfoForm.dart';
import 'Widgets/Home/ThemeNotifier.dart';
import 'Screens/Auth/SplashScreen.dart';
import 'Screens/Auth/LoginScreen.dart';
import 'Screens/Auth/SignUpScreen.dart';
import 'Screens/Auth/UserProfileScreen.dart';
import 'Screens/Home/HomeScreen.dart';

class SolarIQ extends StatelessWidget {
  const SolarIQ({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, _) {
        return MaterialApp(
          title: 'Solariq App',
          theme: LightTheme.lightTheme,
          darkTheme: DarkTheme.darkTheme,
          themeMode: themeNotifier.themeMode,
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            '/login': (context) => const LoginScreen(),
            '/signup': (context) => const SignUpScreen(),
            '/userprofile': (context) => const Userprofilescreen(),
            '/home': (context) => const HomeScreen(),
            '/solar-form': (context) => SolarInfoForm(), // Add SolarInfoForm route
          },
        );
      },
    );
  }
}
