import 'package:country_code_picker/country_code_picker.dart';
import 'package:eco_product_ui_updated/my_models/register.dart';
import 'package:eco_product_ui_updated/services/api_service.dart';
import 'package:eco_product_ui_updated/utils/ConstantWidget.dart';
import 'package:flutter/material.dart';
import 'package:eco_product_ui_updated/utils/ConstantData.dart';
import 'package:eco_product_ui_updated/utils/SizeConfig.dart';
import 'package:eco_product_ui_updated/widget/TermsAndConditionPage.dart';
import 'package:flutter/services.dart';

import 'LoginPage.dart';
import 'package:eco_product_ui_updated/generated/l10n.dart';

import '../WidgetMobileVerification.dart';

class RegisterPage extends StatefulWidget {
  _RegisterPage createState() {
    return _RegisterPage();
  }
}

class _RegisterPage extends State<RegisterPage> {
  String countryCode = "IN";
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final ApiService _apiService = ApiService();
  bool isLoading = false;

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(false);
  }

  Future<void> _handleRegister() async {
    try {
      setState(() => isLoading = true);

      final request = RegisterRequest(
        email: _emailController.text,
        password: _passwordController.text,
        phone: "$countryCode${_phoneController.text}",
        gender: "male",
        avatar: "",
      );

      print('Request data: ${request.toJson()}');

      await _apiService.register(request);

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => WidgetMobileVerification()));
    } catch (e) {
      print('Registration error: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: ConstantData.bgColor,
            title: Text(""),
            leading: Builder(
              builder: (BuildContext context) {
                return Icon(
                  Icons.keyboard_backspace,
                  color: Colors.transparent,
                );
              },
            ),
          ),
          body: Container(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              child: Image.asset(
                                ConstantData.assetsPath + "logo.png",
                                height: 80,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ConstantWidget.getCustomText(
                                    S.of(context).createNew,
                                    ConstantData.textColor,
                                    1,
                                    TextAlign.start,
                                    FontWeight.bold,
                                    ConstantWidget.getWidthPercentSize(
                                        context, 6)),
                                ConstantWidget.getCustomText(
                                    S.of(context).SignUpMsg,
                                    ConstantData.primaryTextColor,
                                    1,
                                    TextAlign.start,
                                    FontWeight.w500,
                                    ConstantWidget.getWidthPercentSize(
                                        context, 2.5))
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: getTextWidget(S.of(context).emailAddress),
                          )),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        height:
                            ConstantWidget.getScreenPercentSize(context, 8.5),
                        child: TextField(
                          controller: _emailController,
                          maxLines: 1,
                          style: TextStyle(
                              fontFamily: ConstantData.fontFamily,
                              color: ConstantData.primaryTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 3, left: 8),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ConstantData.textColor, width: 0.3),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(8),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ConstantData.textColor, width: 0.3),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(15),
                                ),
                              ),
                              hintStyle: TextStyle(
                                  fontFamily: ConstantData.fontFamily,
                                  color: ConstantData.textColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16)),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: getTextWidget(S.of(context).password),
                          )),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        height:
                            ConstantWidget.getScreenPercentSize(context, 8.5),
                        child: TextField(
                          controller: _passwordController,
                          maxLines: 1,
                          style: TextStyle(
                              fontFamily: ConstantData.fontFamily,
                              color: ConstantData.primaryTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                          obscureText: true,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 3, left: 8),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ConstantData.textColor, width: 0.3),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(8),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ConstantData.textColor, width: 0.3),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(15),
                                ),
                              ),
                              hintStyle: TextStyle(
                                  fontFamily: ConstantData.fontFamily,
                                  color: ConstantData.textColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16)),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: getTextWidget(S.of(context).mobileNumber),
                          )),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              height: ConstantWidget.getScreenPercentSize(
                                  context, 8.5),
                              margin:
                                  EdgeInsets.only(top: 7, bottom: 7, right: 7),
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(
                                      color: ConstantData.textColor,
                                      width: 0.3),
                                  color: ConstantData.bgColor),
                              child: CountryCodePicker(
                                onChanged: (value) {
                                  countryCode = value.dialCode!;
                                  print("changeval===$countryCode");
                                },
                                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                initialSelection: 'IN',
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontFamily: ConstantData.fontFamily),
                                // favorite: ['+39', 'FR'],
                                // countryFilter: ['IT', 'FR'],
                                showFlagDialog: true,
                                comparator: (a, b) =>
                                    b.name!.compareTo(a.name!),
                                //Get the country information relevant to the initial selection
                                onInit: (code) {
                                  countryCode = code!.dialCode!;
                                },
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: ConstantWidget.getScreenPercentSize(
                                    context, 8.5),
                                padding: EdgeInsets.symmetric(horizontal: 7),
                                margin:
                                    EdgeInsets.only(top: 7, bottom: 7, left: 7),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                child: TextField(
                                  controller: _phoneController,
                                  onChanged: (value) async {
                                    try {} catch (e) {
                                      print("resge$e");
                                    }
                                  },
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(top: 3, left: 8),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ConstantData.textColor,
                                            width: 0.3),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(8),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ConstantData.textColor,
                                            width: 0.3),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(15),
                                        ),
                                      ),
                                      hintStyle: TextStyle(
                                          fontFamily: ConstantData.fontFamily,
                                          color: ConstantData.textColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16)),
                                  style: TextStyle(
                                      fontFamily: ConstantData.fontFamily,
                                      color: ConstantData.textColor1,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ], // Only numbers can be entered
                                ),
                              ),
                              flex: 1,
                            )
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: getTextWidget(S.of(context).address),
                          )),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        height:
                            ConstantWidget.getScreenPercentSize(context, 8.5),
                        child: TextField(
                          controller: _addressController,
                          maxLines: 1,
                          style: TextStyle(
                              fontFamily: ConstantData.fontFamily,
                              color: ConstantData.primaryTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                          obscureText: false,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 3, left: 8),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ConstantData.textColor, width: 0.3),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(8),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ConstantData.textColor, width: 0.3),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(15),
                                ),
                              ),
                              hintStyle: TextStyle(
                                  fontFamily: ConstantData.fontFamily,
                                  color: ConstantData.textColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16)),
                        ),
                      ),
                      Row(
                        children: [
                          ImageIcon(
                            AssetImage('assets/images/checkmark.png'),
                            size: 15,
                            color: ConstantData.textColor,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),

                            //

                            child: ConstantWidget.getCustomText(
                                S.of(context).iHaveAccept,
                                ConstantData.primaryTextColor,
                                1,
                                TextAlign.start,
                                FontWeight.bold,
                                ConstantData.font15Px),
                          ),
                          InkWell(
                            child: ConstantWidget.getUnderlineText(
                                S.of(context).termsAndCondition,
                                ConstantData.accentColor,
                                1,
                                TextAlign.start,
                                FontWeight.bold,
                                ConstantData.font15Px),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TermsAndConditionPage()));
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 50,
                          decoration: BoxDecoration(
                              color: ConstantData.primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Center(
                            child: isLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : ConstantWidget.getCustomTextWithoutAlign(
                                    S.of(context).register,
                                    Colors.white,
                                    FontWeight.w900,
                                    ConstantData.font15Px),
                          ),
                        ),
                        onTap: isLoading ? null : _handleRegister,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ConstantWidget.getCustomText(
                          S.of(context).haveAnAccount,
                          ConstantData.primaryTextColor,
                          1,
                          TextAlign.start,
                          FontWeight.bold,
                          ConstantData.font15Px),
                      InkWell(
                        child: ConstantWidget.getUnderlineText(
                            S.of(context).login.toUpperCase(),
                            ConstantData.accentColor,
                            1,
                            TextAlign.start,
                            FontWeight.bold,
                            ConstantData.font15Px),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
      onWillPop: _requestPop,
    );
  }

  Widget getTextWidget(String s) {
    return ConstantWidget.getCustomText(
        s, ConstantData.textColor, 1, TextAlign.start, FontWeight.bold, 14);
  }
}
