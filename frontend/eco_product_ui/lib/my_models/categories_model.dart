class CategoriesModel {
  late int id;
  late String name;
  late String image;
  late String desc;
  late DateTime createdAt;
  late DateTime updatedAt;

  CategoriesModel();

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    image = json['image'] ?? '';
    desc = json['description'] ?? ''; // map từ description
    createdAt = DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String());
    updatedAt = DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String());
  }
}