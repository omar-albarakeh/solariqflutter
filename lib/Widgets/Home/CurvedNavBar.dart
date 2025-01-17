import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../../Screens/Home/ChatApp/ChatPage.dart';
import '../../Screens/Home/Pages/Community/CommunityPage.dart';
import '../../Screens/Home/Pages/Homepage.dart';
import '../../Screens/Home/Pages/Market/MarketPage.dart';
import '../../Screens/market/marketpage.dart';

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
    final isLightMode = theme.brightness == Brightness.light;

    return Column(
      children: [
        Expanded(
          child: IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),
        ),
        CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: theme.primaryColor,
          buttonBackgroundColor: theme.colorScheme.primary,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            Icon(Icons.home, color: isLightMode ? Colors.white : Colors.black),
            Icon(Icons.shop, color: isLightMode ? Colors.white : Colors.black),
            Icon(Icons.people, color: isLightMode ? Colors.white : Colors.black),
            Icon(Icons.message, color: isLightMode ? Colors.white : Colors.black),
          ],
        ),
      ],
    );
  }
}
