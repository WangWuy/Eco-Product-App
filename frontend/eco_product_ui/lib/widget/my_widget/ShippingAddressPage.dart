import 'package:eco_product_ui_updated/my_models/addresses_model.dart';
import 'package:eco_product_ui_updated/services/api_service.dart';
import 'package:eco_product_ui_updated/utils/ConstantWidget.dart';
import 'package:flutter/material.dart';
import 'package:eco_product_ui_updated/generated/l10n.dart';
import 'package:eco_product_ui_updated/utils/ConstantData.dart';
import 'package:eco_product_ui_updated/utils/SizeConfig.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'AddNewAddressPage.dart';

class ShippingAddressPage extends StatefulWidget {
  @override
  _ShippingAddressPage createState() {
    return _ShippingAddressPage();
  }
}

class _ShippingAddressPage extends State<ShippingAddressPage> {
  List<AddressesModel> addressList = [];
  final ApiService _apiService = ApiService();
  bool isLoading = true;
  int _selectedAddress = 0;
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    loadAddresses();
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

  // Load danh sách địa chỉ
  Future<void> loadAddresses() async {
    try {
      setState(() => isLoading = true);
      final addresses = await _apiService.getUserAddresses();

      setState(() {
        addressList = addresses;
        isLoading = false;
      });
      _refreshController.refreshCompleted();
    } catch (e) {
      print('Error loading addresses: $e');
      setState(() => isLoading = false);
      _refreshController.refreshFailed();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error loading addresses')));
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
            title: ConstantWidget.getAppBarText(S.of(context).shippingAddress),
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
            onRefresh: loadAddresses,
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(
                    margin: EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 15,
                        bottom: MediaQuery.of(context).size.width * 0.01),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                              child: ConstantWidget
                                  .getUnderLineCustomTextWithoutAlign(
                                      S.of(context).newAddress,
                                      ConstantData.textColor1,
                                      FontWeight.w600,
                                      ConstantData.font12Px),
                              onTap: () async {
                                final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddNewAddressPage()));
                                if (result == true) {
                                  loadAddresses(); // Reload khi thêm địa chỉ mới
                                }
                              },
                            )
                          ],
                        ),
                        addressList.isEmpty
                            ? Center(child: Text('No addresses found'))
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: addressList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(top: 10, bottom: 10),
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              ConstantWidget
                                                  .getCustomTextWithFontSize(
                                                      addressList[index]
                                                          .fullName,
                                                      ConstantData.textColor1,
                                                      ConstantData.font12Px,
                                                      FontWeight.bold),
                                              new Spacer(),
                                              Icon(
                                                (_selectedAddress == index)
                                                    ? Icons.radio_button_checked
                                                    : Icons
                                                        .radio_button_unchecked,
                                                color:
                                                    (_selectedAddress == index)
                                                        ? ConstantData.textColor
                                                        : ConstantData
                                                            .disableIconColor,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: ConstantWidget
                                                .getCustomTextWithFontSize(
                                                    addressList[index].address,
                                                    ConstantData
                                                        .primaryTextColor,
                                                    10,
                                                    FontWeight.w500),
                                          ),
                                          ConstantWidget
                                              .getCustomTextWithFontSize(
                                                  addressList[index]
                                                      .phoneNumber,
                                                  ConstantData.primaryTextColor,
                                                  10,
                                                  FontWeight.w500),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      _selectedAddress = index;
                                      setState(() {});
                                    },
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
