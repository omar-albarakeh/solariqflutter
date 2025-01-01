import 'package:flutter/material.dart';

class AnimatedImage extends StatefulWidget {
  final String imagePath;
  final Duration delay;

  const AnimatedImage(
      {super.key, required this.imagePath, required this.delay});

  @override
  _AnimatedImageState createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
