import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solariqflutter/Screens/Auth/UserProfileScreen.dart';
import 'package:solariqflutter/Screens/Home/Pages/WeatherPrediction.dart';
import '../../../Config/AppText.dart';
import '../../../Widgets/Home/homewidgets/ReusableCard.dart';
import '../../../Widgets/Home/ThemeNotifier.dart';
import '../../../model/Home/CardData.dart';
import 'Community/NewsCard.dart';
import 'BatteryDetailsPage.dart';
import 'PowerUsageDetailsPage.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Weather Information Card
                _buildWeatherCard(context),
                const SizedBox(height: 16.0),

                // Power Usage and Battery Information Cards
                Row(
                  children: [
                    Expanded(child: _buildPowerUsageCard(context)),
                    const SizedBox(width: 16.0),
                    Expanded(child: _buildBatteryCard(context)),
                  ],
                ),
                const SizedBox(height: 16.0),

                // Solar News Section
                _buildNewsSection(context),

                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Userprofilescreen()));
                }, child:Text("userprofile"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherCard(BuildContext context) {
    return ReusableCard(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Weatherprediction()),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '23 °C',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Beirut, Lebanon\nPartially Cloudy'),
              Icon(Icons.wb_sunny, size: 32, color: Colors.orange.shade700),
            ],
          ),
          const SizedBox(height: 8.0),
          const Text(
            'You may have a thunderstorm in your location. Turn off your panels!',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildPowerUsageCard(BuildContext context) {
    final data = CardData(
      title: '6 kW Used',
      description: '',
      icon: Icons.bolt,
      iconColor: Colors.yellow.shade700,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PowerUsageDetailsPage()),
      ),
    );
    return _buildCardFromData(data);
  }

  Widget _buildBatteryCard(BuildContext context) {
    final data = CardData(
      title: '67% | 1 hour left',
      description: '',
      icon: Icons.battery_full,
      iconColor: Colors.green.shade600,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BatteryDetailsPage()),
      ),
    );
    return _buildCardFromData(data);
  }

  Widget _buildCardFromData(CardData data) {
    return ReusableCard(
      onTap: data.onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(data.icon, size: 32, color: data.iconColor),
          const SizedBox(height: 8.0),
          Text(
            data.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsSection(BuildContext context) {
    return ReusableCard(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Solar News',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (_, __) => const SizedBox(height: 8.0),
            itemBuilder: (context, index) => NewsCard(
              title: 'Eng Name',
              description: 'Description goes here...',
              onAskEngTap: () {
                // Action for Ask Eng
              },
            ),
          ),
        ],
      ),
    );
  }
}
