import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../../Screens/Home/Pages/ChatPage.dart';
import '../../Screens/Home/Pages/CommunityPage.dart';
import '../../Screens/Home/Pages/Homepage.dart';
import '../../Screens/Home/Pages/MarketPage.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  int _currentIndex = 0;

  final List<Widget> _pages = [
    Homepage(),
    MarketPage(),
    CommunityPage(),
    ChatPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
    );
  }
}
