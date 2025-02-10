import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce_app/connect/ip_connect.dart';
import 'package:e_commerce_app/models/wishlist_models.dart';
import '../Local/service_token.dart';
import 'package:http/http.dart' as http;

class WishlistApi {
  Future<String?> _getToken() async {
    try {
      return await ServiceToken.getToken();
    } catch (e) {
      log('Error retrieving token: $e');
      return null;
    }
  }

  Future<WishlistModels> getWishList() async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Token is null');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/wishlists'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return WishlistModels.fromJson(jsonResponse);
    } else {
      log('Failed to get wishlist: ${response.body}');
      throw Exception('Failed to load wishlist');
    }
  }

  Future<bool> addWishlist(String productId) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw Exception('Token is null');
      }

      final requestBody = {
        'productId': productId,
      };

      final response = await http.post(
        Uri.parse('$baseUrl/api/wishlists'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        log('Failed to add item to wishlist: ${response.body}');
        return false;
      }
    } catch (e) {
      log('Error adding to wishlist: $e');
      return false;
    }
  }

  Future<bool> removeWishlist(String productId) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw Exception('Token is null');
      }

      final response = await http.delete(
        Uri.parse('$baseUrl/api/wishlists/$productId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true; // Successfully removed
      } else {
        log('Failed to delete wishlist item: ${response.body}');
        return false;
      }
    } catch (e) {
      log('Error removing from wishlist: $e');
      return false;
    }
  }
}
