// CartItem model
import 'package:eco_product_ui_updated/my_models/sub_category_model.dart';

class CartItem {
  final int id;
  final int cartId;
  final int productId;
  final int quantity;
  final SubCategoriesModel product;

  CartItem({
    required this.id,
    required this.cartId,
    required this.productId,
    required this.quantity,
    required this.product,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      cartId: json['cartId'],
      productId: json['productId'],
      quantity: json['quantity'],
      product: SubCategoriesModel.fromJson(json['product']),
    );
  }
}

class CartModel {
  final int id;
  final int userId;
  final List<CartItem> items;
  final String subtotal;
  final String shippingFee;
  final String tax;
  final String total;

  CartModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.subtotal,
    required this.shippingFee,
    required this.tax,
    required this.total,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      userId: json['userId'],
      items: (json['items'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
      subtotal: json['subtotal'],
      shippingFee: json['shippingFee'],
      tax: json['tax'],
      total: json['total'],
    );
  }

  // Helper method để lấy danh sách products
  List<SubCategoriesModel> get products =>
      items.map((item) => item.product).toList();
}
