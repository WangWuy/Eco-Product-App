import 'package:intl/intl.dart';

// Tạo extension method để format tiền VND
extension PriceFormatter on String {
  String toVND() {
    try {
      final price = double.parse(this);
      // Format theo định dạng VND
      final formatted = NumberFormat.currency(
        locale: 'vi_VN', 
        symbol: '₫',
        decimalDigits: 0,
      ).format(price);
      return formatted;
    } catch (e) {
      return this;
    }
  }
}