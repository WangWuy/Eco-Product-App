class RegisterRequest {
 final String email;
 final String password;
 final String phone;
//  final String address;
 final String gender;
 final String avatar;

 RegisterRequest({
   required this.email,
   required this.password, 
   required this.phone,
  //  required this.address,
   required this.gender,
   required this.avatar,
 });

 Map<String, dynamic> toJson() {
   return {
     'email': email,
     'password': password,
     'phone': phone,
    //  'address': address,
     'gender': gender,
     'avatar': avatar,
   };
 }
}