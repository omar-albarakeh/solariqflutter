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
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
