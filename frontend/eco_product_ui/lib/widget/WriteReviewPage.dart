// ignore_for_file: deprecated_member_use

import 'package:eco_product_ui_updated/utils/ConstantWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:eco_product_ui_updated/generated/l10n.dart';
import 'package:eco_product_ui_updated/utils/ConstantData.dart';
import 'package:eco_product_ui_updated/utils/SizeConfig.dart';

class WriteReviewPage extends StatefulWidget {
  @override
  _WriteReviewPage createState() {
    return _WriteReviewPage();
  }
}

class _WriteReviewPage extends State<WriteReviewPage> {
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
            centerTitle: true,
            backgroundColor: ConstantData.bgColor,

            // title: ConstantWidget.getCustomTextWithoutAlign(S.of(context).writeReviewPage, ConstantData.textColor, FontWeight.bold, ConstantData.font18Px),
            title: ConstantWidget.getAppBarText(S.of(context).writeReviewPage),
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
              child: ListView(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/rate.png',
                      height: SizeConfig.safeBlockVertical! * 25,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: Align(
                      alignment: Alignment.center,
                      child: RatingBar.builder(
                        itemSize: 25,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        tapOnlyMode: true,
                        updateOnDrag: true,
                        itemPadding: EdgeInsets.symmetric(horizontal: 20),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 10,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: new BoxDecoration(
                        color: ConstantData.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(1, 1),
                            blurRadius: 1,
                          )
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: ConstantWidget.getCustomText(
                                  S.of(context).yourName,
                                  ConstantData.textColor,
                                  1,
                                  TextAlign.start,
                                  FontWeight.bold,
                                  ConstantData.font12Px),
                            )
                            // child: Text(
                            //   S.of(context).yourName,
                            //   textAlign: TextAlign.start,
                            //   style: TextStyle(
                            //       fontFamily: ConstantData.fontFamily,
                            //       fontWeight: FontWeight.bold,
                            //       fontSize: ConstantData.font12Px,
                            //       color: ConstantData.textColor),
                            // )),
                            ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: TextField(
                            maxLines: 1,
                            style: TextStyle(
                                fontFamily: ConstantData.fontFamily,
                                color: ConstantData.primaryTextColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 3, left: 8),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: ConstantData.textColor),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: ConstantData.disableIconColor),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: ConstantWidget.getCustomText(
                                  S.of(context).writeYourReview,
                                  ConstantData.textColor,
                                  1,
                                  TextAlign.start,
                                  FontWeight.bold,
                                  ConstantData.font12Px),
                            )),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: TextField(
                            maxLines: 1,
                            style: TextStyle(
                                fontFamily: ConstantData.fontFamily,
                                color: ConstantData.primaryTextColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 3, left: 8),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: ConstantData.textColor),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: ConstantData.disableIconColor),
                              ),
                            ),
                          ),
                        ),
                        ConstantWidget.getCustomText(
                            S.of(context).minimumCharacter,
                            ConstantData.textColor,
                            1,
                            TextAlign.start,
                            FontWeight.w500,
                            10)
                      ],
                    ),
                  ),
                  InkWell(
                    child: Container(
                        margin: EdgeInsets.only(top: 20),
                        height: 50,
                        decoration: BoxDecoration(
                            color: ConstantData.primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: InkWell(
                          child: Center(
                            child: ConstantWidget.getCustomTextWithoutAlign(
                                S.of(context).submit,
                                Colors.white,
                                FontWeight.w900,
                                ConstantData.font15Px),
                          ),
                        )),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: _requestPop);
  }
}
