import 'package:flutter/material.dart';

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

          ],
        ),
      ),
    );
  }
}
