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

}
