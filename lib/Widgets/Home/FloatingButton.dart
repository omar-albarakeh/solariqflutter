import 'package:flutter/material.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  final List<Widget> subButtons;
  final Widget mainButton;
  final bool isExpanded;

  const FloatingActionButtonWidget({
    Key? key,
    required this.subButtons,
    required this.mainButton,
    this.isExpanded = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      
    );
  }
}
