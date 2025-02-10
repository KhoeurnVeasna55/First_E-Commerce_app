import 'package:e_commerce_app/models/products_models.dart';

class Cart {
  final String id;
  final String userId;
  List<CartItem> items;

  Cart({
    required this.id,
    required this.userId,
    required this.items,
  });
  factory Cart.fromJson(Map<String, dynamic> json) {
    final cartId = json['_id'] ?? '';
    final userId = json['user'] ?? '';

    // Handle null or missing 'items' field
    List<CartItem> items = [];
    if (json.containsKey('items') && json['items'] is List) {
      items = (json['items'] as List)
          .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return Cart(
      id: cartId,
      userId: userId,
      items: items,
    );
  }

  factory Cart.empty() {
    return Cart(id: '', userId: '', items: []);
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     '_id': id,
  //     'user': userId,
  //     'items': items.map((item) => item.toJson()).toList(),
  //   };
  // }
}

class CartItem {
  String id;
  final ProductItems product;
  int quantity;

  CartItem({
    required this.id,
    required this.product,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    final itemId = json['_id'] ?? '';
    final product = ProductItems.fromJson(json['product']);

    return CartItem(
      id: itemId,
      product: product,
      quantity: json['quantity'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     '_id': id,
  //     'product': product.toJson(),
  //     'quantity': quantity,
  //   };
  // }
}
