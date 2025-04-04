import 'package:eco_product_ui_updated/my_models/addresses_model.dart';

class UserModel {
  late int id;
  late String firstName;
  late String lastName;
  late String email;
  late String gender;
  late String phone;
  late String avatar;
  List<AddressesModel> addresses = [];
  late int defaultAddressId;

  UserModel();

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    firstName = json['firstName'] ?? '';
    lastName = json['lastName'] ?? '';
    email = json['email'] ?? '';
    gender = json['gender'] ?? '';
    phone = json['phone'] ?? '';
    avatar = json['avatar'] ?? '';
    defaultAddressId = json['defaultAddressId'] ?? 0;
    
    if (json['addresses'] != null) {
      addresses = (json['addresses'] as List)
          .map((address) => AddressesModel.fromJson(address))
          .toList();
    }
  }
}