// ignore_for_file: deprecated_member_use

import 'package:eco_product_ui_updated/utils/ConstantWidget.dart';
import 'package:flutter/material.dart';
import 'package:eco_product_ui_updated/generated/l10n.dart';
import 'package:eco_product_ui_updated/utils/ConstantData.dart';
import 'package:eco_product_ui_updated/utils/SizeConfig.dart';

class ForgotPasswordPage extends StatefulWidget {
  _ForgotPasswordPage createState() {
    return _ForgotPasswordPage();
  }
}

class _ForgotPasswordPage extends State<ForgotPasswordPage> {
  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(false);
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
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.09,
                bottom: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: ConstantWidget.getCustomText(
                      S.of(context).setYourPassword,
                      ConstantData.textColor,
                      1,
                      TextAlign.start,
                      FontWeight.bold,
                      25),

                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.03,
                  ),

                  child: ConstantWidget.getCustomTextWithAlign(
                      S.of(context).passwordDesc,
                      ConstantData.primaryTextColor,
                      TextAlign.start,
                      FontWeight.w500),

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
                        14),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: TextField(
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
                            child: InkWell(
                              child: Center(


                                child: ConstantWidget.getCustomTextWithoutAlign(
                                    S.of(context).send,
                                    Colors.white,
                                    FontWeight.w900,
                                    ConstantData.font15Px),
                              ),
                            )),
                        onTap: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  ),
                  flex: 1,
                ),
              ],
            ),
          )),
      onWillPop: _requestPop,
    );
  }
}
