import 'package:flutter/material.dart';
import 'SocialButtons.dart';

class SocialButtonsRow extends StatelessWidget {
  final VoidCallback handleGoogleSignIn;

  const SocialButtonsRow({
    Key? key,
    required this.handleGoogleSignIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialButton(
          icon: Icons.email,
          color: Colors.redAccent,
          text: "Gmail",
          onTap: handleGoogleSignIn,
        ),
        const SizedBox(width: 16),
        SocialButton(
          icon: Icons.facebook,
          color: Colors.blueAccent,
          text: "Facebook",
          onTap: () {
            // Implement Facebook login functionality
          },
        ),
      ],
    );
  }
}
