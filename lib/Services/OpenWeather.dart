import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey;
  final String _currentWeatherUrl;
  final String _fiveDayForecastUrl;


  WeatherService(this.apiKey)
      : _currentWeatherUrl =
  'https://api.openweathermap.org/data/2.5/weather?q=saida&mode=json&appid=$apiKey',
        _fiveDayForecastUrl =
        'https://api.openweathermap.org/data/2.5/forecast?q=saida&mode=json&appid=$apiKey';

  Future<Map<String, dynamic>> fetchCurrentWeather() async {
    try {
      final response = await http.get(Uri.parse(_currentWeatherUrl));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load current weather data');
      }
    } catch (e) {
      print('Error fetching current weather: $e');
      return {};
    }
  }
}
