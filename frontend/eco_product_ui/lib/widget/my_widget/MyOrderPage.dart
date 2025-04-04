import 'package:eco_product_ui_updated/generated/l10n.dart';
import 'package:eco_product_ui_updated/my_models/orders_model.dart';
import 'package:eco_product_ui_updated/services/api_service.dart';
import 'package:eco_product_ui_updated/utils/ConstantData.dart';
import 'package:eco_product_ui_updated/utils/ConstantWidget.dart';
import 'package:eco_product_ui_updated/utils/SizeConfig.dart';
import 'package:eco_product_ui_updated/widget/my_widget/AddToCartPage.dart';
import 'package:eco_product_ui_updated/widget/my_widget/OrderDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MyOrderPage extends StatefulWidget {
  @override
  _MyOrderPage createState() {
    return _MyOrderPage();
  }
}

class _MyOrderPage extends State<MyOrderPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  final ApiService _apiService = ApiService();
  List<OrdersModel> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
    loadOrders();
  }

  Future<void> loadOrders() async {
    try {
      setState(() => isLoading = true);
      final data = await _apiService.getOrders();
      setState(() {
        orders = data;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading orders: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> _cancelOrder(OrdersModel order) async {
    try {
      await _apiService.updateOrderStatus(order.id, 'cancelled');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Order cancelled successfully')));
      loadOrders(); // Load lại danh sách orders
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to cancel order')));
    }
  }

  Future<void> _reOrder(OrdersModel order) async {
    try {
      // Lấy sản phẩm đầu tiên trong order để add vào cart
      if (order.items.isNotEmpty) {
        final item = order.items.first;
        await _apiService.addToCart(item.productId, item.quantity);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(S.of(context).productAdded)));

        // Chuyển sang trang cart
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddToCartPage()));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to re-order')));
    }
  }

  List<OrdersModel> getFilteredOrders(String status) {
    return orders.where((order) => order.status == status).toList();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  Widget buildOrderItem(OrdersModel order) {
    double imageSize = SizeConfig.safeBlockVertical! * 8;
    double cellHeight = SizeConfig.safeBlockVertical! * 5.5;

    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: ConstantData.whiteColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 10,
              )
            ]),
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 9),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: imageSize,
                  width: imageSize,
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: ConstantData.cellColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: order.items.isNotEmpty &&
                          order.items.first.product != null
                      ? Image.network(order.items.first.product!.image)
                      : Icon(Icons.image_not_supported),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstantWidget.getCustomText(
                          "${S.of(context).orderId} : #${order.id}",
                          ConstantData.textColor,
                          1,
                          TextAlign.start,
                          FontWeight.w800,
                          16),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: ConstantWidget.getCustomText(
                            "${order.items.length} ${S.of(context).items}",
                            ConstantData.textColor,
                            1,
                            TextAlign.start,
                            FontWeight.w500,
                            14),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 20, left: 15, right: 15),
              child: Row(
                children: [
                  if (order.status == 'shipping') ...[
                    Expanded(
                      child: InkWell(
                        child: Container(
                          height: cellHeight,
                          margin: EdgeInsets.only(right: 15),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 0.5, color: Colors.grey.shade400)),
                          child: Center(
                            child: ConstantWidget.getCustomTextWithoutAlign(
                                S.of(context).cancelOrder,
                                ConstantData.textColor,
                                FontWeight.w700,
                                14),
                          ),
                        ),
                        onTap: () => _cancelOrder(order),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Container(
                          height: cellHeight,
                          margin: EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            color: ConstantData.primaryColor,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: ConstantWidget.getCustomTextWithoutAlign(
                                S.of(context).trackOrder,
                                Colors.white,
                                FontWeight.w700,
                                14),
                          ),
                        ),
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => OrderTrackMap(),
                          //     ));
                        },
                      ),
                    ),
                  ] else if (order.status == 'delivered') ...[
                    Expanded(
                      child: InkWell(
                        child: Container(
                          height: cellHeight,
                          decoration: BoxDecoration(
                            color: ConstantData.primaryColor,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: ConstantWidget.getCustomTextWithoutAlign(
                                S.of(context).reOrder,
                                Colors.white,
                                FontWeight.w700,
                                14),
                          ),
                        ),
                        onTap: () => _reOrder(order),
                      ),
                    ),
                  ],
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OrderDetailPage()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantData.bgColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: ConstantData.bgColor,
        title: ConstantWidget.getAppBarText(S.of(context).myOrderHistory),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: ConstantWidget.getAppBarIcon(),
              onPressed: _requestPop,
            );
          },
        ),
        bottom: TabBar(
          indicatorColor: ConstantData.primaryColor,
          indicatorWeight: 3,
          unselectedLabelColor: ConstantData.textColor,
          labelColor: ConstantData.primaryColor,
          labelStyle: TextStyle(
            fontFamily: ConstantData.fontFamily,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: ConstantData.fontFamily,
            fontWeight: FontWeight.w200,
            fontSize: 14,
          ),
          controller: _controller,
          tabs: [
            Tab(text: S.of(context).all),
            Tab(text: S.of(context).onDelivery),
            Tab(text: S.of(context).history),
          ],
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _controller,
              children: [
                // All Orders
                ListView(
                  children: [
                    ...orders
                        .where((order) =>
                            order.status == 'shipping' ||
                            order.status == 'delivered')
                        .map(buildOrderItem)
                        .toList(),
                  ],
                ),
                // On Delivery
                ListView(
                  children: [
                    ...getFilteredOrders('shipping')
                        .map(buildOrderItem)
                        .toList(),
                  ],
                ),
                // History
                ListView(
                  children: [
                    ...getFilteredOrders('delivered')
                        .map(buildOrderItem)
                        .toList(),
                  ],
                ),
              ],
            ),
    );
  }
}
