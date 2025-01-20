import 'dart:convert';
import 'package:http/http.dart' as http;

class CartService {
  final String baseUrl;
  final String authToken;

  CartService({required this.baseUrl, required this.authToken});

  // Fetch cart data for the logged-in user
  Future<Map<String, dynamic>> fetchCart() async {
    final url = Uri.parse('$baseUrl/cart');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch cart: ${response.statusCode}');
    }
  }

  // Add an item to the cart
  Future<void> addToCart(String itemId, int quantity) async {
    final url = Uri.parse('$baseUrl/cart/add');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: json.encode({'itemId': itemId, 'quantity': quantity}),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add to cart: ${response.statusCode}');
    }
  }

  // Remove an item from the cart
  Future<void> removeFromCart(String itemId) async {
    final url = Uri.parse('$baseUrl/cart/remove');
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: json.encode({'itemId': itemId}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to remove from cart: ${response.statusCode}');
    }
  }

  // Clear the cart
  Future<void> clearCart() async {
    final url = Uri.parse('$baseUrl/cart/clear');
    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to clear cart: ${response.statusCode}');
    }
  }
}
