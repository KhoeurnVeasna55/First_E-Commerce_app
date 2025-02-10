import 'dart:collection';

class ProductItems {
  final dynamic id, name, description, price, categoryID, brand, stock, ratings, createdBy;
  final List<String> images;

  ProductItems({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryID,
    required this.stock,
    required this.ratings,
    required this.brand,
    required this.createdBy,
    required List<String> images,
  }) : images = UnmodifiableListView(images);

  factory ProductItems.fromJson(Map<String, dynamic> json) {
    List<String> imageUrls = [];
    if (json['images'] != null && json['images'] is List) {
      for (var image in json['images']) {
        if (image is Map<String, dynamic> && image['url'] != null) {
          imageUrls.add(image['url']);
        }
      }
    }

    return ProductItems(
      id: json['_id'] ?? '',
      name: json['name'] ?? 'Unknown',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      categoryID: json['categoryId'] ?? '',
      brand: json['brand'] ?? 'Unknown',
      stock: json['stock'] ?? 0,
      ratings: json['ratings'] ?? 0,
      createdBy: json['createdBy'] ?? '',
      images: imageUrls,
    );
  }

  ProductItems.empty()
      : id = '',
        name = '',
        description = '',
        price = 0,
        categoryID = '',
        brand = '',
        stock = 0,
        ratings = 0,
        createdBy = '',
        images = [];

  @override
  String toString() {
    return 'ProductItems(id: $id, name: $name, description: $description, price: $price, '
           'categoryID: $categoryID, brand: $brand, stock: $stock, ratings: $ratings, '
           'createdBy: $createdBy, images: $images)';
  }
}
