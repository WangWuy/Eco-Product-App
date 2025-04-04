import 'package:eco_product_ui_updated/my_models/cards_model.dart';
import 'package:eco_product_ui_updated/services/api_service.dart';
import 'package:eco_product_ui_updated/utils/ConstantWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eco_product_ui_updated/generated/l10n.dart';
import 'package:eco_product_ui_updated/utils/ConstantData.dart';
import 'package:eco_product_ui_updated/utils/SizeConfig.dart';
import 'package:eco_product_ui_updated/widget/my_widget/AddNewCardPage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MySavedCardsPage extends StatefulWidget {
  @override
  _MySavedCardsPage createState() {
    return _MySavedCardsPage();
  }
}

class _MySavedCardsPage extends State<MySavedCardsPage> {
  List<CardsModel> cardList = [];
  final ApiService _apiService = ApiService();
  bool isLoading = true;
  final RefreshController _refreshController = RefreshController();
  int _selectedCards = 0;

  @override
  void initState() {
    super.initState();
    loadPayments();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  Future<void> loadPayments() async {
    try {
      setState(() => isLoading = true);
      final payments = await _apiService.getPayments();
      setState(() {
        cardList = payments;
        isLoading = false;
      });
      _refreshController.refreshCompleted();
    } catch (e) {
      print('Error loading payments: $e');
      setState(() => isLoading = false);
      _refreshController.refreshFailed();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error loading payments')));
    }
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
            title: ConstantWidget.getAppBarText(S.of(context).mySavedCards),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: ConstantWidget.getAppBarIcon(),
                  onPressed: _requestPop,
                );
              },
            ),
          ),
          body: SmartRefresher(
            enablePullDown: true,
            controller: _refreshController,
            onRefresh: loadPayments,
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(
                    margin: EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 15,
                        bottom: MediaQuery.of(context).size.width * 0.01),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ConstantWidget.getCustomText(
                                    S.of(context).savedCards,
                                    ConstantData.textColor,
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
                                          FontWeight.w600,
                                          ConstantData.font12Px),
                                  onTap: () async {
                                    final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddNewCardPage()));
                                    if (result == true) {
                                      loadPayments();
                                    }
                                  },
                                )
                              ],
                            ),
                            cardList.isEmpty
                                ? Center(
                                    child: Text('No payment methods found'))
                                : ListView.builder(
                                    shrinkWrap: true,
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
                                                        color:
                                                            (_selectedCards ==
                                                                    index)
                                                                ? ConstantData
                                                                    .accentColor
                                                                : Colors.grey
                                                                    .shade400,
                                                        size: 25,
                                                      ),
                                                      onTap: () {
                                                        _selectedCards = index;
                                                        setState(() {});
                                                      }),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      card.cardNumber,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              ConstantData
                                                                  .fontFamily,
                                                          color: ConstantData
                                                              .textColor,
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
                                                      ConstantData.assetsPath +
                                                          "credit_card.png",
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
                                                      card.cardNumber
                                                          .toUpperCase(),
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
                                    })
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        onWillPop: _requestPop);
  }
}
