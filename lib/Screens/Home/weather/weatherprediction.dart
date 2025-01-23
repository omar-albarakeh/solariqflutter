import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solariqflutter/Screens/Home/weather/poweroutput.dart';
import 'package:solariqflutter/Screens/Home/weather/weatherdatamodel.dart';
import 'package:solariqflutter/Screens/Home/weather/weatherui.dart';
import '../../../Config/AppColor.dart';
import '../../../Config/AppText.dart';
import '../../../Widgets/Home/ThemeNotifier.dart';
import 'WeatherDataService.dart';

class WeatherPrediction1 extends StatefulWidget {
  const WeatherPrediction1({super.key});

  @override
  State<WeatherPrediction1> createState() => _WeatherPredictionState();
}

class _WeatherPredictionState extends State<WeatherPrediction1> {
  final WeatherDataService weatherDataService = WeatherDataService();
  final PowerOutputCalculator powerOutputCalculator = PowerOutputCalculator();
  WeatherDataModel? weatherDataModel;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final currentWeather = await weatherDataService.fetchCurrentWeather();
      final fiveDayForecast = await weatherDataService.fetchFiveDayForecast();
      final solarRadiationData = await weatherDataService.fetchSolarRadiation(
        latitude: 33.88863,
        longitude: 35.49548,
        isHourly: true,
        timezone: "EET",
      );

      setState(() {
        weatherDataModel = WeatherDataModel(
          currentWeather: currentWeather,
          fiveDayForecast: fiveDayForecast,
          solarRadiationData: solarRadiationData,
        );
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: const Text(
          'Weather Prediction',
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.background,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (weatherDataModel != null) ...[
                  WeatherUIComponents.buildCurrentWeatherAndPowerOutput(
                    weatherDataModel!.currentWeather,
                    weatherDataModel!.fiveDayForecast,
                    weatherDataModel!.solarRadiationData,
                    weatherDataModel!,
                    powerOutputCalculator,
                  ),
                  SizedBox(height: 20),
                  WeatherUIComponents.buildDailyForecastAtNoon(
                    weatherDataModel!.fiveDayForecast,
                    weatherDataModel!.solarRadiationData,
                    powerOutputCalculator,
                  ),
                  SizedBox(height: 20),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}