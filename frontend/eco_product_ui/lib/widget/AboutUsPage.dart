// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../utils/ConstantData.dart';
import '../utils/ConstantWidget.dart';
import '../utils/SizeConfig.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPage createState() {
    return _AboutUsPage();
  }
}

class _AboutUsPage extends State<AboutUsPage> {
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
            title: ConstantWidget.getAppBarText(S.of(context).aboutUs),
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
                FontWeight.w500,
                ConstantData.font12Px),
          )),
        ),
        onWillPop: _requestPop);
  }
}
