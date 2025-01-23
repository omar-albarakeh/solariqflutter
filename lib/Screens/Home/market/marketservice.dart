import 'dart:convert';
import 'package:http/http.dart' as http;
import 'itemModule.dart';

class ItemService {
  static const String baseUrl = 'http://192.168.0.102:3001';

  Future<List<Item>> fetchItemsByCategory(String category) async {
    final url = '$baseUrl/items/category/$category';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> itemsJson = data['items'];
        final List<Item> items = itemsJson.map((json) => Item.fromJson(json)).toList();
        return items;
      } else {
        throw Exception('Failed to load items: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching items: $e');
    }
  }

  Future<List<Item>> fetchAllItems({int? limit}) async {
    final url = '$baseUrl/items';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> itemsJson = data['items'];
        List<Item> items = itemsJson.map((json) => Item.fromJson(json)).toList();
        items.shuffle();
        if (limit != null && limit < items.length) {
          items = items.sublist(0, limit);
        }

        return items;
      } else {
        throw Exception('Failed to load items: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching items: $e');
    }
  }
}