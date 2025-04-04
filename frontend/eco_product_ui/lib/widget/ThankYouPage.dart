// ignore_for_file: deprecated_member_use

import 'package:eco_product_ui_updated/utils/ConstantWidget.dart';
import 'package:eco_product_ui_updated/widget/TabWidget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:eco_product_ui_updated/model/AddressModel.dart';
import 'package:eco_product_ui_updated/model/CardModel.dart';
import 'package:eco_product_ui_updated/utils/ConstantData.dart';
import 'package:eco_product_ui_updated/utils/SizeConfig.dart';

import 'package:eco_product_ui_updated/data/DataFile.dart';
import 'package:eco_product_ui_updated/generated/l10n.dart';
import 'package:eco_product_ui_updated/widget/my_widget/MyOrderPage.dart';

class ThankYouPage extends StatefulWidget {
  @override
  _ThankYouPage createState() {
    return _ThankYouPage();
  }
}

class _ThankYouPage extends State<ThankYouPage> {
  AddressModel addressList = DataFile.getAddressList()[0];
  CardModel cardList = DataFile.getCardList()[0];

  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    cardList = DataFile.getCardList()[0];
    addressList = DataFile.getAddressList()[0];
    setState(() {});
  }

  Future<bool> _requestPop() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TabWidget()));

    return new Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double leftMargin = MediaQuery.of(context).size.width * 0.05;
    double size = SizeConfig.safeBlockVertical! * 30;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: ConstantData.bgColor,
            title: Text(""),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: ConstantData.iconColor,
                ),
                onPressed: () {
                  _requestPop();
                },
              )
            ],
          ),
          body: Container(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/image.png', height: size),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 5),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: new TextSpan(
                            style: new TextStyle(
                              // fontWeight: FontWeight.w600,
                              fontSize: ConstantData.font12Px,
                              fontFamily: ConstantData.fontFamily,
                              color: ConstantData.primaryTextColor,
                            ),
                            children: <TextSpan>[
                              new TextSpan(text: 'Your order'),
                              new TextSpan(
                                  text: ' #345678 ',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: ConstantData.textColor)),
                              new TextSpan(text: 'is Completed.'),
                            ],
                          ),
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: new TextSpan(
                          style: new TextStyle(
                            fontSize: ConstantData.font12Px,
                            fontFamily: ConstantData.fontFamily,
                            color: ConstantData.primaryTextColor,
                          ),
                          children: <TextSpan>[
                            new TextSpan(
                                text: 'Please check the Delivery status at'),
                            new TextSpan(
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MyOrderPage(),
                                        ));
                                  },
                                text: '\nOrder Tracking ',
                                style: new TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: ConstantData.textColor)),
                            new TextSpan(text: ' pages.'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  flex: 1,
                ),
                InkWell(
                  child: Container(
                      margin: EdgeInsets.all(leftMargin),
                      height: 50,
                      decoration: BoxDecoration(
                          color: ConstantData.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: InkWell(
                        child: Center(
                          child: ConstantWidget.getCustomTextWithoutAlign(
                              S.of(context).continueShopping,
                              Colors.white,
                              FontWeight.w900,
                              ConstantData.font15Px),
                        ),
                      )),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TabWidget()));
                  },
                ),
              ],
            ),
          ),
        ),
        onWillPop: _requestPop);
  }
}
