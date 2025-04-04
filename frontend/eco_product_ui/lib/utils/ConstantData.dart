import 'package:flutter/material.dart';

import 'SizeConfig.dart';

class ConstantData {
  static String assetsPath = "assets/images/";
  static const double avatarRadius = 40;

  static const double padding = 20;

  static Color chatBgColor = "#52575C".toColor();
  static Color primaryColor = "#4CAF50".toColor();
  static Color primaryColorWithOpacity = "#DAF2CF".toColor();
  static Color accentColor = "#F17B3A".toColor();
  static Color cellColor = "#E4E6ED".toColor();
  static Color proColor = "#e6fbe6".toColor();
  static Color bgColor = "#FBFBFB".toColor();
  static Color viewColor = "#CCCCCC".toColor();
  static Color whiteColor = "#FFFFFF".toColor();
  static Color disableIconColor = "#D1DDF4".toColor();
  static Color primaryTextColor = "#3F3F41".toColor();
  static Color textColor = Colors.black54;
  static Color subTextColor = "#7D90AA".toColor();
  static Color textColor1 = "#293040".toColor();
  // static Color textColor = "#575757".toColor();
  // static Color textColor = "#000000".toColor();
  static Color filterColor = "#D8DCDF".toColor();
  static Color blueColor = "#254296".toColor();
  static Color purpleColor = "#6961DA".toColor();
  static Color greyColor = "#C3C3C3".toColor();
  static Color iconColor = Colors.black54;
  // static Color iconColor = "#783E01".toColor();
  static Color circleColor = "#A9C2D6".toColor();
  static Color addCartColor = "#F6F7F9".toColor();
  static String fontFamily = "SFProText";
  static double font12Px = SizeConfig.safeBlockVertical! / 0.75;
  static double font15Px = SizeConfig.safeBlockVertical! / 0.6;
  static double font18Px = SizeConfig.safeBlockVertical! / 0.5;

  static Color getOrderColor(String s) {
    if (s.contains("On Delivery")) {
      return "#FFEDCE".toColor();
    } else if (s.contains("Completed")) {
      return primaryColor;
    } else {
      return Colors.red;
    }
  }

  static Color getIconColor(String s) {
    if (s.contains("On Delivery")) {
      return accentColor;
    } else {
      return Colors.white;
    }
  }
}

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
