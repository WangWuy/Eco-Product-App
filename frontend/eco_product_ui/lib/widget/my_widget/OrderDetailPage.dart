// ignore_for_file: deprecated_member_use

import 'package:eco_product_ui_updated/utils/ConstantWidget.dart';
import 'package:flutter/material.dart';
import 'package:eco_product_ui_updated/data/DataFile.dart';
import 'package:eco_product_ui_updated/generated/l10n.dart';
import 'package:eco_product_ui_updated/model/SubCategoryModel.dart';
import 'package:eco_product_ui_updated/utils/ConstantData.dart';
import 'package:eco_product_ui_updated/utils/SizeConfig.dart';

class OrderDetailPage extends StatefulWidget {
  @override
  _OrderDetailPage createState() {
    return _OrderDetailPage();
  }
}

class _OrderDetailPage extends State<OrderDetailPage>
    with SingleTickerProviderStateMixin {
  List<SubCategoryModel> myOrderList = DataFile.getMyOrderList();

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double leftMargin = MediaQuery.of(context).size.width * 0.05;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: ConstantData.bgColor,
            title: ConstantWidget.getAppBarText(S.of(context).orderDetails),
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
            margin: EdgeInsets.only(left: leftMargin, right: leftMargin),
            padding: EdgeInsets.only(top: 15),
            child: ListView(
              children: [
                Row(
                  children: [
                    ConstantWidget.getCustomText(
                        S.of(context).orderId + ": ",
                        ConstantData.textColor1,
                        1,
                        TextAlign.start,
                        FontWeight.w500,
                        14),
                    ConstantWidget.getCustomText("#2CE5DW", Colors.black, 1,
                        TextAlign.start, FontWeight.bold, 14),
                    new Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Icon(
                        Icons.timelapse_outlined,
                        size: 15,
                      ),
                    ),
                    ConstantWidget.getCustomText(
                        "07/01/2021",
                        ConstantData.textColor1,
                        1,
                        TextAlign.start,
                        FontWeight.w500,
                        14),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      ConstantWidget.getCustomText(
                          S.of(context).items + ": ",
                          ConstantData.textColor1,
                          1,
                          TextAlign.start,
                          FontWeight.w500,
                          14),
                      ConstantWidget.getCustomText(
                          myOrderList.length.toString(),
                          ConstantData.accentColor,
                          1,
                          TextAlign.start,
                          FontWeight.bold,
                          14),
                    ],
                  ),
                ),
                onDelivery(),
                Padding(
                  padding: EdgeInsets.only(top: 25, bottom: 5),
                  child: ConstantWidget.getCustomText(S.of(context).description,
                      Colors.black87, 1, TextAlign.start, FontWeight.bold, 16),
                ),
                ConstantWidget.getCustomText(
                    "Rice ,Alo Borta.Bagon Borta.Vegetables,Beef Curry.Dal.",
                    ConstantData.textColor,
                    1,
                    TextAlign.start,
                    FontWeight.w500,
                    14),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 5),
                  child: ConstantWidget.getCustomText(S.of(context).size,
                      Colors.black87, 1, TextAlign.start, FontWeight.bold, 16),
                ),
                ConstantWidget.getCustomText("12", ConstantData.textColor, 1,
                    TextAlign.start, FontWeight.w500, 14),
                Container(
                  height: 0.3,
                  color: ConstantData.subTextColor,
                  margin: EdgeInsets.only(bottom: 15, top: 15),
                ),
                Row(
                  children: [
                    ConstantWidget.getCustomText(
                        S.of(context).totalAmount,
                        ConstantData.accentColor,
                        1,
                        TextAlign.start,
                        FontWeight.bold,
                        16),
                    new Spacer(),
                    ConstantWidget.getCustomText(
                        "\$24.20",
                        ConstantData.accentColor,
                        1,
                        TextAlign.start,
                        FontWeight.bold,
                        16),
                  ],
                ),
              ],
            ),
          ),
        ),
        onWillPop: _requestPop);
  }

  Widget onDelivery() {
    double imageSize = SizeConfig.safeBlockVertical! * 9;
    double smallTextSize = ConstantWidget.getScreenPercentSize(context, 1.6);

    return Container(
        margin: EdgeInsets.only(top: 10),
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: myOrderList.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        height: 0.3,
                        color: ConstantData.subTextColor,
                        margin: EdgeInsets.only(bottom: 15, top: 15),
                      ),
                      Row(
                        children: [
                          Container(
                            height: imageSize,
                            width: imageSize,
                            margin: EdgeInsets.only(right: 15),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: ConstantData.cellColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Image.asset(ConstantData.assetsPath +
                                myOrderList[index].image),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ConstantWidget.getCustomText(
                                        myOrderList[index].name,
                                        ConstantData.textColor1,
                                        1,
                                        TextAlign.start,
                                        FontWeight.w800,
                                        smallTextSize),
                                    new Spacer(),
                                    ConstantWidget.getCustomText(
                                        "Quantity: ",
                                        ConstantData.textColor,
                                        1,
                                        TextAlign.start,
                                        FontWeight.w500,
                                        smallTextSize),
                                    ConstantWidget.getCustomText(
                                        "2",
                                        ConstantData.accentColor,
                                        1,
                                        TextAlign.start,
                                        FontWeight.bold,
                                        smallTextSize),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                  child: ConstantWidget.getCustomText(
                                      myOrderList[index].price,
                                      Colors.black87,
                                      1,
                                      TextAlign.start,
                                      FontWeight.bold,
                                      ConstantWidget.getScreenPercentSize(
                                          context, 2.1)),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.brightness_1,
                                      color: ConstantData.textColor,
                                      size: 10,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: ConstantWidget.getCustomText(
                                          "Delivered at 11:14 am",
                                          ConstantData.textColor,
                                          1,
                                          TextAlign.start,
                                          FontWeight.w500,
                                          ConstantWidget.getScreenPercentSize(
                                              context, 1.8)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            flex: 1,
                          )
                        ],
                      ),

                      //   ],
                      // )
                    ],
                  ),
                ),
                onTap: () {},
              );
            }));
  }
}
