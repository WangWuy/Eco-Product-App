// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eco_product_ui_updated/tabWidget/AllDataWidget.dart';
import 'package:eco_product_ui_updated/tabWidget/HomeWidget.dart';
import 'package:eco_product_ui_updated/tabWidget/ProfileWidget.dart';
import 'package:eco_product_ui_updated/tabWidget/SearchWidget.dart';

import 'package:eco_product_ui_updated/utils/ConstantData.dart';
import 'package:eco_product_ui_updated/utils/SizeConfig.dart';
import 'package:eco_product_ui_updated/widget/my_widget/AddToCartPage.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
// import 'package:motion_tab_bar/MotionTabBarView.dart';
// import 'package:motion_tab_bar/MotionTabController.dart';
// import 'package:motion_tab_bar/motiontabbar.dart';

class TabWidget extends StatefulWidget {
  TabWidget();

  @override
  _TabWidget createState() {
    return _TabWidget();
  }
}

class _TabWidget extends State<TabWidget> with TickerProviderStateMixin {
  bool isAppbarVisible = true;

  // late MotionTabController _tabController;
  TabController? _tabController;


  int _selectedTab = 0;
  // late MotionTabBar motionTabBar;

  // _TabWidget(this._selectedTab, this.onChanged, this.onDataChanged);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: _selectedTab,
      length:5,
      vsync: this,
    );

    // _tabController =
    // new MotionTabController(initialIndex: _selectedTab, vsync: this);
    // _tabController.length = 5;
  }

  @override
  void dispose() {
    super.dispose();
    try {
      _tabController!.dispose();
    } catch (e) {
      print(e);
    }
  }

  void setAppbar() {
    setState(() {});
  }

  Future<bool> _requestPop() {
      Future.delayed(const Duration(milliseconds: 200), () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      });


    return new Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);



    return WillPopScope(
        child: Scaffold(

          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              Container(
                // color: Colors.red,
                child: HomeWidget(),
              ),
              Container(
                // color: Colors.black,
                child: AllDataWidget(),
              ),
              Container(
                // color: Colors.blue,
                child: AddToCartPage(),
              ),
              Container(
                // color: Colors.brown,
                child: SearchWidget(),
              ),
              Container(
                color: Colors.brown,
                  child: ProfileWidget(),
                  // child: ProfileWidget(widget.onChanged),
              ),
            ],
          ),
          bottomNavigationBar:  MotionTabBar(
            labels: ["Home", "Data", "Cart", "Search", "Profile"],
            initialSelectedTab: "Home",
            tabIconColor: ConstantData.primaryColor,
            tabSelectedColor: ConstantData.primaryColor,
            onTabItemSelected: (int value) {
              print(value);
              setState(() {
                _tabController!.index = value;
                _selectedTab = value;
              });
            },
            icons: [
              Icons.home_outlined,
              CupertinoIcons.cube_box,
              Icons.shopping_cart,
              Icons.search,
              Icons.account_circle
            ],
            textStyle: TextStyle(color: Colors.red, fontSize: 0),
          ),
        ),
        onWillPop: _requestPop);
  }
}
