import 'package:solariqflutter/Screens/Home/weather/poweroutput.dart';
import 'package:solariqflutter/Screens/Home/weather/weatherdatamodel.dart';

import 'WeatherDataService.dart';

class WeatherManager {
  final WeatherDataService weatherDataService = WeatherDataService();

  Future<WeatherDataModel?> fetchWeatherData() async {
    try {
      final currentWeather = await weatherDataService.fetchCurrentWeather();
      final fiveDayForecast = await weatherDataService.fetchFiveDayForecast();
      final solarRadiationData = await weatherDataService.fetchSolarRadiation(
        latitude: 33.88863,
        longitude: 35.49548,
        isHourly: true,
        timezone: "EET",
      );

      return WeatherDataModel(
        currentWeather: currentWeather,
        fiveDayForecast: fiveDayForecast,
        solarRadiationData: solarRadiationData,
      );
    } catch (e) {
      print('Error fetching weather data: $e');
      return null;
    }
  }

  double calculateMaxTemp(List<Map<String, dynamic>> fiveDayForecast) {
    double maxTemp = double.negativeInfinity;
    for (var forecast in fiveDayForecast) {
      double temperatureInCelsius = double.parse(forecast['temperature']) - 273.15;
      if (temperatureInCelsius > maxTemp) {
        maxTemp = temperatureInCelsius;
      }
    }
    return maxTemp;
  }

  double calculateMaxPowerOutput(
      List<Map<String, dynamic>> solarRadiationData,
      PowerOutputCalculator powerOutputCalculator,
      ) {
    double maxPowerOutput = double.negativeInfinity;
    for (var radiation in solarRadiationData) {
      double radiationValue = radiation['radiation'];
      double powerOutput = powerOutputCalculator.calculatePowerOutput(radiationValue);
      if (powerOutput > maxPowerOutput) {
        maxPowerOutput = powerOutput;
      }
    }
    return maxPowerOutput;
  }
}