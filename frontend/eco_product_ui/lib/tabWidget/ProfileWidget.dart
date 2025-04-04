import 'package:flutter/material.dart';

import '../data/DataFile.dart';
import '../generated/l10n.dart';
import '../main.dart';
import '../model/ProfileModel.dart';
import '../utils/ConstantData.dart';
import '../utils/ConstantWidget.dart';
import '../utils/PrefData.dart';
import '../utils/SizeConfig.dart';
import '../widget/AboutUsPage.dart';
import '../widget/my_widget/EditProfilePage.dart';
import '../widget/my_widget/FavouritePage.dart';
import '../widget/my_widget/MyOrderPage.dart';
import '../widget/my_widget/MySavedCardsPage.dart';
import '../widget/MyVouchers.dart';
import '../widget/NotificationList.dart';
import '../widget/my_widget/ShippingAddressPage.dart';
import '../widget/WriteReviewPage.dart';

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidget createState() {
    return _ProfileWidget();
  }
}

class _ProfileWidget extends State<ProfileWidget> {
  ProfileModel profileModel = DataFile.getProfileModel();

  @override
  void initState() {
    super.initState();
    profileModel = DataFile.getProfileModel();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double leftMargin = MediaQuery.of(context).size.width * 0.04;
    double imageSize = SizeConfig.safeBlockVertical! * 15;

    return Scaffold(
      backgroundColor: ConstantData.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ConstantData.bgColor,
        elevation: 0,
        centerTitle: true,
        title: ConstantWidget.getAppBarText(S.of(context).profile),
      ),
      body: Container(
        margin: EdgeInsets.only(
            left: leftMargin,
            right: leftMargin,
            bottom: MediaQuery.of(context).size.width * 0.01),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Container(
                // padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: imageSize,
                          width: imageSize,
                          // margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            image: DecorationImage(
                              image: ExactAssetImage(profileModel.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ConstantWidget.getCustomTextWithoutAlign(
                                    profileModel.name,
                                    ConstantData.textColor,
                                    FontWeight.bold,
                                    ConstantData.font18Px),
                                Padding(
                                  padding: EdgeInsets.only(top: 2),
                                  child:
                                      ConstantWidget.getCustomTextWithoutAlign(
                                          profileModel.email,
                                          ConstantData.primaryTextColor,
                                          FontWeight.w500,
                                          ConstantData.font12Px),
                                )
                              ],
                            ),
                          ),
                          flex: 1,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              child: _getCell(S.of(context).editProfiles, Icons.edit),
              onTap: () {
                sendAction(EditProfilePage());
              },
            ),
            InkWell(
              child: _getCell(S.of(context).myOrder, Icons.shopping_bag),
              onTap: () {
                sendAction(MyOrderPage());
              },
            ),
            InkWell(
              child: _getCell(S.of(context).myFavourite, Icons.favorite),
              onTap: () {
                sendAction(FavouritePage());
              },
            ),
            InkWell(
              child: _getCell(
                  S.of(context).shippingAddress, Icons.local_shipping_outlined),
              onTap: () {
                sendAction(ShippingAddressPage());
              },
            ),
            InkWell(
              child: _getCell(S.of(context).mySavedCards, Icons.credit_card),
              onTap: () {
                sendAction(MySavedCardsPage());
              },
            ),
            InkWell(
              child: _getCell(S.of(context).giftCard, Icons.card_giftcard),
              onTap: () {
                sendAction(MyVouchers(false));
              },
            ),
            InkWell(
              child: _getCell(
                  S.of(context).notification, Icons.notifications_none),
              onTap: () {
                sendAction(NotificationList());
              },
            ),
            InkWell(
              child: _getCell(S.of(context).review, Icons.rate_review),
              onTap: () {
                sendAction(WriteReviewPage());
              },
            ),
            InkWell(
              child: _getCell(S.of(context).aboutUs, Icons.info),
              onTap: () {
                sendAction(AboutUsPage());
              },
            ),
            InkWell(
              child: _getCell(S.of(context).logout, Icons.logout),
              onTap: () {
                PrefData.setIsSignIn(false);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              },
            ),
          ],
        ),
      ),
    );
  }

  void sendAction(StatefulWidget className) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => className));
  }

  Widget _getCell(String s, var icon) {
    return Container(
      margin: EdgeInsets.only(
          bottom: ConstantWidget.getScreenPercentSize(context, 0.2)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                    right: ConstantWidget.getScreenPercentSize(context, 1)),
                height: ConstantWidget.getScreenPercentSize(context, 5),
                width: ConstantWidget.getScreenPercentSize(context, 5),
                decoration: new BoxDecoration(
                    color: ConstantData.cellColor,
                    // color: ConstantData.cellColor,
                    borderRadius: BorderRadius.all(Radius.circular(
                        ConstantWidget.getScreenPercentSize(context, 0.8)))),
                child: Icon(
                  icon,
                  size: ConstantWidget.getScreenPercentSize(context, 2),
                  // color: ConstantData.primaryColor,
                  color: ConstantData.primaryTextColor,
                ),
              ),
              Text(
                s,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ConstantData.font15Px,
                  fontFamily: ConstantData.fontFamily,
                  color: ConstantData.textColor,
                ),
              ),
              new Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: Icon(
                    Icons.navigate_next,
                    color: ConstantData.textColor,
                    size: ConstantWidget.getScreenPercentSize(context, 3),
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 15),
            height: 1,
            color: ConstantData.viewColor,
          ),
        ],
      ),
    );
  }
}
