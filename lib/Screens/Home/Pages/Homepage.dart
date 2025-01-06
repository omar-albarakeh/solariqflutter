import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Config/AppText.dart';
import '../../../Widgets/Home/ThemeNotifier.dart';
import 'BatteryDetailsPage.dart';
import 'Community/CommunityPage.dart';
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
                Provider.of<ThemeNotifier>(context, listen: false)
                    .toggleTheme();
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherCard(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12.0),
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
      ),
    );
  }

  Widget _buildPowerUsageCard(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PowerUsageDetailsPage()),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bolt, size: 32, color: Colors.yellow.shade700),
            const SizedBox(height: 8.0),
            const Text(
              '6 kW Used',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBatteryCard(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BatteryDetailsPage()),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.battery_full, size: 32, color: Colors.green.shade600),
            const SizedBox(height: 8.0),
            const Text(
              '67% | 1 hour left',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsSection(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the desired page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CommunityPage()), // Replace with your target page
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12.0),
        ),
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
              itemBuilder: (context, index) => _buildNewsCard(context, 'Eng Name', 'Description goes here...'),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildNewsCard(BuildContext context, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  // Action for "Ask Eng"
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                ),
                child: const Text('Ask Eng',style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            description,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
