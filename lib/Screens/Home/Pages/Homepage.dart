import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solariqflutter/Screens/Home/Pages/WeatherPrediction.dart';

import '../../../Config/AppText.dart';
import '../../../Widgets/Home/ThemeNotifier.dart';
import 'RealTimeMonotering.dart';

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
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(child: _buildPowerUsageCard(context)),
                const SizedBox(width: 16.0),
                Expanded(child: _buildBatteryCard(context)),
              ],
            )
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
        width: 400,
        height: 175,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          const SizedBox(height: 8.0),
        ]),
      ));
}


Widget  _buildPowerUsageCard(context){
  return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RealTimeMonotering()),
      ),
      child: Container(
        width: 175,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          const SizedBox(height: 8.0),
        ]),
      ));
}

Widget  _buildBatteryCard(context){
  return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RealTimeMonotering()),
      ),
      child: Container(
        width: 175,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          const SizedBox(height: 8.0),
        ]),
      ));
}