import 'dart:convert';
import 'dart:developer';


import 'package:e_commerce_app/connect/ip_connect.dart';
import 'package:e_commerce_app/models/user_models.dart';
import 'package:e_commerce_app/services/Local/service_token.dart';
import 'package:http/http.dart' as http;

import 'package:jwt_decoder/jwt_decoder.dart';

class UserApi {
  Future<String?> _gettoken() async {
    return await ServiceToken.getToken();
  }

  Future<UserModels> fetchuser() async {
    final token = await _gettoken();
    if (token == null) {
      return UserModels.empty();
    }
    final userId = JwtDecoder.decode(token)['id'];
    final response =
        await http.get(Uri.parse('$baseUrl/api/users/$userId'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    );
    
    if(response.statusCode==200){
      final Map<String,dynamic>jsonResponse = jsonDecode(response.body);
      return UserModels.fromJson(jsonResponse);
    }else{
      log('erorr to find crrent user ${response.body}');
      return UserModels.empty();
    }
  }
}
