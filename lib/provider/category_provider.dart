import 'package:e_commerce_app/models/category_models.dart';
import 'package:e_commerce_app/services/apis/category_api.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  CategoryProvider() {
    fetchCategory();
  }

  final CategoryApi _categoryApi = CategoryApi();

  final List<CategoryModels> _categories = [];

  List<CategoryModels> get categories => _categories;

  Future<void> fetchCategory() async {
    final list = await _categoryApi.fetchCategories();
    _categories.addAll(list);
     _categories.insert(0, CategoryModels(name: 'all', id: 'all',icon: '0xe07d'));
    notifyListeners();
  }
 
  
}
