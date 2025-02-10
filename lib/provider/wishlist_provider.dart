import 'dart:developer';
import 'package:e_commerce_app/models/products_models.dart';
import 'package:e_commerce_app/models/wishlist_models.dart';
import 'package:e_commerce_app/services/apis/wishlist_api.dart';
import 'package:flutter/material.dart';

class WishlistProvider extends ChangeNotifier {
  final WishlistApi _wishlistApi = WishlistApi();
  WishlistModels _wishlistModels = WishlistModels.empty();
  WishlistModels get wishlistModels => _wishlistModels;

  WishlistProvider() {
    fetchWishlist();
  }

  Future<void> fetchWishlist() async {
    try {
      final wishlistModels = await _wishlistApi.getWishList();
      _wishlistModels = wishlistModels;
      notifyListeners();
      log(_wishlistModels.products.length.toString());
        } catch (e) {
      log('Failed to fetch wishlist: $e');
    }
  }

  Future<void> toggleWishlist(ProductItems product) async {
    int index = _wishlistModels.products
        .indexWhere((item) => item.id == product.id);

    try {
      if (index == -1) {
        // Product not in wishlist, add it
        final isAdded = await _wishlistApi.addWishlist(product.id);
        if (isAdded) {
          _wishlistModels.products.add(product);
          notifyListeners();
          
        } else {
          log('Failed to add item to wishlist.');
        }
      } else {
        final isRemoved = await _wishlistApi.removeWishlist(product.id);
        if (isRemoved) {
          _wishlistModels.products.removeAt(index);
          notifyListeners();
          
        } else {
          log('Failed to remove item from wishlist.');
        }
        isInWishlist(product.id);
      }
    } catch (e) {
      debugPrint('Failed to toggle wishlist: $e');
    }
  }

  bool isInWishlist(String productId) {
    return _wishlistModels.products.any((product) => product.id == productId);
  }

  

  
}
