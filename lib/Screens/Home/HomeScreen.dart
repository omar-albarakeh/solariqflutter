import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Config/AppText.dart';
import '../../Widgets/Home/CurvedNavBar.dart';
import '../../Widgets/Home/FloatingMenue.dart';
import '../../Widgets/Home/ThemeNotifier.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor:
            theme.appBarTheme.backgroundColor ?? theme.primaryColor,
        title: const Text(
          'Home',
          style: AppTextStyles.appBarTitle,
        ),
        actions: [
          IconButton(
            icon: Icon(
              theme.brightness == Brightness.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: Stack(children: [
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
      ]),
    ));
  }
}
