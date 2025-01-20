import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double? width;
  final double? height;

  const LogoWidget({
    Key? key,
    this.width = 234,
    this.height = 224,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Image.asset(
        "assets/images/LOGO.png",
        width: width,
        height: height,
      ),
    );
  }
}
