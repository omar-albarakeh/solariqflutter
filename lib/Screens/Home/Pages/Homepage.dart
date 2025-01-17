import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:solariqflutter/Screens/Auth/UserProfileScreen.dart';
import 'package:solariqflutter/Screens/weather/weatherdatamodel.dart';
import '../../../Config/AppText.dart';
import '../../../Widgets/Home/homewidgets/ReusableCard.dart';
import '../../../Widgets/Home/ThemeNotifier.dart';
import '../../weather/miniweather.dart';
import '../../weather/poweroutput.dart';
import '../../weather/weathermanager.dart';
import '../ColoredLiquidProgressIndicator.dart';
import 'BatteryDetailsPage.dart';
import 'Community/NewsCard.dart';
import 'RealPower/RealTime.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final WeatherManager weatherManager = WeatherManager();
  WeatherDataModel? weatherDataModel;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final data = await weatherManager.fetchWeatherData();
    setState(() {
      weatherDataModel = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.appBarTheme.backgroundColor ?? theme.primaryColor,
          title: const Text(
            'Home',
            style: AppTextStyles.appBarTitle,
          ),
          actions: [
            IconButton(
              icon: Icon(
                theme.brightness == Brightness.dark ? Icons.dark_mode : Icons.light_mode,
              ),
              onPressed: () {
                Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
              },
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Userprofilescreen()),
                );
              },
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: Center(
                    child: Icon(Icons.person)
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (weatherDataModel != null) ...[
                miniWeather(
                  width: double.infinity,
                  height: 250,
                  maxTemp: weatherManager.calculateMaxTemp(weatherDataModel!.fiveDayForecast),
                  maxPowerOutput: weatherManager.calculateMaxPowerOutput(
                    weatherDataModel!.solarRadiationData,
                    PowerOutputCalculator(),
                  ),
                  cloudCondition: weatherDataModel!.currentWeather['clouds'] ?? 'few clouds',
                  context: context,
                ),
              ],

              Row(
                children: [
                  Expanded(child: _buildPowerUsageCard(context, 500)),
                  const SizedBox(width: 16.0),
                  Expanded(child: _buildBatteryCard(context)),
                ],
              ),
              const SizedBox(height: 16.0),

              _buildNewsSection(context),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPowerUsageCard(BuildContext context, double powerDifference) {
    return ReusableCard(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RealTimeMonitoring()),
      ),
      child:Column(
      children: [ColoredLiquidProgressIndicator(
        value: powerDifference / 10,
      ),
        Text("Solar Power available",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)]),
    );
  }

  Widget _buildBatteryCard(BuildContext context) {
    const double batteryLevel = 20;
    return ReusableCard(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LineChartSample()),
      ),
      child: Column(
      children: [
        ColoredLiquidProgressIndicator(
        value: batteryLevel,
        ),
        Text("Battery Power available",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),]),
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