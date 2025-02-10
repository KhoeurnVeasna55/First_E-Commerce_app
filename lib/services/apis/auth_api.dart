import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce_app/connect/ip_connect.dart';
import 'package:e_commerce_app/services/Local/service_token.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../../utils/snackbar_page.dart';

class AuthApi {
  
  static Future<bool> login(
      BuildContext context, String email, String password) async {
    var url = Uri.parse('$baseUrl/api/users/login');
    var response = await http.post(url,
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: {
          "x-api-key": "my_super_secret_key",
          'Content-Type': 'application/json'
        });
    log(response.body);
    if (response.statusCode == 201) {

      final jsonresonse = jsonDecode(response.body);
      final token = jsonresonse ['token'] ;      
      await ServiceToken.setToken(token);
      log('Token: $token');
      if (context.mounted) {
        SnackbarPage.showSnackbar(context, 'Login Successful');
      }
      return true;
    } else {
      if (context.mounted) {
        SnackbarPage.showSnackbar(context, 'Login Failed');
      }
      return false;
    }
  }

  static Future register(BuildContext context, String email, String password, String username) async {
    var url = Uri.parse('$baseUrl/api/users/register');
    var response = await http.post(url,
        body: jsonEncode({
          'name': username,
          'email': email,
          'password': password,
        }),
        headers: {
          "x-api-key": "my_super_secret_key",
          'Content-Type': 'application/json'
        });
    if (response.statusCode == 201) {
      if(!context.mounted)return;
      SnackbarPage.showSnackbar(context, 'Register Successful');
       final jsonresonse = jsonDecode(response.body);
      final token = jsonresonse ['token'] ;      
      await ServiceToken.setToken(token);
      return true;
    } else {
      if(!context.mounted)return;
      SnackbarPage.showSnackbar(context, 'Register Failed');
      return false;
    }
  }
}

