import 'dart:developer';
import 'package:e_commerce_app/models/cart_medels.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../connect/ip_connect.dart';
import '../Local/service_token.dart';

class CartApi {
  Future<bool> addToCart(String productId, int quantity) async {
    try {
      final url = Uri.parse('$baseUrl/api/carts');
      final token = await _getToken();
      if (token == null) {
        log('Failed to retrieve token');
        return false;
      }
      final requestBody = {
        'items': [
          {'product': productId, 'quantity': quantity}
        ]
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        log('Failed to add item to cart: ${response.body}');
        return false;
      }
    } catch (e) {
      log('Error adding item to cart: $e');
      return false;
    }
  }

  // Retrieve the token
  Future<String?> _getToken() async {
    try {
      return await ServiceToken.getToken();
    } catch (e) {
      log('Error retrieving token: $e');
      return null;
    }
  }

  Future<Cart> removeCart(String cartId, String itemId) async {
    final token = await _getToken();
    if (token == null) {
      log('Failed to retrieve token to remove');
      return Cart.empty();
    }
    final response = await http.delete(
      Uri.parse('$baseUrl/api/carts/$cartId/items/$itemId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return Cart.fromJson((jsonResponse));
    } else {
      log('Failed to delect cart: ${response.body}');
      throw Exception('Failed to delect cart');
    }
  }

  Future<Cart> getCart() async {
    final token = await _getToken();
    if (token == null) {
      log('Failed to retrieve token');
      return Cart.empty();
    }
    final response = await http.get(Uri.parse('$baseUrl/api/carts'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return Cart.fromJson((jsonResponse));
    } else {
      log('Failed to load cart: ${response.body}');
      throw Exception('Failed to load cart');
    }
  }
 Future<Cart> updateCart(String cartId, String itemId, int quantity) async {
    final token = await _getToken();
    if (token == null) {
      log('Failed to retrieve token to update');
      return Cart.empty();
    }
    final requestBody = {
      'quantity': quantity,
      
    };
    final response = await http.patch(
      Uri.parse('$baseUrl/api/carts/$cartId/items/$itemId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(requestBody),
    );
   
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return Cart.fromJson((jsonResponse));
    } else {
      
      throw Exception('Failed to update cart');
    }
  }

}
