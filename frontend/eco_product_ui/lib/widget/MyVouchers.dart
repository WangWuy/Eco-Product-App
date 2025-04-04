// ignore_for_file: deprecated_member_use

import 'package:eco_product_ui_updated/utils/ConstantWidget.dart';
import 'package:flutter/material.dart';
import 'package:eco_product_ui_updated/data/DataFile.dart';
import 'package:eco_product_ui_updated/generated/l10n.dart';
import 'package:eco_product_ui_updated/model/VouchersModel.dart';
import 'package:eco_product_ui_updated/utils/ConstantData.dart';
import 'package:eco_product_ui_updated/utils/SizeConfig.dart';

class MyVouchers extends StatefulWidget {
  final bool isCopy;

  MyVouchers(this.isCopy);

  @override
  _MyVouchers createState() {
    return _MyVouchers();
  }
}

class _MyVouchers extends State<MyVouchers> {
  List<VouchersModel> voucherList = DataFile.getVouchersList();

  @override
  void initState() {
    super.initState();
    voucherList = DataFile.getVouchersList();
    setState(() {});
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    double imageSize = SizeConfig.safeBlockVertical! * 6.5;

    SizeConfig().init(context);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: ConstantData.bgColor,

            title: ConstantWidget.getAppBarText(S.of(context).myVouchers),
            // title: ConstantWidget.getCustomTextWithoutAlign(S.of(context).myVouchers,ConstantData.textColor, FontWeight.bold, ConstantData.font18Px),

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
            child: Container(
              margin: EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 15,
                  bottom: MediaQuery.of(context).size.width * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10, bottom: 20),
                    height: imageSize,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 2,
                              spreadRadius: 1,
                              offset: Offset(0, 1))
                        ]),
                    child: TextField(
                      maxLines: 1,
                      style: TextStyle(
                          fontFamily: ConstantData.fontFamily,
                          color: ConstantData.primaryTextColor,
                          fontWeight: FontWeight.w400,
                          fontSize: ConstantData.font12Px),
                      decoration: InputDecoration(
                        hintText: S.of(context).searchHint,
                        hintStyle: TextStyle(
                            fontFamily: ConstantData.fontFamily,
                            color: ConstantData.primaryTextColor,
                            fontWeight: FontWeight.w400,
                            fontSize: ConstantData.font12Px),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 3, left: 8),
                      ),
                    ),
                  ),
                  Text(
                    S.of(context).myVouchers,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontFamily: ConstantData.fontFamily,
                        fontWeight: FontWeight.w800,
                        fontSize: ConstantData.font15Px,
                        color: ConstantData.textColor),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: voucherList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: ConstantData.whiteColor,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  blurRadius: 10,
                                )
                              ]),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Image.asset(
                                  ConstantData.assetsPath +
                                      voucherList[index].image,
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ConstantWidget.getCustomTextWithoutAlign(
                                        voucherList[index].name,
                                        Colors.black87,
                                        FontWeight.w700,
                                        14),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 5, bottom: 20),
                                      child: ConstantWidget
                                          .getCustomTextWithoutAlign(
                                              voucherList[index].desc,
                                              ConstantData.primaryTextColor,
                                              FontWeight.w500,
                                              ConstantData.font12Px),
                                    ),
                                    InkWell(
                                      child: Container(
                                        height: 40,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          color: ConstantData.primaryColor,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Center(
                                          child: ConstantWidget
                                              .getCustomTextWithoutAlign(
                                                  voucherList[index].code,
                                                  Colors.white,
                                                  FontWeight.w500,
                                                  14),
                                        ),
                                      ),
                                      onTap: () {
                                        if (widget.isCopy) {
                                          Navigator.pop(context);
                                        }
                                      },
                                    )
                                  ],
                                ),
                                flex: 1,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ConstantWidget.getCustomTextWithoutAlign(
                                        S.of(context).exp,
                                        ConstantData.primaryTextColor,
                                        FontWeight.w500,
                                        10),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: ConstantWidget
                                          .getCustomTextWithoutAlign(
                                              voucherList[index].date,
                                              ConstantData.textColor,
                                              FontWeight.w700,
                                              ConstantData.font12Px),
                                    ),
                                    ConstantWidget.getCustomTextWithoutAlign(
                                        voucherList[index].month,
                                        ConstantData.primaryTextColor,
                                        FontWeight.w500,
                                        10),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
        ),
        onWillPop: _requestPop);
  }
}
