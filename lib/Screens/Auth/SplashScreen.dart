import 'package:flutter/material.dart';
import 'package:solariqflutter/Config/AppText.dart';
import 'package:solariqflutter/Screens/Auth/LoginScreen.dart';
import 'package:solariqflutter/Widgets/Common/Buttons.dart';

import '../../Config/AppColor.dart';
import '../../Widgets/Auth/Animatedimage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: AppColor.background,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAnimatedImageRow(
                  ['assets/images/1.png', 'assets/images/2.png'],
                  [200, 400],
                ),
                const SizedBox(height: 16),
                _buildAnimatedImageRow(
                  ['assets/images/3.png', 'assets/images/4.png'],
                  [600, 800],
                ),
                const SizedBox(height: 30),
                const Text("Welcome to SolarIQ", style: AppTextStyles.title),
                const SizedBox(height: 16),
                Buttons(
                  buttonText: "Get Started",
                  navigateTo: const LoginScreen(),
                  hasBorder: false,
                  backgroundColor: AppColor.buttonPrimary,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                ),
                const SizedBox(height: 16),
                const Buttons(
                  buttonText: "About Us",
                  navigateTo: SizedBox(),
                  hasBorder: false,
                  backgroundColor: AppColor.buttonSecondary,
                  showDialogOnTap: true,
                  dialogTitle: "SolarIQ",
                  dialogContent:
                      "SolarIQ Maximize your solar investment with SolarIQ. Our AI-powered app provides real-time monitoring, weather-based predictions, and expert advice. Connect with a community of solar enthusiasts and unlock the full potential of your system.Key Features:\nReal-time Monitorin \nAI-Powered Advice \nWeather Predictions \nCommunity & Support",
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildAnimatedImageRow(List<String> imagePaths, List<int> delays) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(imagePaths.length, (index) {
      return Padding(
        padding:
            EdgeInsets.only(right: index != imagePaths.length - 1 ? 16.0 : 0),
        child: AnimatedImage(
          imagePath: imagePaths[index],
          delay: Duration(milliseconds: delays[index]),
        ),
      );
    }),
  );
}
