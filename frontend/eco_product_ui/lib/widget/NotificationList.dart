// ignore_for_file: deprecated_member_use

import 'package:eco_product_ui_updated/data/DataFile.dart';
import 'package:eco_product_ui_updated/generated/l10n.dart';
import 'package:eco_product_ui_updated/model/ModelNotification.dart';
import 'package:eco_product_ui_updated/utils/ConstantData.dart';
import 'package:eco_product_ui_updated/utils/ConstantWidget.dart';
import 'package:eco_product_ui_updated/utils/SizeConfig.dart';
import 'package:flutter/material.dart';

class NotificationList extends StatefulWidget {
  @override
  _RateProduct createState() => _RateProduct();
}

class _RateProduct extends State<NotificationList> {
  List<ModelNotification> _notificationList = DataFile.getNotificationList();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double totalHeight = SizeConfig.safeBlockHorizontal! * 100;
    double itemHeight = ConstantWidget.getPercentSize(totalHeight, 18);
    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                finish();
              },
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.black87,
            ),
            elevation: 0,
            backgroundColor: ConstantData.bgColor,
            title: ConstantWidget.getAppBarText(S.of(context).notification),
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: ListView.builder(
              primary: true,
              shrinkWrap: true,
              padding: EdgeInsets.all(ConstantWidget.getPercentSize(itemHeight, 7)),
              itemCount: _notificationList.length,
              itemBuilder: (context, index) {
                ModelNotification _notification = _notificationList[index];
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin:
                      EdgeInsets.all(ConstantWidget.getPercentSize(itemHeight, 7)),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      vertical: ConstantWidget.getPercentSize(itemHeight, 2),
                      horizontal: ConstantWidget.getPercentSize(itemHeight, 7)),
                  height: itemHeight,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.safeBlockHorizontal! * 2.5),
                        height: ConstantWidget.getPercentSize(itemHeight, 45),
                        width: ConstantWidget.getPercentSize(itemHeight, 45),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: ConstantData.primaryColor),
                        child: Icon(
                          Icons.notifications_outlined,
                          size: ConstantWidget.getPercentSize(itemHeight, 30),
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstantWidget.getCustomText(
                                _notification.title,
                                Colors.black87,
                                1,
                                TextAlign.start,
                                FontWeight.bold,
                                ConstantWidget.getPercentSize(itemHeight, 18)),
                            ConstantWidget.getSpace(ConstantWidget.getPercentSize(itemHeight, 3)),
                            ConstantWidget.getCustomText(
                                _notification.desc,
                                Colors.grey,
                                2,
                                TextAlign.start,
                                FontWeight.w400,
                                ConstantWidget.getPercentSize(itemHeight, 15))
                          ],
                        ),
                        flex: 1,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        onWillPop: () async {
          finish();
          return false;
        });
  }

  void finish() {
    Navigator.of(context).pop();
  }
}
