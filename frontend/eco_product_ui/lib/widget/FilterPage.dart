// ignore_for_file: deprecated_member_use

import 'package:eco_product_ui_updated/utils/ConstantWidget.dart';
import 'package:flutter/material.dart';
import 'package:eco_product_ui_updated/utils/ConstantData.dart';

import 'package:eco_product_ui_updated/utils/SizeConfig.dart';

import 'package:eco_product_ui_updated/data/DataFile.dart';
import 'package:eco_product_ui_updated/generated/l10n.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPage createState() {
    return _FilterPage();
  }
}

class _FilterPage extends State<FilterPage> {
  List<String> materialList = DataFile.getMaterialList();
  List<String> categoryList = DataFile.getFilterList(true);

  bool _isLess = true;

  int materialPosition = 0;
  int _catPosition = 0;

  @override
  void initState() {
    super.initState();
    materialList = DataFile.getMaterialList();
    categoryList = DataFile.getFilterList(_isLess);
    setState(() {});
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  double _lowerValue = 10;
  double _upperValue = 200;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double leftMargin = MediaQuery.of(context).size.width * 0.05;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            //
            elevation: 0,
            backgroundColor: ConstantData.bgColor,

            title: ConstantWidget.getAppBarText(S.of(context).filter),

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
            margin: EdgeInsets.only(
                top: leftMargin, right: leftMargin, left: leftMargin),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: leftMargin),
                        child: ConstantWidget.getCustomText(
                            S.of(context).material,
                            ConstantData.textColor,
                            1,
                            TextAlign.start,
                            FontWeight.w800,
                            ConstantData.font15Px),
                      ),
                      GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: 3,
                        shrinkWrap: true,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 8,
                        children: List.generate(
                          materialList.length,
                          (index) {
                            return
                                // Padding(
                                // padding: EdgeInsets.only(left: 2),
                                // child:
                                InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: (index == materialPosition)
                                      ? ConstantData.primaryColor
                                      : Colors.transparent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(
                                      color: (index == materialPosition)
                                          ? ConstantData.textColor
                                          : ConstantData.disableIconColor,
                                      width: 1),
                                ),
                                child: Center(
                                  child: ConstantWidget.getCustomText(
                                      materialList[index],
                                      (index == materialPosition)
                                          ? ConstantData.whiteColor
                                          : ConstantData.textColor,
                                      1,
                                      TextAlign.start,
                                      FontWeight.w500,
                                      10),
                                ),
                              ),
                              onTap: () {
                                materialPosition = index;
                                setState(() {});
                              },
                            );
                            // );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: leftMargin, bottom: leftMargin),
                        child: ConstantWidget.getCustomText(
                            S.of(context).categories,
                            ConstantData.textColor,
                            1,
                            TextAlign.start,
                            FontWeight.w800,
                            ConstantData.font15Px),
                      ),
                      GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: 3,
                        shrinkWrap: true,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 8,
                        children: List.generate(
                          categoryList.length,
                          (index) {
                            return InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: (index == _catPosition)
                                      ? (index == (categoryList.length - 1))
                                          ? ConstantData.filterColor
                                          : ConstantData.primaryColor
                                      : (index == (categoryList.length - 1))
                                          ? ConstantData.filterColor
                                          : Colors.transparent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(
                                      color: (index == _catPosition)
                                          ? ConstantData.textColor
                                          : ConstantData.disableIconColor,
                                      width: 1),
                                ),
                                child: Center(
                                  child: ConstantWidget.getCustomText(
                                      (index == (categoryList.length - 1))
                                          ? (_isLess)
                                              ? "+" + categoryList[index]
                                              : "-" + categoryList[index]
                                          : categoryList[index],
                                      (index == _catPosition)
                                          ? ConstantData.whiteColor
                                          : ConstantData.textColor,
                                      1,
                                      TextAlign.start,
                                      FontWeight.w500,
                                      10),
                                ),
                              ),
                              onTap: () {
                                print("index----" +
                                    index.toString() +
                                    "---" +
                                    categoryList.length.toString());
                                if (index != (categoryList.length - 1)) {
                                  _catPosition = index;
                                } else {
                                  if (_isLess) {
                                    _isLess = false;
                                  } else {
                                    _isLess = true;
                                  }
                                  categoryList =
                                      DataFile.getFilterList(_isLess);
                                }
                                setState(() {});
                              },
                            );
                            // );
                          },
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                            top: leftMargin, bottom: (leftMargin + leftMargin)),
                        child: ConstantWidget.getCustomText(
                            S.of(context).price,
                            ConstantData.textColor,
                            1,
                            TextAlign.start,
                            FontWeight.w800,
                            ConstantData.font15Px),
                      ),
                      RangeSlider(
                          onChanged: (value) {
                            _lowerValue = value.start;
                            _upperValue = value.end;
                            setState(() {});
                          },
                          max: 300,
                          min: 0,
                          values: RangeValues(_lowerValue, _upperValue))
                      // FlutterSlider(
                      //   handlerHeight: 10,
                      //   values: [_lowerValue, _upperValue],
                      //   rangeSlider: true,
                      //   max: 300,
                      //   min: 0,
                      //   step: FlutterSliderStep(step: 1),
                      //   jump: false,
                      //   trackBar: FlutterSliderTrackBar(
                      //       activeTrackBarHeight: 8,
                      //       activeTrackBar: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(4),
                      //           color: ConstantData.primaryColor),
                      //       inactiveTrackBarHeight: 8,
                      //       inactiveTrackBar: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(4),
                      //           color: ConstantData.viewColor)),
                      //   tooltip: FlutterSliderTooltip(
                      //       disableAnimation: true,
                      //       alwaysShowTooltip: true,
                      //       boxStyle: FlutterSliderTooltipBox(
                      //           decoration:
                      //               BoxDecoration(color: Colors.transparent)),
                      //       textStyle: TextStyle(
                      //           fontFamily: ConstantData.fontFamily,
                      //           fontWeight: FontWeight.w800,
                      //           fontSize: ConstantData.font15Px,
                      //           color: ConstantData.textColor),
                      //       format: (String value) {
                      //         return '\$' + value;
                      //       }),
                      //   handler: FlutterSliderHandler(
                      //     decoration: BoxDecoration(),
                      //     child: Container(
                      //       padding: EdgeInsets.all(10),
                      //     ),
                      //   ),
                      //   rightHandler: FlutterSliderHandler(
                      //     decoration: BoxDecoration(),
                      //     child: Container(
                      //       padding: EdgeInsets.all(10),
                      //     ),
                      //   ),
                      //   disabled: false,
                      //   onDragging: (handlerIndex, lowerValue, upperValue) {
                      //     _lowerValue = lowerValue;
                      //     _upperValue = upperValue;
                      //     setState(() {});
                      //   },
                      // )
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
                              S.of(context).apply,
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
          ),
        ),
        onWillPop: _requestPop);
  }
}
