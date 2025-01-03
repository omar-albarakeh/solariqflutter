import 'package:flutter/material.dart';
import '../../Widgets/Home/CurvedNavBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            const Column(
              children: [
                Expanded(
                  child: NavBar(),
                ),
              ],
            ),

          ]),
    );
  }
}