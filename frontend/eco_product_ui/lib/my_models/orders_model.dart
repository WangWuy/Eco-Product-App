import 'package:eco_product_ui_updated/my_models/sub_category_model.dart';

class OrdersModel {
  final int id;
  final String status;
  final double subtotal;
  final double shippingFee;
  final double tax;
  final double discount;
  final double totalAmount;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<OrderItemModel> items;

  OrdersModel({
    required this.id,
    required this.status,
    required this.subtotal,
    required this.shippingFee,
    required this.tax,
    required this.discount,
    required this.totalAmount,
    this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      id: json['id'] ?? 0,
      status: json['status'] ?? '',
      subtotal: double.parse(json['subtotal']?.toString() ?? '0'),
      shippingFee: double.parse(json['shippingFee']?.toString() ?? '0'),
      tax: double.parse(json['tax']?.toString() ?? '0'),
      discount: double.parse(json['discount']?.toString() ?? '0'),
      totalAmount: double.parse(json['totalAmount']?.toString() ?? '0'),
      note: json['note'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      items: (json['items'] as List?)
              ?.map((item) => OrderItemModel.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class OrderItemModel {
  final int id;
  final int productId;
  final int quantity;
  final double price;
  final SubCategoriesModel? product;

  OrderItemModel({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.price,
    this.product,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] ?? 0,
      productId: json['productId'] ?? 0,
      quantity: json['quantity'] ?? 0,
      price: double.parse(json['price']?.toString() ?? '0'),
      product: json['product'] != null
          ? SubCategoriesModel.fromJson(json['product'])
          : null,
    );
  }
}
