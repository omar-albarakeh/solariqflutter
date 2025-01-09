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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.primaryColorLight, theme.primaryColorDark],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
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
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildCurrentWeather() {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: getCloudIcon(currentWeather['clouds'] ?? ''),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 8,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          color: Colors.white.withOpacity(0.85),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSectionTitle('Current Weather'),
                    Icon(
                      Icons.thermostat,
                      color: Colors.orange,
                      size: 24,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Temperature: ${(currentWeather['temperature'] - 273.15).toStringAsFixed(1)} °C',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Condition: ${currentWeather['weatherMain'] ?? 'N/A'}',
                          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Sunrise: ${_formatTimestamp(currentWeather['sunrise'])}',
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Sunset: ${_formatTimestamp(currentWeather['sunset'])}',
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
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
