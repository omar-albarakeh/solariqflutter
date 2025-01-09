import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_animation/weather_animation.dart';
import '../../../Config/AppText.dart';
import '../../../Services/OpenWeather.dart';
import '../../../Services/open-meteo.dart';
import '../../../Widgets/Home/ThemeNotifier.dart';

class WeatherPrediction extends StatefulWidget {
  const WeatherPrediction({super.key});

  @override
  State<WeatherPrediction> createState() => _WeatherPredictionState();
}

class _WeatherPredictionState extends State<WeatherPrediction> {
  final double systemSize = 5.0;
  final double efficiency = 0.18;
  final double performanceRatio = 0.85;

  Map<String, dynamic> currentWeather = {};
  List<Map<String, dynamic>> fiveDayForecast = [];
  List<Map<String, dynamic>> solarRadiationData = [];

  final OpenWeatherService openWeatherService = OpenWeatherService(
      'bb0cae202637e279b059eb133515cce8');
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
      final solarRadiationData = await weatherService.fetchSolarRadiation(
          33.8938, 35.5018);

      setState(() {
        this.currentWeather = currentWeatherData;
        this.fiveDayForecast = fiveDayForecastData;
        this.solarRadiationData = solarRadiationData;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Widget getCloudIcon(String cloudSituation) {
    switch (cloudSituation.toLowerCase()) {
      case 'clear sky':
        return WeatherScene.scorchingSun.sceneWidget;
      case 'few clouds':
        return WeatherScene.scorchingSun.sceneWidget;
      case 'scattered clouds':
        return WeatherScene.frosty.sceneWidget;
      case 'broken clouds':
        return WeatherScene.weatherEvery.sceneWidget;
      case 'overcast clouds':
        return WeatherScene.frosty.sceneWidget;
      case 'light rain':
        return WeatherScene.weatherEvery.sceneWidget;
      case 'moderate rain':
        return WeatherScene.showerSleet.sceneWidget;
      case 'heavy intensity rain':
        return WeatherScene.stormy.sceneWidget;
      default:
        return WeatherScene.snowfall.sceneWidget;
    }
  }



  double calculatePowerOutput(double shortwaveRadiation) {
    return shortwaveRadiation * systemSize * efficiency * performanceRatio;
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (currentWeather.isNotEmpty) ...[
                _buildCurrentWeather(),
                SizedBox(height: 20),
              ],
              if (fiveDayForecast.isNotEmpty) ...[
                _buildSectionTitle('5-Day Forecast'),
                _buildFiveDayForecast(),
                SizedBox(height: 20),
              ],
              if (solarRadiationData.isNotEmpty) ...[
                _buildSectionTitle('Solar Radiation Data'),
                _buildSolarRadiationData(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatTimestamp(int? timestamp) {
    if (timestamp == null) return 'N/A';
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000).toString();
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildCurrentWeather() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Current Weather'),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Temperature: ${(currentWeather['temperature'] - 273.15).toStringAsFixed(1)} °C',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: getCloudIcon(currentWeather['clouds'] ?? ''),
                ),
              ],
            ),
            Text('Weather: ${currentWeather['weatherMain'] ?? 'N/A'}'),
            Text('Sunrise: ${_formatTimestamp(currentWeather['sunrise'])}'),
            Text('Sunset: ${_formatTimestamp(currentWeather['sunset'])}'),
          ],
        ),
      ),
    );
  }

  Widget _buildFiveDayForecast() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: fiveDayForecast.length,
      itemBuilder: (context, index) {
        final forecast = fiveDayForecast[index];
        final temperatureInCelsius = double.parse(forecast['temperature']) - 273.15;

        return Card(
          child: ListTile(
            title: Text('Time: ${forecast['time']}'),
            subtitle: Text(
              'Temperature: ${temperatureInCelsius.toStringAsFixed(1)} °C\nClouds: ${forecast['cloudsValue']}',
            ),
            leading: SizedBox(
              width: 50,
              height: 50,
              child: getCloudIcon(forecast['cloudsValue'] ?? ''),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSolarRadiationData() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: solarRadiationData.length,
      itemBuilder: (context, index) {
        final radiation = solarRadiationData[index];
        final powerOutput = calculatePowerOutput(radiation['radiation']);
        return Card(
          child: ListTile(
            title: Text('Time: ${radiation['time']}'),
            subtitle: Text(
              'Radiation: ${radiation['radiation']} W/m²\nPower Output: ${powerOutput.toStringAsFixed(2)} kW',
            ),
          ),
        );
      },
    );
  }
}
