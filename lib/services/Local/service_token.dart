import 'dart:developer';

import 'package:get_storage/get_storage.dart';

class ServiceToken {
  static final storage = GetStorage();

  // Save the token
static Future<void> setToken(String token) async {
  try {
    await storage.write('token', token);
    log(' Token stored successfully: ${storage.read<String>('token')}'); // Check if it's saved
  } catch (e) {
    log(' Error saving token: $e');
  }
}


static Future<String?> getToken() async {
  try {
    String? token = storage.read<String>('token');
    log('Retrieved Token: $token');
    return token;
  } catch (e) {
    log('Error retrieving token: $e');
    return null;
  }
}

  // Clear the token
  static Future<void> clearToken() async {
    await storage.remove('token');
  }
}
