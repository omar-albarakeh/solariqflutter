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
                      "SOLARIQ is a mobile app that offers a comprehensive solution for managing solar energy. It uses WebSocket technology for real-time monitoring of solar panels, battery status, and weather-driven energy forecasts. SOLARIQ also features a marketplace for purchasing solar panels, a community forum, live chat with engineers, and a chatbot providing personalized advice.",
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
