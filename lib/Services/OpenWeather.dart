import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

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
        final data = jsonDecode(response.body);
        final temperature = data['main']['temp'];
        final weatherCode = data['weather'][0]['id'];

        return {'temperature': temperature, 'weatherCode': weatherCode};
      } else {
        throw Exception('Failed to load current weather data');
      }
    } catch (e) {
      print('Error fetching current weather: $e');
      return {};
    }
  }

  Future<List<Map<String, dynamic>>> fetchFiveDayForecast() async {
    try {
      final response = await http.get(Uri.parse(_fiveDayForecastUrl));
      if (response.statusCode == 200) {
        final xmlData = response.body;

        final List<Map<String, dynamic>> parsedData = _parseFiveDayForecast(xmlData);

        return parsedData;
      } else {
        throw Exception('Failed to load 5-day forecast data');
      }
    } catch (e) {
      print('Error fetching 5-day forecast: $e');
      return [];
    }
  }
  List<Map<String, dynamic>> _parseFiveDayForecast(String xmlData) {
    final document = XmlDocument.parse(xmlData);

    final forecastData = <Map<String, dynamic>>[];

    final timeNodes = document.findAllElements('time');
    for (var timeNode in timeNodes) {
      final fromTime = timeNode.getAttribute('from');
      final symbol = timeNode.findElements('symbol').first;
      final weatherCode = symbol.getAttribute('number');
      final temperature = timeNode.findElements('temperature').first.getAttribute('value');

      forecastData.add({
        'time': fromTime,
        'weatherCode': weatherCode,
        'temperature': temperature,
      });
    }

    return forecastData;
  }
}
