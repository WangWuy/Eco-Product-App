import 'package:eco_product_ui_updated/my_models/addresses_model.dart';
import 'package:eco_product_ui_updated/my_models/cards_model.dart';
import 'package:eco_product_ui_updated/my_models/cart_model.dart';
import 'package:eco_product_ui_updated/my_models/checkout_info.dart';
import 'package:eco_product_ui_updated/services/api_service.dart';
import 'package:eco_product_ui_updated/utils/ConstantWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eco_product_ui_updated/utils/ConstantData.dart';
import 'package:eco_product_ui_updated/utils/SizeConfig.dart';

import 'package:eco_product_ui_updated/generated/l10n.dart';
import 'package:eco_product_ui_updated/widget/my_widget/ConfirmationPage.dart';
import 'package:eco_product_ui_updated/widget/ReviewSlider.dart';

import 'AddNewCardPage.dart';

class PaymentPage extends StatefulWidget {
  final CheckoutInfo checkoutInfo;

  PaymentPage({required this.checkoutInfo});

  @override
  _PaymentPage createState() => _PaymentPage();
}

class _PaymentPage extends State<PaymentPage> {
  List<CardsModel> cardList = [];
  final ApiService _apiService = ApiService();
  bool isLoading = true;
  int _cardPosition = 0;
  // Map dữ liệu từ checkoutInfo
  late final AddressesModel selectedAddress;
  late final String subtotal;
  late final String shippingFee;
  late final String tax;
  late final String total;
  late final List<CartItem> items;

  @override
  void initState() {
    super.initState();
    selectedAddress = widget.checkoutInfo.address;
    subtotal = widget.checkoutInfo.subtotal;
    shippingFee = widget.checkoutInfo.shippingFee;
    tax = widget.checkoutInfo.tax;
    total = widget.checkoutInfo.total;
    items = widget.checkoutInfo.items;
    loadPayments();
  }

  Future<void> loadPayments() async {
    try {
      setState(() => isLoading = true);
      final payments = await _apiService.getPayments();
      setState(() {
        cardList = payments;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading payments: $e');
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error loading payments')));
    }
  }

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
            title: ConstantWidget.getAppBarText(S.of(context).checkOut),
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
                right: leftMargin, left: leftMargin, top: leftMargin),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      ReviewSlider(
                          optionStyle: TextStyle(
                            fontFamily: ConstantData.fontFamily,
                            fontSize: 8,
                            color: ConstantData.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                          onChange: (index) {},
                          initialValue: 1,
                          width: double.infinity,
                          options: [
                            S.of(context).personalInfo,
                            S.of(context).payment,
                            S.of(context).confirmation
                          ]),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: Text(
                          S.of(context).paymentMethods,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: ConstantData.fontFamily,
                              fontWeight: FontWeight.w800,
                              fontSize: ConstantData.font15Px,
                              color: ConstantData.textColor1),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 10),
                        child: Row(
                          children: [
                            ConstantWidget.getCustomText(
                                S.of(context).savedCards,
                                ConstantData.textColor1,
                                1,
                                TextAlign.start,
                                FontWeight.w800,
                                ConstantData.font15Px),
                            new Spacer(),
                            InkWell(
                              child: ConstantWidget
                                  .getUnderLineCustomTextWithoutAlign(
                                      S.of(context).newCard,
                                      ConstantData.textColor1,
                                      FontWeight.bold,
                                      ConstantData.font12Px),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddNewCardPage()));
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.width * 0.01),
                        child: isLoading
                            ? Center(child: CircularProgressIndicator())
                            : cardList.isEmpty
                                ? Center(
                                    child: Text('No payment methods found'))
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: cardList.length,
                                    itemBuilder: (context, index) {
                                      final card = cardList[index];
                                      return InkWell(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          padding: EdgeInsets.all(8),
                                          decoration: new BoxDecoration(
                                              color: ConstantData.whiteColor,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.shade200,
                                                  blurRadius: 10,
                                                )
                                              ],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  InkWell(
                                                      child: Icon(
                                                        CupertinoIcons
                                                            .checkmark_alt_circle_fill,
                                                        color: (_cardPosition ==
                                                                index)
                                                            ? ConstantData
                                                                .accentColor
                                                            : Colors
                                                                .grey.shade400,
                                                        size: 25,
                                                      ),
                                                      onTap: () {
                                                        _cardPosition = index;
                                                        setState(() {});
                                                      }),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      card.cardNumber,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              ConstantData
                                                                  .fontFamily,
                                                          color: ConstantData
                                                              .textColor1,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                  new Spacer(),
                                                  Image.asset(
                                                    cardList[index].image,
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      card.image,
                                                      width: 30,
                                                      height: 20,
                                                      color: ConstantData
                                                          .accentColor,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text(
                                                        "Valid from"
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                            fontFamily:
                                                                ConstantData
                                                                    .fontFamily,
                                                            color: ConstantData
                                                                .textColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontSize: 10),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text(
                                                        card.expiryDate,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                ConstantData
                                                                    .fontFamily,
                                                            color: ConstantData
                                                                .textColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontSize: 10),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 10, left: 2),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      card.cardHolderName
                                                          .toUpperCase(),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              ConstantData
                                                                  .fontFamily,
                                                          color: ConstantData
                                                              .textColor1,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontSize: 12),
                                                    ),
                                                    new Spacer(),
                                                    Text(
                                                      "CVV",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              ConstantData
                                                                  .fontFamily,
                                                          color: ConstantData
                                                              .textColor,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontSize: 14),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          top: 5,
                                                          left: 8,
                                                          bottom: 5,
                                                          right: 8),
                                                      margin: EdgeInsets.only(
                                                          left: 5),
                                                      decoration: BoxDecoration(
                                                        color: ConstantData
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          card.cvv,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  ConstantData
                                                                      .fontFamily,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              fontSize: 8),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        onTap: () {},
                                      );
                                    }),
                      ),
                    ],
                  ),
                  flex: 1,
                ),
                InkWell(
                  child: Container(
                      margin: EdgeInsets.only(
                          top: 10, bottom: leftMargin, left: leftMargin),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConfirmationPage(
                                  checkoutInfo: CheckoutInfo(
                                    address: widget.checkoutInfo.address,
                                    payment: cardList[_cardPosition],
                                    subtotal: widget.checkoutInfo.subtotal,
                                    shippingFee:
                                        widget.checkoutInfo.shippingFee,
                                    tax: widget.checkoutInfo.tax,
                                    total: widget.checkoutInfo.total,
                                    items: widget.checkoutInfo.items,
                                  ),
                                )));
                  },
                ),
              ],
            ),
          ),
        ),
        onWillPop: _requestPop);
  }
}
