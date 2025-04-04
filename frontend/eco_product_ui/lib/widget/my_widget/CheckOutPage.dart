import 'package:eco_product_ui_updated/generated/l10n.dart';
import 'package:eco_product_ui_updated/my_models/addresses_model.dart';
import 'package:eco_product_ui_updated/my_models/cart_model.dart';
import 'package:eco_product_ui_updated/my_models/checkout_info.dart';
import 'package:eco_product_ui_updated/services/api_service.dart';
import 'package:eco_product_ui_updated/utils/ConstantData.dart';
import 'package:eco_product_ui_updated/utils/ConstantWidget.dart';
import 'package:eco_product_ui_updated/utils/SizeConfig.dart';
import 'package:eco_product_ui_updated/widget/my_widget/AddNewAddressPage.dart';
import 'package:eco_product_ui_updated/widget/my_widget/PaymentPage.dart';
import 'package:eco_product_ui_updated/widget/ReviewSlider.dart';
import 'package:flutter/material.dart';

class CheckOutPage extends StatefulWidget {
  final CartModel cartInfo;

  CheckOutPage({required this.cartInfo});

  @override
  _CheckOutPage createState() => _CheckOutPage();
}

class _CheckOutPage extends State<CheckOutPage> {
  List<AddressesModel> addressList = [];
  final ApiService _apiService = ApiService();
  bool isLoading = true;
  int _selectedPosition = 0;
  int currentStep = 0;
  // Thêm các giá trị từ cartInfo
  late final String subtotal;
  late final String shippingFee;
  late final String tax;
  late final String total;
  late final List<CartItem> items;

  @override
  void initState() {
    super.initState();
    subtotal = widget.cartInfo.subtotal;
    shippingFee = widget.cartInfo.shippingFee;
    tax = widget.cartInfo.tax;
    total = widget.cartInfo.total;
    items = widget.cartInfo.items;
    loadAddresses();
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  Future<void> loadAddresses() async {
    try {
      setState(() => isLoading = true);

      final userDetail = await _apiService.getUserDetail();

      setState(() {
        addressList = userDetail.addresses;
        _selectedPosition = addressList
            .indexWhere((address) => address.id == userDetail.defaultAddressId);
        if (_selectedPosition == -1) _selectedPosition = 0;

        isLoading = false;
      });
    } catch (e) {
      print('Error loading addresses: $e');
      setState(() {
        addressList = [];
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading addresses')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: ConstantData.bgColor,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: ConstantData.bgColor,
          title: ConstantWidget.getAppBarText(S.of(context).cart),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: ConstantWidget.getAppBarIcon(),
                onPressed: _requestPop,
              );
            },
          ),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    SizeConfig().init(context);
    double leftMargin = MediaQuery.of(context).size.width * 0.05;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: ConstantData.bgColor,
            title: ConstantWidget.getAppBarText(S.of(context).cart),
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
                left: leftMargin, right: leftMargin, top: leftMargin),
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
                          initialValue: 0,
                          width: double.infinity,
                          options: [
                            S.of(context).personalInfo,
                            S.of(context).payment,
                            S.of(context).confirmation
                          ]),
                      Container(
                        child: Row(
                          children: [
                            ConstantWidget.getCustomText(
                                S.of(context).addressTitle,
                                ConstantData.textColor1,
                                1,
                                TextAlign.start,
                                FontWeight.w800,
                                ConstantData.font15Px),
                            new Spacer(),
                            InkWell(
                              child: ConstantWidget.getUnderlineText(
                                  S.of(context).newAddress,
                                  ConstantData.textColor1,
                                  1,
                                  TextAlign.start,
                                  FontWeight.bold,
                                  ConstantData.font12Px),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddNewAddressPage()));
                              },
                            )
                          ],
                        ),
                      ),
                      addressList.isEmpty
                          ? Center(child: Text('No addresses found'))
                          : Container(
                              margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.width * 0.01,
                              ),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: addressList.length,
                                  itemBuilder: (context, index) {
                                    final address = addressList[index];
                                    return InkWell(
                                      child: Column(
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            margin: EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              ConstantWidget.getCustomTextWithoutAlign(
                                                                  address
                                                                      .fullName,
                                                                  ConstantData
                                                                      .textColor1,
                                                                  FontWeight
                                                                      .w700,
                                                                  ConstantData
                                                                      .font15Px),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 5),
                                                                child: ConstantWidget.getCustomTextWithoutAlign(
                                                                    address.address +
                                                                        ', ' +
                                                                        address
                                                                            .city,
                                                                    ConstantData
                                                                        .primaryTextColor,
                                                                    FontWeight
                                                                        .w500,
                                                                    ConstantData
                                                                        .font12Px),
                                                              )
                                                            ],
                                                          ),
                                                          new Spacer(),
                                                          Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right: 3),
                                                              child: Icon(
                                                                (index ==
                                                                        _selectedPosition)
                                                                    ? Icons
                                                                        .radio_button_checked
                                                                    : Icons
                                                                        .radio_button_unchecked,
                                                                color: (index ==
                                                                        _selectedPosition)
                                                                    ? ConstantData
                                                                        .textColor
                                                                    : ConstantData
                                                                        .disableIconColor,
                                                                size: 20,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      flex: 1,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 1,
                                            color: ConstantData.viewColor,
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        setState(
                                            () => _selectedPosition = index);
                                      },
                                    );
                                  }),
                            ),
                    ],
                  ),
                  flex: 1,
                ),
                InkWell(
                  child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: leftMargin),
                      height: 50,
                      decoration: BoxDecoration(
                          color: ConstantData.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: InkWell(
                        child: Center(
                          child: ConstantWidget.getCustomTextWithoutAlign(
                              S.of(context).continueString,
                              Colors.white,
                              FontWeight.w900,
                              ConstantData.font15Px),
                        ),
                      )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentPage(
                                  checkoutInfo: CheckoutInfo(
                                    address: addressList[_selectedPosition],
                                    payment: null,
                                    subtotal: widget.cartInfo.subtotal,
                                    shippingFee: widget.cartInfo.shippingFee,
                                    tax: widget.cartInfo.tax,
                                    total: widget.cartInfo.total,
                                    items: widget.cartInfo.items,
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
