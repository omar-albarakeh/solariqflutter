import 'open-meteo.dart';

void main() async {
  final weatherService = WeatherService();

  // Example 1: Fetch Hourly Solar Radiation Data
  print('Fetching hourly solar radiation data...');
  final hourlyData = await weatherService.fetchSolarRadiation(
    latitude: 40.7128, // Latitude for New York City
    longitude: -74.0060, // Longitude for New York City
    isHourly: true, // Request hourly data
  );

  if (hourlyData.isNotEmpty) {
    print('Hourly Solar Radiation Data:');
    for (var data in hourlyData) {
      print('Time: ${data['time']}, Radiation: ${data['radiation']} W/m²');
    }
  } else {
    print('No hourly data received.');
  }

  print('\n----------------------\n');

  // Example 2: Fetch Daily Solar Radiation Data
  print('Fetching daily solar radiation data...');
  final dailyData = await weatherService.fetchSolarRadiation(
    latitude: 52.52, // Latitude for Berlin
    longitude: 13.41, // Longitude for Berlin
    isHourly: false, // Request daily data
    timezone: "America/Anchorage", // Custom timezone for daily alignment
  );

  if (dailyData.isNotEmpty) {
    print('Daily Solar Radiation Data:');
    for (var data in dailyData) {
      print('Date: ${data['time']}, Radiation: ${data['radiation']} MJ/m²');
    }
  } else {
    print('No daily data received.');
  }
}
