import 'dart:developer';

import 'package:e_commerce_app/models/products_models.dart';

import 'package:flutter/widgets.dart';

import '../services/apis/product_api.dart';


class ProductProvider extends ChangeNotifier {
  ProductProvider() {
    fetchProducts();
  }

  final ProductApi _productApi = ProductApi();
  final List<ProductItems> _products = [];

  List<ProductItems> get products => _products;

  Future<void> fetchProducts() async {
    try {
      final listPro = await _productApi.fetchProducts();
      _products.clear(); // Ensure the list is fresh
      _products.addAll(listPro);
      notifyListeners();
    } catch (error) {
      log('Error fetching products: $error'); // Log error
    }
  }

  Future<void> fetchProductsByCategory(String categoryId) async {
    try {
      final listPro = await _productApi.fetchProductsById(categoryId);
      _products.clear();
      _products.addAll(listPro);
      notifyListeners();
    } catch (error) {
      log('Error fetching products by category: $error'); // Log error
    }
  }
  
}
