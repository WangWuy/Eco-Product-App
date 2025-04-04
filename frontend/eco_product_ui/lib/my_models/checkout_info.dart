import 'package:eco_product_ui_updated/my_models/addresses_model.dart';
import 'package:eco_product_ui_updated/my_models/cards_model.dart';
import 'package:eco_product_ui_updated/my_models/cart_model.dart';

class CheckoutInfo {
  final AddressesModel address;
  final CardsModel? payment;
  final String? voucherCode;
  final String subtotal;
  final String shippingFee;
  final String tax;
  final String total;
  final List<CartItem> items;

  CheckoutInfo({
    required this.address,
    this.payment,
    this.voucherCode,
    required this.subtotal,
    required this.shippingFee,
    required this.tax,
    required this.total,
    required this.items,
  });
}
