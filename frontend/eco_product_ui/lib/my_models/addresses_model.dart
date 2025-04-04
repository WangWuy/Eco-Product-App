
class AddressesModel {
  late int id;
  late String fullName;
  late String phoneNumber;
  late String city;
  late String address;
  late String zipCode;
  late bool isDefault;

  AddressesModel();

  AddressesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    fullName = json['fullName'] ?? '';
    phoneNumber = json['phoneNumber'] ?? '';
    city = json['city'] ?? '';
    address = json['address'] ?? '';
    zipCode = json['zipCode'] ?? '';
    isDefault = json['isDefault'] ?? false;
  }
}