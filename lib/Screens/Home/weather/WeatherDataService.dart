import '../../../Services/weather/OpenWeather.dart';
import '../../../Services/weather/open-meteo.dart';


class WeatherDataService {
  final OpenWeatherService openWeatherService;
  final WeatherService weatherService;

  WeatherDataService()
      : openWeatherService = OpenWeatherService('bb0cae202637e279b059eb133515cce8'),
        weatherService = WeatherService();

  Future<Map<String, dynamic>> fetchCurrentWeather() async {
    return await openWeatherService.fetchCurrentWeather();
  }

  Future<List<Map<String, dynamic>>> fetchFiveDayForecast() async {
    return await openWeatherService.fetchFiveDayForecast();
  }

  Future<List<Map<String, dynamic>>> fetchSolarRadiation({
    required double latitude,
    required double longitude,
    required bool isHourly,
    required String timezone,
  }) async {
    return await weatherService.fetchSolarRadiation(
      latitude: latitude,
      longitude: longitude,
      isHourly: isHourly,
      timezone: timezone,
    );
  }
}