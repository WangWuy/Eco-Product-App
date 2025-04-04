import 'package:eco_product_ui_updated/my_models/categories_model.dart';

class SubCategoriesModel {
  late int id;
  late String name;
  late String image;
  late String desc;
  late String price;
  late int quantity;
  late bool inStock;
  late String type;
  late CategoriesModel category; // Thay đổi từ catId thành category object
  late DateTime createdAt;
  late DateTime updatedAt;

  late String discount;
  late String rating;

  // UI fields
  int isFav = 0;
  int colorPosition = -1;
  int review = 1;
  String reviewDesc = "(4.8)";

  SubCategoriesModel();

  SubCategoriesModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'] ?? 0;
      name = json['name'] ?? '';
      image = json['image'] ?? '';
      desc = json['description'] ?? '';
      price = json['price']?.toString() ?? '0';
      quantity = json['quantity'] ?? 0;
      inStock = json['inStock'] ?? false;
      type = json['type'] ?? '';
      discount = json['discount'] ?? '0.00';
      rating = json['rating'] ?? '0.00';

      // Parse category object
      if (json['category'] != null) {
        category = CategoriesModel.fromJson(json['category']);
      }
      
      createdAt = DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String());
      updatedAt = DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String());

    } catch (e) {
      print('Error mapping product: $e');
      // Set default values if mapping fails
      category = CategoriesModel(); // Initialize empty category
    }
  }
}