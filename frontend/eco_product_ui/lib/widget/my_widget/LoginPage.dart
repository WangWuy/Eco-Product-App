// ignore_for_file: deprecated_member_use

import 'package:eco_product_ui_updated/utils/ConstantWidget.dart';
import 'package:flutter/material.dart';
import 'package:eco_product_ui_updated/generated/l10n.dart';
import 'package:eco_product_ui_updated/widget/ForgotPasswordPage.dart';
import 'package:eco_product_ui_updated/utils/ConstantData.dart';
import 'package:eco_product_ui_updated/utils/PrefData.dart';
import 'package:eco_product_ui_updated/utils/SizeConfig.dart';
import 'package:provider/provider.dart';

import 'RegisterPage.dart';
import '../TabWidget.dart';

import '../../../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  _LoginPage createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // Basic email validation pattern
    final emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailPattern.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(false);
  }

  Future<void> _login() async {
      print("Login button pressed"); // Debug print
    if (_formKey.currentState?.validate() ?? false) {
      try {
        print("Form validated"); // Debug print
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final success = await authProvider.login(
          _emailController.text,
          _passwordController.text,
        );
        print("Login result: $success"); // Debug print
        if (success) {
          await PrefData.setIsSignIn(true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => TabWidget(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login failed. Please check your credentials.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Network error. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
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
          body: Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.02,
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          // top: MediaQuery.of(context).size.height * 0.05,
                          bottom: 20),
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
                                  S.of(context).signYouIn,
                                  ConstantData.textColor,
                                  1,
                                  TextAlign.start,
                                  FontWeight.bold,
                                  ConstantWidget.getWidthPercentSize(
                                      context, 6)),
                              ConstantWidget.getCustomText(
                                  S.of(context).SignInMsg,
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
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: ConstantWidget.getCustomText(
                              S.of(context).emailAddress,
                              ConstantData.textColor,
                              1,
                              TextAlign.start,
                              FontWeight.bold,
                              14)),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: TextFormField(
                        controller: _emailController,
                        validator: _validateEmail,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 3, left: 8),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: ConstantData.textColor,
                              width: 0.3,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: ConstantData.textColor,
                              width: 0.3,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 0.3,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 0.3,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: ConstantWidget.getCustomText(
                          S.of(context).password,
                          ConstantData.textColor,
                          1,
                          TextAlign.start,
                          FontWeight.bold,
                          14,
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: TextFormField(
                        controller: _passwordController,
                        validator: _validatePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 3, left: 8),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: ConstantData.textColor,
                              width: 0.3,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: ConstantData.textColor,
                              width: 0.3,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 0.3,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 0.3,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        child: ConstantWidget.getCustomText(
                            S.of(context).forgotPassword,
                            ConstantData.accentColor,
                            1,
                            TextAlign.start,
                            FontWeight.bold,
                            ConstantData.font15Px),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPasswordPage()));
                        },
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          InkWell(
                            child: Container(
                              margin: EdgeInsets.only(top: 40),
                              height: 50,
                              decoration: BoxDecoration(
                                  color: ConstantData.primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: Center(
                                child: Consumer<AuthProvider>(
                                  builder: (context, auth, _) => auth.isLoading
                                      ? CircularProgressIndicator(
                                          color: Colors.white)
                                      : ConstantWidget
                                          .getCustomTextWithoutAlign(
                                              S.of(context).login,
                                              Colors.white,
                                              FontWeight.w900,
                                              ConstantData.font15Px),
                                ),
                              ),
                            ),
                            onTap: () {
                              if (Provider.of<AuthProvider>(context,
                                      listen: false)
                                  .isLoading) {
                                return;
                              }
                              _login();
                            },
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ConstantWidget.getCustomText(
                                    S.of(context).donHaveAnAccount,
                                    ConstantData.primaryTextColor,
                                    1,
                                    TextAlign.start,
                                    FontWeight.bold,
                                    ConstantData.font15Px),
                                InkWell(
                                  child: ConstantWidget.getUnderlineText(
                                      S.of(context).register.toUpperCase(),
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
                                                RegisterPage()));
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      flex: 1,
                    ),
                  ],
                ),
              ))),
      onWillPop: _requestPop,
    );
  }
}
