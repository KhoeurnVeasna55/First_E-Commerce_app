

import 'package:e_commerce_app/models/user_models.dart';
import 'package:e_commerce_app/services/apis/user_api.dart';
import 'package:flutter/widgets.dart';

class UserProvider extends ChangeNotifier {
  UserProvider(){
    fetchuser();
  }
  UserModels _userModels =UserModels.empty();
  final UserApi _userApi = UserApi();
  UserModels get user =>_userModels;

  Future<void> fetchuser()async{
    try {
      final crentUser = await _userApi.fetchuser();
      _userModels =crentUser;
      notifyListeners();
    } catch (e) {
      print('error for find crrent user $e');
    }
  }
}