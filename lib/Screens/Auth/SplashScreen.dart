import 'package:flutter/material.dart';
import 'package:solariqflutter/Screens/Auth/LoginScreen.dart';
import 'package:solariqflutter/Widgets/Common/Buttons.dart';

import '../../Config/AppColor.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColor.linearGradient,
        ),
        child: Column(
          children: [
            Buttons(
              buttonText: "Get Started",
              navigateTo: const Loginscreen(),
              hasBorder: false,
              backgroundColor: AppColor.buttonPrimary,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Loginscreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
