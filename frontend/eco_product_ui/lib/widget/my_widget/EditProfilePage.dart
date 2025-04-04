import 'package:eco_product_ui_updated/my_models/addresses_model.dart';
import 'package:eco_product_ui_updated/services/api_service.dart';
import 'package:eco_product_ui_updated/utils/ConstantWidget.dart';
import 'package:flutter/material.dart';
import 'package:eco_product_ui_updated/utils/ConstantData.dart';
import 'package:eco_product_ui_updated/utils/SizeConfig.dart';

import 'package:eco_product_ui_updated/generated/l10n.dart';

import 'AddNewAddressPage.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePage createState() {
    return _EditProfilePage();
  }
}

class _EditProfilePage extends State<EditProfilePage> {
  final ApiService _apiService = ApiService();
  bool isLoading = true;

  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController mailController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  List<AddressesModel> addressList = [];
  int _selectedPosition = 0;
  String avatar = '';
  int defaultAddressId = 0;
  int selectedAddressId = 0;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    try {
      setState(() => isLoading = true);

      final userDetail = await _apiService.getUserDetail();

      setState(() {
        firstNameController.text = userDetail.firstName;
        lastNameController.text = userDetail.lastName;
        mailController.text = userDetail.email;
        genderController.text = userDetail.gender;
        phoneController.text = userDetail.phone;
        addressList = userDetail.addresses;
        avatar = userDetail.avatar;
        defaultAddressId = userDetail.defaultAddressId;
        selectedAddressId =
            userDetail.defaultAddressId; // Khởi tạo giá trị ban đầu

        _selectedPosition = addressList
            .indexWhere((address) => address.id == selectedAddressId);
        if (_selectedPosition == -1) _selectedPosition = 0;

        isLoading = false;
      });
    } catch (e) {
      print('Error loading user data: $e');
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading user data. Please try again.')),
      );
    }
  }

  void _handleSave() async {
    try {
      setState(() => isLoading = true);
      await _apiService.updateUser(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: mailController.text,
        gender: genderController.text,
        phone: phoneController.text,
        defaultAddressId: selectedAddressId,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  _imgFromGallery() async {}

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: ConstantData.bgColor,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: ConstantData.bgColor,
          title: ConstantWidget.getAppBarText(S.of(context).editProfiles),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: ConstantWidget.getAppBarIcon(),
                onPressed: _requestPop,
              );
            },
          ),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    SizeConfig().init(context);
    double leftMargin = MediaQuery.of(context).size.width * 0.05;
    double editTextHeight = MediaQuery.of(context).size.height * 0.06;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: ConstantData.bgColor,
            title: ConstantWidget.getAppBarText(S.of(context).editProfiles),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: ConstantWidget.getAppBarIcon(),
                  onPressed: _requestPop,
                );
              },
            ),
          ),
          body: Container(
            padding: EdgeInsets.only(left: leftMargin, right: leftMargin),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                          height: 150.0,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                    image: new DecorationImage(
                                      image: avatar.isNotEmpty
                                          ? NetworkImage(avatar)
                                          : AssetImage("assets/images/hugh.png")
                                              as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                    right: 20,
                                    bottom: 25,
                                    child: InkWell(
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: ConstantData.primaryColor,
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.photo_camera_back,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: _imgFromGallery,
                                    ))
                              ],
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: ConstantWidget.getCustomTextWithoutAlign(
                              S.of(context).userInformation,
                              ConstantData.textColor,
                              FontWeight.bold,
                              16),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 10, top: 10),
                                  height: editTextHeight,
                                  child: TextField(
                                    maxLines: 1,
                                    controller: firstNameController,
                                    style: TextStyle(
                                        fontFamily: ConstantData.fontFamily,
                                        color: ConstantData.primaryTextColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: S.of(context).firstName,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom: 10, left: 8, top: 10),
                                  height: editTextHeight,
                                  child: TextField(
                                    controller: lastNameController,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontFamily: ConstantData.fontFamily,
                                        color: ConstantData.primaryTextColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: S.of(context).lastName,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            flex: 1,
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10, top: 10),
                        height: editTextHeight,
                        child: TextField(
                          maxLines: 1,
                          controller: mailController,
                          style: TextStyle(
                              fontFamily: ConstantData.fontFamily,
                              color: ConstantData.primaryTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: S.of(context).emailAddressHint,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 10, top: 10),
                                  height: editTextHeight,
                                  child: TextField(
                                    maxLines: 1,
                                    controller: genderController,
                                    style: TextStyle(
                                        fontFamily: ConstantData.fontFamily,
                                        color: ConstantData.primaryTextColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: S.of(context).gender,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    bottom: 10,
                                    left: 8,
                                    top: 10,
                                  ),
                                  height: editTextHeight,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    controller: phoneController,
                                    style: TextStyle(
                                        fontFamily: ConstantData.fontFamily,
                                        color: ConstantData.primaryTextColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: S.of(context).phone,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            flex: 1,
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            getTextWidget(S.of(context).addressTitle),
                            new Spacer(),
                            InkWell(
                              child: ConstantWidget
                                  .getUnderLineCustomTextWithoutAlign(
                                      S.of(context).newAddress,
                                      ConstantData.textColor1,
                                      FontWeight.w600,
                                      ConstantData.font12Px),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddNewAddressPage(
                                              onAddressCreated: () {
                                                loadUserData(); // Load lại data khi address được tạo
                                              },
                                            )));
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.width * 0.01,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: addressList.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final address = addressList[index];
                            return AddressListItem(
                              address: address,
                              isSelected: address.id == selectedAddressId,
                              onTap: () {
                                setState(() {
                                  _selectedPosition = index;
                                  selectedAddressId = address.id;
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  flex: 1,
                ),
                InkWell(
                  onTap: () async {
                    // Call API to update user profile
                    _handleSave();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10, bottom: leftMargin),
                    height: 50,
                    decoration: BoxDecoration(
                        color: ConstantData.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: ConstantWidget.getCustomTextWithoutAlign(
                          S.of(context).save,
                          Colors.white,
                          FontWeight.w900,
                          ConstantData.font15Px),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        onWillPop: _requestPop);
  }

  static getTextWidget(String s) {
    return ConstantWidget.getCustomText(s, ConstantData.textColor, 1,
        TextAlign.start, FontWeight.bold, ConstantData.font12Px);
  }
}

class AddressListItem extends StatelessWidget {
  final AddressesModel address;
  final bool isSelected;
  final VoidCallback onTap;

  const AddressListItem({
    required this.address,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: SizeConfig.safeBlockVertical! * 8,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                address.fullName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: ConstantData.font15Px,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                address.address + ", " + address.city,
                                style: TextStyle(
                                  color: ConstantData.primaryTextColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: ConstantData.font12Px,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            isSelected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            color: isSelected
                                ? ConstantData.textColor
                                : ConstantData.disableIconColor,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: ConstantData.viewColor,
          ),
        ],
      ),
    );
  }
}
