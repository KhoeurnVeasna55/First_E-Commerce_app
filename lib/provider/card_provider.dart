import 'dart:developer';
import 'package:flutter/material.dart';
import '../models/cart_medels.dart';
import '../services/apis/cart_api.dart';

class CartProvider extends ChangeNotifier {
  Cart _cart = Cart.empty();
  final CartApi _cartApi = CartApi();
  double total = 0.0;

  CartProvider() {
    fetchCart();
  }

  Cart get cart => _cart;

  // Fetch cart from the API
  Future<void> fetchCart() async {
    try {
      final cart = await _cartApi.getCart();
      _cart = cart;
      notifyListeners();  
    } catch (e) {
      log('Error fetching cart: $e');
    }
    totalCart(); 
  }

  // Remove item from the cart
  Future<void> removeCartItem(String cartId, String itemId) async {
    try {
      int index = _cart.items.indexWhere((items) => items.id == itemId);
      if (index != -1) {
        _cart.items.removeAt(index);
        notifyListeners(); 
        await _cartApi.removeCart(cartId, itemId);  
      }
    } catch (e) {
      log('Error removing item from cart: $e');
    }
    totalCart();  
  }

  
  Future<void> updateQty(String cartId, String itemId, int quantity) async {
    try {
      int index = _cart.items.indexWhere((items) => items.id == itemId);
      if (index != -1 && quantity > 0) {
        _cart.items[index].quantity = quantity;  
        notifyListeners(); 
        await _cartApi.updateCart(cartId, itemId, quantity);  
      } else {
        _cart.items.removeAt(index);  
        notifyListeners(); 
        await _cartApi.removeCart(cartId, itemId); 
      }
    } catch (e) {
      log('Error updating item quantity: $e');
    }
    totalCart();  // Recalculate total cart value
  }

  // Add item to cart
  Future<void> addCart(CartItem item) async {
    try {
      int index = _cart.items.indexWhere((cartItem) => cartItem.product.id == item.product.id);
      if (index != -1) {
        // Item exists, update quantity
        int newQuantity = _cart.items[index].quantity + 1;  // Increase quantity by 1
        _cart.items[index].quantity = newQuantity;  // Update locally
        notifyListeners();  // Notify listeners to update the UI
        await _cartApi.updateCart(_cart.id, _cart.items[index].id, newQuantity);  // Update backend
      } else {
        // Item does not exist, add it with quantity 1
        item.quantity = 1;
        await _cartApi.addToCart(item.product.id, item.quantity);  // Add item to backend
        _cart.items = List.from(_cart.items)..add(item);  // Update locally
        notifyListeners();  
      }
      totalCart();  // Recalculate total cart value
    } catch (e) {
      log('Error adding item to cart: $e');
    }
  }

  // Recalculate the total cart value
  Future<void> totalCart() async {
    total = 0.0;
    for (var item in _cart.items) {
      double price = (item.product.price ?? 0.0).toDouble();
      double qty = item.quantity.toDouble();
      total += price * qty;
    }
    notifyListeners();  
    log('Total Cart Price: $total');
  }
}
