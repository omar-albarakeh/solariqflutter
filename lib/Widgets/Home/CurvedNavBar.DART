class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  final List<Widget> _pages = [
    Homepage(),
    MarketPage(),
    CommunityPage(),
    MessagesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
