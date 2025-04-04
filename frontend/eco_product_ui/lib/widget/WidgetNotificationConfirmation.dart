
// ignore_for_file: deprecated_member_use

import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../utils/ConstantData.dart';
import '../utils/ConstantWidget.dart';
import '../utils/SizeConfig.dart';
import 'my_widget/LoginPage.dart';


class WidgetNotificationConfirmation extends StatefulWidget {
  @override
  _WidgetNotificationConfirmation createState() =>
      _WidgetNotificationConfirmation();
}

class _WidgetNotificationConfirmation
    extends State<WidgetNotificationConfirmation> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: new Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new ParallaxContainer(
                    child: ConstantWidget.getCustomText(S.of(context).app_name, ConstantData.primaryColor, 1,
                        TextAlign.center, FontWeight.bold, 28),
                    position: 0,
                  ),
                  // SizedBox(
                  //   height: 45.0,
                  // ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 2,
                  ),
                  new ParallaxContainer(
                    child: new Image.asset(
                      ConstantData.assetsPath  + "img_allow_notification.png",
                      fit: BoxFit.contain,
                      width: SizeConfig.safeBlockHorizontal! * 70,
                      height: SizeConfig.safeBlockVertical! * 40,
                    ),
                    translationFactor: 400.0,
                    position: 0,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 2,
                  ),
                  // SizedBox(
                  //   height: 45.0,
                  // ),
                  new ParallaxContainer(
                    child: ConstantWidget.getCustomText("Notifications", Colors.black, 1,
                        TextAlign.center, FontWeight.w600, 20),
                    translationFactor: 400.0,
                    position: 0,
                  ),
                  new ParallaxContainer(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child:ConstantWidget. getCustomText(
                          "Stay notified about course updates,\nnew exam tools and change to\nthe leaderboard",
                          Colors.black,
                          3,
                          TextAlign.center,
                          FontWeight.normal,
                          16),
                    ),
                    translationFactor: 300.0,
                    position: 0,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 1.5,
                  ),

                  new ParallaxContainer(
                    child: InkWell(


                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ));
                      },
                      child: Container(



                          decoration: BoxDecoration(
                            borderRadius: new BorderRadius.circular(22.0),
                            color: ConstantData.primaryColor,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),


                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ConstantWidget.getCustomText("Allow", Colors.white, 1,
                                  TextAlign.center, FontWeight.w400, 18),
                            ],
                          )),
                    ),
                    position: 0,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  new ParallaxContainer(
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ));
                      },
                      child: ConstantWidget.getCustomText("Skip", ConstantData.primaryColor, 1,
                          TextAlign.center, FontWeight.w500, 18),
                    ),
                    position: 0,
                    opacityFactor: 0.7,
                    // opacityFactor: 2.5,
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          return false;
        });
  }
}
