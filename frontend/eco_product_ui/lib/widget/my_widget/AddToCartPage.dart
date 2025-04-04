import 'package:eco_product_ui_updated/my_models/cart_model.dart';
import 'package:eco_product_ui_updated/my_models/sub_category_model.dart';
import 'package:eco_product_ui_updated/services/api_service.dart';
import 'package:eco_product_ui_updated/utils/FormatMoney.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../generated/l10n.dart';
import '../../utils/ConstantData.dart';
import '../../utils/ConstantWidget.dart';
import '../../utils/SizeConfig.dart';
import 'CheckOutPage.dart';

class AddToCartPage extends StatefulWidget {
  AddToCartPage();

  @override
  _AddToCartPage createState() {
    return _AddToCartPage();
  }
}

class _AddToCartPage extends State<AddToCartPage> {
  CartModel? cart;
  List<CartItem> cartItems = [];
  List<SubCategoriesModel> cartProducts = [];
  final ApiService _apiService = ApiService();
  bool isLoading = true;

  _AddToCartPage();

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  Future<void> loadCart() async {
    try {
      setState(() => isLoading = true);
      final cartData = await _apiService.getCart();

      setState(() {
        cart = cartData;
        cartItems = cartData.items;
        cartProducts = cartItems
            .map((item) => item.product..quantity = item.quantity)
            .toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error in loadCart: $e');
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to load cart')));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: ConstantData.bgColor,
        appBar: AppBar(
          backgroundColor: ConstantData.bgColor,
          elevation: 0,
          centerTitle: true,
          title: ConstantWidget.getAppBarText(S.of(context).cart),
          leading: IconButton(
            icon: ConstantWidget.getAppBarIcon(),
            onPressed: _requestPop,
          ),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    SizeConfig().init(context);
    double leftMargin = MediaQuery.of(context).size.width * 0.04;
    double imageSize = SizeConfig.safeBlockVertical! * 10;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            backgroundColor: ConstantData.bgColor,
            elevation: 0,
            centerTitle: true,
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
          body: cartItems.isEmpty
              ? Center(child: Text('Your cart is empty'))
              : RefreshIndicator(
                  onRefresh: loadCart,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: leftMargin,
                              right: leftMargin,
                              bottom: MediaQuery.of(context).size.width * 0.01),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: cartItems.length,
                              itemBuilder: (context, index) {
                                return ListItem(
                                  imageSize: imageSize,
                                  cartItem: cartItems[index],
                                  subCategoryModel: cartProducts[index],
                                  onCartUpdated: loadCart,
                                );
                              }),
                        ),
                        flex: 1,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                          leftMargin + 20,
                          10,
                          leftMargin + 20,
                          leftMargin + 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 20),
                                height: 5,
                                width: 100,
                                color: ConstantData.cellColor,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ConstantWidget.getCustomText(
                                      S.of(context).subTotal,
                                      ConstantData.textColor,
                                      1,
                                      TextAlign.start,
                                      FontWeight.w800,
                                      14),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: ConstantWidget.getCustomText(
                                      cart!.subtotal.toVND(),
                                      ConstantData.textColor,
                                      1,
                                      TextAlign.end,
                                      FontWeight.w800,
                                      14),
                                  flex: 1,
                                )
                              ],
                            ),
                            SizedBox(height: 15),
                            Padding(
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ConstantWidget.getCustomText(
                                        S.of(context).shippingFee,
                                        ConstantData.textColor,
                                        1,
                                        TextAlign.start,
                                        FontWeight.w800,
                                        14),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: ConstantWidget.getCustomText(
                                        cart!.shippingFee.toVND(),
                                        ConstantData.textColor,
                                        1,
                                        TextAlign.end,
                                        FontWeight.w800,
                                        14),
                                    flex: 1,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ConstantWidget.getCustomText(
                                        S.of(context).estimatingTax,
                                        ConstantData.textColor,
                                        1,
                                        TextAlign.start,
                                        FontWeight.w800,
                                        14),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: ConstantWidget.getCustomText(
                                        cart!.tax.toVND(),
                                        ConstantData.textColor,
                                        1,
                                        TextAlign.end,
                                        FontWeight.w800,
                                        14),
                                    flex: 1,
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ConstantWidget.getCustomText(
                                      S.of(context).total,
                                      ConstantData.primaryTextColor,
                                      1,
                                      TextAlign.start,
                                      FontWeight.w800,
                                      16),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: ConstantWidget.getCustomText(
                                      cart!.total.toVND(),
                                      ConstantData.primaryTextColor,
                                      1,
                                      TextAlign.end,
                                      FontWeight.w800,
                                      16),
                                  flex: 1,
                                )
                              ],
                            ),
                            InkWell(
                              child: Container(
                                margin: EdgeInsets.only(top: 20),
                                height: 50,
                                decoration: BoxDecoration(
                                    color: ConstantData.primaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: Center(
                                  child:
                                      ConstantWidget.getCustomTextWithoutAlign(
                                          S.of(context).checkOut,
                                          Colors.white,
                                          FontWeight.w900,
                                          ConstantData.font15Px),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CheckOutPage(
                                              cartInfo: cart!,
                                            )));
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        ),
        onWillPop: _requestPop);
  }
}

