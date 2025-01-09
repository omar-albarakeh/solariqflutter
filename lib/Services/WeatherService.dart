import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {

  Future<List<Map<String, dynamic>>> fetchSolarRadiation(
      double latitude, double longitude) async {
    final String baseUrl = 'https://api.open-meteo.com/v1/forecast';
    final url = Uri.parse(
        '$baseUrl?latitude=$latitude&longitude=$longitude&hourly=shortwave_radiation');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final radiationData = data['hourly']['shortwave_radiation'];

        return radiationData
            .asMap()
            .entries
            .map((entry) => {'time': data['hourly']['time'][entry.key], 'radiation': entry.value})
            .toList();
      } else {
        throw Exception('Failed to load solar radiation data');
      }
    } catch (e) {
      print('Error fetching solar radiation: $e');
      return [];
    }
  }
}