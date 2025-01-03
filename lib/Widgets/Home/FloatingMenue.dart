import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Config/AppColor.dart';
import 'FloatingButton.dart';

class FloatingMenu extends StatefulWidget {
  const FloatingMenu({super.key});

  @override
  State<FloatingMenu> createState() => _FloatingMenuState();
}

class _FloatingMenuState extends State<FloatingMenu> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButtonWidget(
        subButtons: [
        ],
        mainButton: FloatingActionButton(
          heroTag: 'mainButton',
          onPressed: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          backgroundColor: AppColor.primary,
          child: Icon(isExpanded ? Icons.close : FontAwesomeIcons.microchip),
        ),
        isExpanded: isExpanded,
      ),
    );
  }
}