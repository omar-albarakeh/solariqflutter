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
      final weatherService = WeatherService();
      final solarData = await weatherService.fetchSolarRadiation(
        latitude: 33.88863,
        longitude: 35.49548,
        isHourly: true,
        timezone: "EET",
      );

      setState(() {
        this.currentWeather = currentWeatherData;
        this.fiveDayForecast = fiveDayForecastData;
        this.solarRadiationData = solarData;
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
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (currentWeather.isNotEmpty) ...[
                  _buildCurrentWeatherAndPowerOutput(),
                  SizedBox(height: 20),
                ],
                if (fiveDayForecast.isNotEmpty) ...[
                  _buildSectionTitle('5-Day Forecast'),
                  _buildDailyForecastAtNoon(solarRadiationData),
                  SizedBox(height: 20),
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
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return "${_formatDayOfWeek(dateTime)}, ${_formatDate(
        dateTime)} at ${_formatTime(dateTime)}";
  }

  String _formatDayOfWeek(DateTime dateTime) {
    return [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ][dateTime.weekday - 1];
  }

  String _formatDate(DateTime dateTime) {
    return "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month
        .toString().padLeft(2, '0')}-${dateTime.year}";
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  Widget _buildSectionTitle(String title, {IconData? icon}) {
    return Row(
      children: [
        if (icon != null)
          Icon(
            icon,
            color: Colors.white,
            size: 28,
          ),
        if (icon != null) SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.4),
                offset: Offset(1, 1),
                blurRadius: 4,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentWeatherAndPowerOutput() {
    double maxTemp = double.negativeInfinity;
    double minTemp = double.infinity;

    for (var forecast in fiveDayForecast) {
      double temperatureInCelsius = double.parse(forecast['temperature']) -
          273.15;
      if (temperatureInCelsius > maxTemp) maxTemp = temperatureInCelsius;
      if (temperatureInCelsius < minTemp) minTemp = temperatureInCelsius;
    }

    minTemp = minTemp <= -50 ? -50 : minTemp;

    double maxPowerOutput = double.negativeInfinity;
    double minPowerOutput = double.infinity;

    for (var radiation in solarRadiationData) {
      double radiationValue = radiation['radiation'];
      double powerOutput = calculatePowerOutput(radiationValue);

      if (powerOutput > maxPowerOutput) maxPowerOutput = powerOutput;
      if (powerOutput < minPowerOutput) minPowerOutput = powerOutput;
    }

    minPowerOutput = minPowerOutput <= 0 ? 0.1 : minPowerOutput;

    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: getCloudIcon(currentWeather['clouds'] ?? ''),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: SingleChildScrollView(
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
                      size: 30,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_upward,
                              color: Colors.orange,
                              size: 22,
                            ),
                            Text(
                              'Max Temp: ${maxTemp.toStringAsFixed(1)} °C',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1, 1),
                                    blurRadius: 5,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_downward,
                              color: Colors.blue,
                              size: 22,
                            ),
                            Text(
                              'Min Temp: ${minTemp.toStringAsFixed(1)} °C',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1, 1),
                                    blurRadius: 5,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(
                              Icons.cloud,
                              color: Colors.white70,
                              size: 22,
                            ),
                            Text(
                              'Condition: ${currentWeather['weatherMain'] ??
                                  'N/A'}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1, 1),
                                    blurRadius: 5,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(
                              Icons.sunny,
                              color: Colors.yellow,
                              size: 22,
                            ),
                            Text(
                              'Sunrise: ${_formatTimestamp(
                                  currentWeather['sunrise'])}',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white70),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(
                              Icons.shield_moon,
                              color: Colors.orange,
                              size: 22,
                            ),
                            Text(
                              'Sunset: ${_formatTimestamp(
                                  currentWeather['sunset'])}',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white70),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                _buildSectionTitle('Power Output Data'),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(
                      Icons.power,
                      color: Colors.yellow,
                      size: 22,
                    ),
                    Text(
                      'Max Power Output: ${maxPowerOutput.toStringAsFixed(
                          2)} kW',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 5,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.power,
                      color: Colors.blue,
                      size: 22,
                    ),
                    Text(
                      'Min Power Output: ${minPowerOutput.toStringAsFixed(
                          2)} kW',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                        shadows: [
                          Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 5,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
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

  Widget _buildDailyForecastAtNoon(List<Map<String, dynamic>> solarRadiationData) {
    final now = DateTime.now();

    final dailyNoonForecast = fiveDayForecast.where((forecast) {
      final forecastTime = DateTime.parse(forecast['time']);
      return forecastTime.hour == 12 && forecastTime.isAfter(now);
    }).toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(dailyNoonForecast.length, (index) {
            final forecast = dailyNoonForecast[index];
            final forecastTime = DateTime.parse(forecast['time']);
            final temperatureInCelsius =
                double.parse(forecast['temperature']) - 273.15;
            final cloudCondition = forecast['cloudsValue'] ?? '';
            final correspondingRadiationData = solarRadiationData.firstWhere(
                  (radiation) {
                final radiationTime = DateTime.parse(radiation['time']);
                return radiationTime.year == forecastTime.year &&
                    radiationTime.month == forecastTime.month &&
                    radiationTime.day == forecastTime.day &&
                    radiationTime.hour == 12;
              },
              orElse: () => {'radiation': 0.0},
            );
            final radiationValue = correspondingRadiationData['radiation'];
            final powerOutput = calculatePowerOutput(radiationValue);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                color: Colors.white.withOpacity(0.7),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: getCloudIcon(cloudCondition),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Date: ${forecastTime.toIso8601String().substring(0, 10)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Temperature: ${temperatureInCelsius.toStringAsFixed(1)} °C\nClouds: ${forecast['cloudsValue']}',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Power Output: ${powerOutput.toStringAsFixed(2)} kW',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }




  Widget _buildSolarRadiationData() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (var radiation in solarRadiationData)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      'Time: ${radiation['time']}',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Radiation: ${radiation['radiation']} W/m²',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Power Output: ${calculatePowerOutput(
                              radiation['radiation']).toStringAsFixed(2)} kW',
                          style: TextStyle(fontSize: 16, color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}