import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Config/AppColor.dart';
import '../../Screens/Home/FloatingMenuePages/ChatwithBot.dart';
import '../../Screens/Home/FloatingMenuePages/FormPage.dart';
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
          FloatingActionButton(
            heroTag: 'button1',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>ChatWithBot()));
            },
            backgroundColor: AppColor.primary,
            child: FaIcon(FontAwesomeIcons.robot),
          ),
          FloatingActionButton(
            heroTag: 'button2',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>FormPage()));
            },
            backgroundColor: AppColor.primary,
            child: Icon(Icons.document_scanner),
          ),
          FloatingActionButton(
            heroTag: 'button3',
            onPressed: () {},
            backgroundColor: AppColor.primary,
            child: Icon(Icons.camera_alt),
          ),
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