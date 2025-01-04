import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solariqflutter/Screens/Home/Pages/WeatherPrediction.dart';

import '../../../Config/AppText.dart';
import '../../../Widgets/Home/ThemeNotifier.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
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
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(children: [
            _buildWeatherCard(context),
          ]),
        ),
      ),
    );
  }
}

Widget _buildWeatherCard(context) {
  return GestureDetector(
      onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Weatherprediction()),
          ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            '23 °C',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
        ]),
      ));
}
