import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  Future<List<Map<String, dynamic>>> fetchSolarRadiation(
      double latitude, double longitude, int days) async {
    final String baseUrl = 'https://api.open-meteo.com/v1/forecast';
    final url = Uri.parse(
        '$baseUrl?latitude=$latitude&longitude=$longitude&daily=shortwave_radiation&days=$days');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['daily'] == null ||
            data['daily']['shortwave_radiation'] == null ||
            data['daily']['time'] == null ||
            !(data['daily']['shortwave_radiation'] is List) ||
            !(data['daily']['time'] is List) ||
            data['daily']['shortwave_radiation'].length !=
                data['daily']['time'].length) {
          throw Exception('Invalid or inconsistent data format received from the API');
        }

        final List<double> radiationData =
        List<double>.from(data['daily']['shortwave_radiation']);
        final List<String> timeData = List<String>.from(data['daily']['time']);

        return List.generate(radiationData.length, (index) {
          return {
            'time': timeData[index],
            'radiation': radiationData[index],
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
