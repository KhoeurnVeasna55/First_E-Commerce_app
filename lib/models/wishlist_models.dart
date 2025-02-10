
import 'products_models.dart';

class WishlistModels {
  final String id ;
  final String useId;
  List<ProductItems> products ; 
  WishlistModels({
    required this.id,required this.useId,required this.products
  });
  factory WishlistModels.fromJson(Map<String,dynamic> json){
    final id =json['_id'] ?? '';
    final userId =json['user'] ?? '';
    final products = (json['products'] as List?)?.map((item) => ProductItems.fromJson(item)).toList() ?? [] ;
    return WishlistModels(id: id, useId: userId, products: products);
  }
  factory WishlistModels.empty(){
    return WishlistModels(id: '', useId: '', products: []);
  }
}