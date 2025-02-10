class CategoryModels {
  final String id, name, icon;
  CategoryModels(
      {required this.id, required this.name,required this.icon});
  factory CategoryModels.fromjson(Map<String, dynamic> json) {
    return CategoryModels(
        id: json['_id'], name: json['name'],  icon: json['icon']);
  }
}
