import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce_app/connect/ip_connect.dart';
import 'package:e_commerce_app/models/category_models.dart';
import 'package:e_commerce_app/services/Local/service_token.dart';
import 'package:http/http.dart' as http;



class CategoryApi {
  Future<List<CategoryModels>> fetchCategories() async {
    var url = Uri.parse('$baseUrl/api/categories');
    final token = await _getToken();
    var response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    });
    if (response.statusCode == 200) {
      final categoryJson = jsonDecode(response.body) as List;
      return categoryJson
          .map((category) => CategoryModels.fromjson(category))
          .toList();
    } else {
      log('error fetching Categorry: ${response.body}');
      return List.empty();
    }
  }

  Future<String?> _getToken() async {
    return await ServiceToken.getToken();
  }
}
