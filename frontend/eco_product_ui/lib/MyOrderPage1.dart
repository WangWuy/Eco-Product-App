// ignore_for_file: deprecated_member_use

import 'package:eco_product_ui_updated/utils/ConstantWidget.dart';
import 'package:flutter/material.dart';
import 'package:eco_product_ui_updated/data/DataFile.dart';
import 'package:eco_product_ui_updated/generated/l10n.dart';
import 'package:eco_product_ui_updated/model/SubCategoryModel.dart';
import 'package:eco_product_ui_updated/utils/ConstantData.dart';
import 'package:eco_product_ui_updated/utils/SizeConfig.dart';

class MyOrderPage1 extends StatefulWidget {
  @override
  _MyOrderPage1 createState() {
    return _MyOrderPage1();
  }
}

class _MyOrderPage1 extends State<MyOrderPage1> {
  List<SubCategoryModel> orderList = DataFile.getMyOrderList();

  @override
  void initState() {
    super.initState();
    orderList = DataFile.getMyOrderList();
    setState(() {});
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    double imageSize = SizeConfig.safeBlockVertical! * 10;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: ConstantData.bgColor,

            title: ConstantWidget.getAppBarText(S.of(context).myOrderHistory),
            // title: ConstantWidget.getCustomTextWithoutAlign(S.of(context).myOrderHistory,ConstantData.textColor, FontWeight.bold, ConstantData.font18Px),

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
            margin: EdgeInsets.only(
                left: 15,
                right: 15,
                top: 15,
                bottom: MediaQuery.of(context).size.width * 0.01),
            // child: Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: orderList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 15),
                      margin: EdgeInsets.only(bottom: 15),

                      decoration: BoxDecoration(
                          color: (index % 2 == 0)
                              ? ConstantData.primaryColor
                              : ConstantData.accentColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              width: 0.3, color: Colors.grey.shade400)),
                      child: Container(
                        color: Colors.white,
                        // children: [
                        child: Row(
                          children: [
                            Container(
                              height: imageSize,
                              width: imageSize,
                              margin: EdgeInsets.only(
                                  left: 15, right: 15, bottom: 15, top: 15),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: ConstantData.cellColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: Image.asset(ConstantData.assetsPath +
                                  orderList[index].image),
                            ),
                            // Expanded(
                            //   child: Column(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     crossAxisAlignment:
                            //     CrossAxisAlignment.start,
                            //     children: [
                            //       Text(
                            //         orderList[index].name,
                            //         style: TextStyle(
                            //           fontWeight: FontWeight.w700,
                            //           fontSize: ConstantData.font12Px,
                            //           fontFamily: ConstantData.fontFamily,
                            //           color: ConstantData.textColor,
                            //         ),
                            //       ),
                            //       Padding(
                            //         padding:
                            //         EdgeInsets.only(top: 2, bottom: 10),
                            //         child: Text(orderList[index].desc,
                            //             textAlign: TextAlign.start,
                            //             style: TextStyle(
                            //                 fontWeight: FontWeight.w400,
                            //                 fontSize: 10,
                            //                 fontFamily: ConstantData.fontFamily,
                            //                 color: ConstantData.textColor,
                            //                 decoration:
                            //                 TextDecoration.none)),
                            //       ),
                            //       Row(
                            //         mainAxisAlignment:
                            //         MainAxisAlignment.start,
                            //         crossAxisAlignment:
                            //         CrossAxisAlignment.center,
                            //         children: [
                            //           Text(
                            //             orderList[index].price,
                            //             style: TextStyle(
                            //               fontWeight: FontWeight.w700,
                            //               fontSize: ConstantData.font12Px,
                            //               fontFamily: ConstantData.fontFamily,
                            //               color: ConstantData.textColor,
                            //             ),
                            //           ),
                            //           new Spacer(),
                            //           Padding(
                            //             padding: EdgeInsets.only(right: 10),
                            //             child: ImageIcon(
                            //               AssetImage(
                            //                   'assets/images/pencil.png'),
                            //               size: 15,
                            //               color: ConstantData.textColor,
                            //             ),
                            //           ),
                            //           Padding(
                            //             padding: EdgeInsets.only(right: 10),
                            //             child: ImageIcon(
                            //               AssetImage(
                            //                   'assets/images/back-arrow.png'),
                            //               size: 15,
                            //               color: ConstantData.textColor,
                            //             ),
                            //           ),
                            //         ],
                            //       )
                            //     ],
                            //   ),
                            //   flex: 1,
                            // )

                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    orderList[index].name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: ConstantData.fontFamily,
                                        fontWeight: FontWeight.w800,
                                        fontSize: ConstantData.font18Px,
                                        color: ConstantData.textColor),
                                  ),

                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 5, bottom: 15),
                                    child: Text(
                                      orderList[index].desc,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: ConstantData.fontFamily,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: ConstantData.textColor,
                                      ),
                                    ),
                                  ),

                                  Text(
                                    orderList[index].price,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontFamily: ConstantData.fontFamily,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: ConstantData.accentColor,
                                    ),
                                  ),

                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.start,
                                  //   crossAxisAlignment:
                                  //       CrossAxisAlignment.center,
                                  //   children: [
                                  //     Text(
                                  //       orderList[index].price,
                                  //       style: TextStyle(
                                  //         fontWeight: FontWeight.w700,
                                  //         fontSize: ConstantData.font12Px,
                                  //         fontFamily: ConstantData.fontFamily,
                                  //         color: ConstantData.textColor,
                                  //       ),
                                  //     ),
                                  //     new Spacer(),
                                  //     Padding(
                                  //       padding: EdgeInsets.only(right: 10),
                                  //       child: ImageIcon(
                                  //         AssetImage(
                                  //             'assets/images/pencil.png'),
                                  //         size: 15,
                                  //         color: ConstantData.textColor,
                                  //       ),
                                  //     ),
                                  //     Padding(
                                  //       padding: EdgeInsets.only(right: 10),
                                  //       child: ImageIcon(
                                  //         AssetImage(
                                  //             'assets/images/back-arrow.png'),
                                  //         size: 15,
                                  //         color: ConstantData.textColor,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // )
                                ],
                              ),
                              flex: 1,
                            )
                          ],
                        ),
                        // Container(
                        //   margin: EdgeInsets.only(
                        //       left: 10, right: 10, top: 10, bottom: 10),
                        //   width: double.infinity,
                        //   height: 1,
                        //   color: ConstantData.viewColor,
                        // )
                        // ],
                      ),

                      // child: Column(
                      //   children: [
                      //     Row(
                      //       children: [
                      //         Container(
                      //           height: imageSize,
                      //           width: imageSize,
                      //           margin: EdgeInsets.all(10),
                      //           decoration: BoxDecoration(
                      //             shape: BoxShape.rectangle,
                      //             color: Colors.transparent,
                      //             image: DecorationImage(
                      //               image: ExactAssetImage(
                      //                ConstantData.assetsPath+   orderList[index].image),
                      //               fit: BoxFit.cover,
                      //             ),
                      //             borderRadius: BorderRadius.all(
                      //               Radius.circular(5),
                      //             ),
                      //           ),
                      //
                      //
                      //           child: Align(
                      //             alignment: Alignment.topRight,
                      //             child: Padding(
                      //               padding: EdgeInsets.all(5),
                      //               child: Icon(
                      //                 (orderList[index].isFav == 1)
                      //                     ? Icons.favorite
                      //                     : Icons.favorite_border,
                      //                 color: (orderList[index].isFav == 1)
                      //                     ? Colors.red
                      //                     : ConstantData.textColor,
                      //                 size: 15,
                      //               ),
                      //             ),
                      //
                      //           ),
                      //         ),
                      //         Expanded(
                      //           child: Column(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             crossAxisAlignment:
                      //                 CrossAxisAlignment.start,
                      //             children: [
                      //               Text(
                      //                 orderList[index].name,
                      //                 style: TextStyle(
                      //                   fontWeight: FontWeight.w700,
                      //                   fontSize: ConstantData.font12Px,
                      //                   fontFamily: ConstantData.fontFamily,
                      //                   color: ConstantData.textColor,
                      //                 ),
                      //               ),
                      //               Padding(
                      //                 padding:
                      //                     EdgeInsets.only(top: 2, bottom: 10),
                      //                 child: Text(orderList[index].desc,
                      //                     textAlign: TextAlign.start,
                      //                     style: TextStyle(
                      //                         fontWeight: FontWeight.w400,
                      //                         fontSize: 10,
                      //                         fontFamily: ConstantData.fontFamily,
                      //                         color: ConstantData.textColor,
                      //                         decoration:
                      //                             TextDecoration.none)),
                      //               ),
                      //               Row(
                      //                 mainAxisAlignment:
                      //                     MainAxisAlignment.start,
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.center,
                      //                 children: [
                      //                   Text(
                      //                     orderList[index].price,
                      //                     style: TextStyle(
                      //                       fontWeight: FontWeight.w700,
                      //                       fontSize: ConstantData.font12Px,
                      //                       fontFamily: ConstantData.fontFamily,
                      //                       color: ConstantData.textColor,
                      //                     ),
                      //                   ),
                      //                   new Spacer(),
                      //                   Padding(
                      //                     padding: EdgeInsets.only(right: 10),
                      //                     child: ImageIcon(
                      //                       AssetImage(
                      //                           'assets/images/pencil.png'),
                      //                       size: 15,
                      //                       color: ConstantData.textColor,
                      //                     ),
                      //                   ),
                      //                   Padding(
                      //                     padding: EdgeInsets.only(right: 10),
                      //                     child: ImageIcon(
                      //                       AssetImage(
                      //                           'assets/images/back-arrow.png'),
                      //                       size: 15,
                      //                       color: ConstantData.textColor,
                      //                     ),
                      //                   ),
                      //                 ],
                      //               )
                      //             ],
                      //           ),
                      //           flex: 1,
                      //         )
                      //       ],
                      //     ),
                      //     Container(
                      //       margin: EdgeInsets.only(
                      //           left: 10, right: 10, top: 10, bottom: 10),
                      //       width: double.infinity,
                      //       height: 1,
                      //       color: ConstantData.viewColor,
                      //     )
                      //   ],
                      // ),
                    ),
                    onTap: () {},
                  );
                }),
            // flex: 1,
            // ),
          ),
        ),
        onWillPop: _requestPop);
  }
}
