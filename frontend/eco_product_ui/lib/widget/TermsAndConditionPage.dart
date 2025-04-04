// ignore_for_file: deprecated_member_use

import 'package:eco_product_ui_updated/utils/ConstantWidget.dart';
import 'package:flutter/material.dart';
import 'package:eco_product_ui_updated/generated/l10n.dart';
import 'package:eco_product_ui_updated/utils/ConstantData.dart';
import 'package:eco_product_ui_updated/utils/SizeConfig.dart';

class TermsAndConditionPage extends StatefulWidget {
  @override
  _TermsAndConditionPage createState() {
    return _TermsAndConditionPage();
  }
}

class _TermsAndConditionPage extends State<TermsAndConditionPage> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ConstantData.bgColor,
            title:
                ConstantWidget.getAppBarText(S.of(context).termsAndCondition),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: ConstantWidget.getAppBarIcon(),
                  onPressed: _requestPop,
                );
              },
            ),
          ),
          body: SingleChildScrollView(
              child: Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: ConstantWidget.getCustomTextWithoutAlign(
                S.of(context).loremText,
                ConstantData.textColor,
                FontWeight.w900,
                ConstantData.font12Px),
          )),
        ),
        onWillPop: _requestPop);
  }
}
