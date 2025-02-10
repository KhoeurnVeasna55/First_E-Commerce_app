import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce_app/connect/ip_connect.dart';

import 'package:e_commerce_app/services/Local/service_token.dart';
import 'package:http/http.dart' as http;

import '../../models/products_models.dart';
class ProductApi {
  Map<String, String>? headers(String token) {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
  }

  Future<List<ProductItems>> fetchProducts() async {
    var url = Uri.parse('$baseUrl/api/products');
    final token = await _getToken();
    var response = await http.get(
      url,
      headers: headers(token!),
    );
    if (response.statusCode == 200) {
      final productJson = jsonDecode(response.body) as List;
      return productJson
          .map((product) => ProductItems.fromJson(product))
          .toList();
    } else {
      log('error fetching Products: ${response.body}');
      return List.empty();
    }
  }

  Future<List<ProductItems>> fetchProductsById(String categoryId) async {
    var url = Uri.parse('$baseUrl/api/products/$categoryId');


    final token = await _getToken();
    var response = await http.get(
      url,
      headers: headers(token!),
    );
    if (response.statusCode == 200) {
      final productJson = jsonDecode(response.body) as List;
      return productJson
          .map((product) => ProductItems.fromJson(product))
          .toList();
    } else {
      log('error fetching Products: ${response.body}');
      return List.empty();
    }
  }

  Future<String?> _getToken() async {
    return await ServiceToken.getToken();
  }
}