class ListItem extends StatefulWidget {
  final double imageSize;
  final CartItem cartItem;
  final SubCategoriesModel subCategoryModel;
  final VoidCallback onCartUpdated;

  ListItem(
      {required this.imageSize,
      required this.cartItem,
      required this.subCategoryModel,
      required this.onCartUpdated});

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  final ApiService _apiService = ApiService();
  bool isLoading = false;

  Future<void> updateQuantity(String operation) async {
    if (isLoading) return;

    try {
      setState(() => isLoading = true);

      await _apiService.updateCartItemQuantity(
          widget.subCategoryModel.id, 1, operation);

      if (operation == 'add') {
        setState(() {
          widget.subCategoryModel.quantity++;
        });
      } else {
        setState(() {
          widget.subCategoryModel.quantity--;
        });
      }

      widget.onCartUpdated();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to update quantity')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> removeItem() async {
    try {
      await _apiService.removeCartItem(widget.subCategoryModel.id);
      widget.onCartUpdated();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to remove item')));
    }
  }

  @override
  Widget build(BuildContext context) {
    double radius = ConstantWidget.getScreenPercentSize(context, 1.8);
    return InkWell(
        child: Slidable(
      child: Center(
          child: InkWell(
        child: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
              color: ConstantData.whiteColor,
              borderRadius: BorderRadius.circular(radius),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 10,
                )
              ]),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: widget.imageSize,
                    width: widget.imageSize,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: ConstantData.addCartColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(radius),
                      ),
                    ),
                    child: Image.network(
                      widget.subCategoryModel.image,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.error, color: Colors.red);
                      },
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstantWidget.getCustomText(
                                widget.subCategoryModel.name,
                                ConstantData.textColor,
                                1,
                                TextAlign.start,
                                FontWeight.w800,
                                ConstantWidget.getScreenPercentSize(
                                    context, 2)),
                            Padding(
                              padding: EdgeInsets.only(top: 2, right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ConstantWidget.getCustomText(
                                        widget.subCategoryModel.price.toVND(),
                                        Colors.black87,
                                        1,
                                        TextAlign.start,
                                        FontWeight.bold,
                                        ConstantData.font15Px),
                                    flex: 1,
                                  ),
                                  InkWell(
                                    child: Container(
                                        margin: EdgeInsets.only(
                                          right: 15,
                                        ),
                                        padding: EdgeInsets.all(5),
                                        child: InkWell(
                                          child: Center(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                child: Container(
                                                  height: ConstantWidget
                                                      .getScreenPercentSize(
                                                          context, 3.5),
                                                  width: ConstantWidget
                                                      .getScreenPercentSize(
                                                          context, 3.5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          width: 1,
                                                          color: ConstantData
                                                              .greyColor)),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.remove,
                                                      size: 15,
                                                      color: ConstantData
                                                          .greyColor,
                                                    ),
                                                  ),
                                                ),
                                                onTap: widget.subCategoryModel
                                                            .quantity >
                                                        1
                                                    ? () => updateQuantity(
                                                        'subtract')
                                                    : null,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                child: isLoading
                                                    ? SizedBox(
                                                        width: 20,
                                                        height: 20,
                                                        child:
                                                            CircularProgressIndicator(
                                                                strokeWidth: 2))
                                                    : Text(
                                                        widget.subCategoryModel
                                                            .quantity
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                              ),
                                              InkWell(
                                                child: Container(
                                                  height: ConstantWidget
                                                      .getScreenPercentSize(
                                                          context, 3.5),
                                                  width: ConstantWidget
                                                      .getScreenPercentSize(
                                                          context, 3.5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          width: 1,
                                                          color: ConstantData
                                                              .accentColor)),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 15,
                                                      color: ConstantData
                                                          .accentColor,
                                                    ),
                                                  ),
                                                ),
                                                onTap: () =>
                                                    updateQuantity('add'),
                                              )
                                            ],
                                          )),
                                        )),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    flex: 1,
                  )
                ],
              ),
            ],
          ),
        ),
        onTap: () {},
      )),
      endActionPane: ActionPane(
        motion: DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => removeItem(),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Remove',
          ),
        ],
      ),
    ));
  }
}
