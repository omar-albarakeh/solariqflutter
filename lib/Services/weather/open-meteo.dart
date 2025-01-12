import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  Future<List<Map<String, dynamic>>> fetchSolarRadiation({
    required double latitude,
    required double longitude,
    bool isHourly = true,
    String timezone = "GMT",
  }) async {
    final String baseUrl = 'https://api.open-meteo.com/v1/forecast';
    final String dataType = isHourly ? "hourly" : "daily";
    final String parameter = isHourly
        ? "shortwave_radiation"
        : "shortwave_radiation_sum";

    final url = Uri.parse(
      '$baseUrl?latitude=$latitude&longitude=$longitude&$dataType=$parameter&timezone=$timezone',
    );

    try {
      final response = await http.get(url);
      print('Request URL: $url'); // For debugging
      print('Response: ${response.body}'); // For debugging

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data[dataType] == null || data[dataType][parameter] == null) {
          throw Exception('Invalid or missing data received from API');
        }

        final List<dynamic> values = List<dynamic>.from(data[dataType][parameter]);
        final List<dynamic> times = List<dynamic>.from(data[dataType]['time']);

        if (values.length != times.length) {
          throw Exception('Mismatched data lengths in API response');
        }

        return List.generate(values.length, (index) {
          return {
            'time': times[index],
            'radiation': values[index],
          };
        });
      } else {
        throw Exception(
            'Failed to load solar radiation data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching solar radiation: $e');
      return [];
    }
  }
}
