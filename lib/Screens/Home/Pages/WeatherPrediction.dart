import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Config/AppText.dart';
import '../../../Services/OpenWeather.dart';
import '../../../Services/open-meteo.dart';
import '../../../Widgets/Home/ThemeNotifier.dart';

class Weatherprediction extends StatefulWidget {
  const Weatherprediction({super.key});

  @override
  State<Weatherprediction> createState() => _WeatherpredictionState();
}

class _WeatherpredictionState extends State<Weatherprediction> {

  final double systemSize = 5.0;
  final double efficiency = 0.18;
  final double performanceRatio = 0.85;

  Map<String, dynamic> currentWeather = {};
  List<Map<String, dynamic>> fiveDayForecast = [];
  List<Map<String, dynamic>> solarRadiationData = [];

  final OpenWeatherService openWeatherService = OpenWeatherService('bb0cae202637e279b059eb133515cce8');
  final WeatherService weatherService = WeatherService();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }
  Future<void> _fetchData() async {
    try {
      final currentWeatherData = await openWeatherService.fetchCurrentWeather();
      final fiveDayForecastData = await openWeatherService.fetchFiveDayForecast();
      final solarRadiationData = await weatherService.fetchSolarRadiation(33.8938, 35.5018);

      setState(() {
        this.currentWeather = currentWeatherData;
        this.fiveDayForecast = fiveDayForecastData;
        this.solarRadiationData = solarRadiationData;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  String getCloudIcon(String cloudSituation) {
    switch (cloudSituation.toLowerCase()) {
      case 'clear sky':
        return '☀️';
      case 'few clouds':
        return '🌤️';
      case 'scattered clouds':
        return '⛅';
      case 'broken clouds':
        return '🌥️';
      case 'overcast clouds':
        return '☁️';
      case 'light rain':
        return '🌦️';
      case 'moderate rain':
        return '🌧️';
      case 'heavy intensity rain':
        return '🌩️';
      default:
        return '❓'; 
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
    ));
  }
}
