import 'package:flutter/material.dart';
import '../../Widgets/Home/CurvedNavBar.dart';
import '../../Widgets/Home/FloatingMenue.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            const Column(
              children: [
                Expanded(
                  child: NavBar(),
                ),
              ],
            ),
            Positioned(
              bottom: 80,
              right: 5,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 70,
                  maxHeight: 300,
                ),
                child: const FloatingMenu(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
