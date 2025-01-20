import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:xml/xml.dart' as xml;

class OpenWeatherService {
  final String apiKey;
  final String _currentWeatherUrl;
  final String _fiveDayForecastUrl;

  OpenWeatherService(this.apiKey)
      : _currentWeatherUrl =
  'https://api.openweathermap.org/data/2.5/weather?q=saida&mode=json&appid=$apiKey',
        _fiveDayForecastUrl =
        'https://api.openweathermap.org/data/2.5/forecast?q=saida&mode=xml&appid=$apiKey';


  Future<Map<String, dynamic>> fetchCurrentWeather() async {
    try {
      final response = await http.get(Uri.parse(_currentWeatherUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Extract required data
        final temperature = data['main']['temp'];
        final weatherMain = data['weather'][0]['main'];
        final sunrise = data['sys']['sunrise'];
        final sunset = data['sys']['sunset'];
        final clouds = data['weather'][0]['description'];

        return {
          'temperature': temperature,
          'weatherMain': weatherMain,
          'sunrise': sunrise,
          'sunset': sunset,
          'clouds':clouds
        };
      } else {
        throw Exception('Failed to load current weather data: ${response.statusCode}');
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
        final parsedData = _parseFiveDayForecast(xmlData);
        return parsedData;
      } else {
        throw Exception('Failed to load 5-day forecast data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching 5-day forecast: $e');
      return [];
    }
  }

  List<Map<String, dynamic>> _parseFiveDayForecast(String xmlData) {
    final document = xml.XmlDocument.parse(xmlData);
    final forecastData = <Map<String, dynamic>>[];


    final timeNodes = document.findAllElements('time');
    for (var timeNode in timeNodes) {
      final fromTime = timeNode.getAttribute('from');

      final temperatureElement = timeNode.findElements('temperature').first;
      final temperature = temperatureElement.getAttribute('value');

      final cloudsElement = timeNode.findElements('clouds').first;
      final cloudsValue = cloudsElement.getAttribute('value');

      forecastData.add({
        'time': fromTime,
        'temperature': temperature,
        'cloudsValue': cloudsValue,
      });
    }

    return forecastData;
  }
}