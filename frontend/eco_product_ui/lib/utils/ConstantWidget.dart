import 'package:flutter/material.dart';

import 'ConstantData.dart';

class ConstantWidget {
  static double largeTextSize = 28;

  static Widget getHorizonSpace(double space) {
    return SizedBox(
      width: space,
    );
  }

  static double getWidthPercentSize(BuildContext context, double percent) {
    return (MediaQuery.of(context).size.width * percent) / 100;
  }

  static Widget getCustomTextWithFontSize(
      String text, Color color, double fontSize, FontWeight fontWeight) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontFamily: ConstantData.fontFamily,
          decoration: TextDecoration.none,
          fontWeight: fontWeight),
    );
  }

  static double getPercentSize(double total, double percent) {
    return (total * percent) / 100;
  }

  static double getScreenPercentSize(BuildContext context, double percent) {
    return (MediaQuery.of(context).size.height * percent) / 100;
  }

  static Widget getCustomTextWithAlign(
      String text, Color color, TextAlign textAlign, FontWeight fontWeight) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          color: color,
          fontFamily: ConstantData.fontFamily,
          decoration: TextDecoration.none,
          fontWeight: fontWeight),
    );
  }

  static Widget getCustomTextWithoutAlign(
      String text, Color color, FontWeight fontWeight, double fontSize) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontFamily: ConstantData.fontFamily,
          decoration: TextDecoration.none,
          fontWeight: fontWeight),
    );
  }

  static Widget getUnderLineCustomTextWithoutAlign(
      String text, Color color, FontWeight fontWeight, double fontSize) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontFamily: ConstantData.fontFamily,
          decoration: TextDecoration.underline,
          fontWeight: fontWeight),
    );
  }

  static Widget getRoundCornerButtonWithoutIcon(String texts, Color color,
      Color textColor, double btnRadius, Function function) {
    return InkWell(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: new BorderRadius.circular(btnRadius),
            color: color,
          ),
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              getCustomText(
                  texts, textColor, 1, TextAlign.center, FontWeight.w400, 18)
            ],
          )),
      onTap: () {
        function();
      },
    );
  }

  static Widget getCustomTextWithoutSize(
      String text, Color color, FontWeight fontWeight) {
    return Text(
      text,
      style: TextStyle(
          decoration: TextDecoration.none,
          color: color,
          fontFamily: ConstantData.fontFamily,
          fontWeight: fontWeight),
    );
  }

  static Widget getCustomText(String text, Color color, int maxLine,
      TextAlign textAlign, FontWeight fontWeight, double textSizes) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: textSizes,
          color: color,
          fontFamily: ConstantData.fontFamily,
          fontWeight: fontWeight),
      maxLines: maxLine,
      textAlign: textAlign,
    );
  }

  static Widget getUnderlineText(String text, Color color, int maxLine,
      TextAlign textAlign, FontWeight fontWeight, double textSizes) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          decoration: TextDecoration.underline,
          fontSize: textSizes,
          color: color,
          fontFamily: ConstantData.fontFamily,
          fontWeight: fontWeight),
      maxLines: maxLine,
      textAlign: textAlign,
    );
  }

  // static void getColorFromBitmap(){
  //
  //
  //   img.Image bitmap =
  //   img.decodeImage(new File('assets/images/keyboard.jpg').readAsBytesSync());
  //
  //   int redBucket = 0;
  //   int greenBucket = 0;
  //   int blueBucket = 0;
  //   int pixelCount = 0;
  //
  //   for (int y = 0; y < bitmap.height; y++) {
  //     for (int x = 0; x < bitmap.width; x++) {
  //       int c = bitmap.getPixel(x, y);
  //
  //       pixelCount++;
  //       redBucket += img.getRed(c);
  //       greenBucket += img.getGreen(c);
  //       blueBucket += img.getBlue(c);
  //     }
  //   }
  //
  //   Color averageColor = Color.fromRGBO(redBucket ~/ pixelCount,
  //       greenBucket ~/ pixelCount, blueBucket ~/ pixelCount, 1);
  // }

  static Widget getSpace(double space) {
    return SizedBox(
      height: space,
    );
  }

  static Widget getLargeBoldTextWithMaxLine(
      String text, Color color, int maxLine) {
    return Text(
      text,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: largeTextSize,
          color: color,
          fontFamily: ConstantData.fontFamily,
          fontWeight: FontWeight.w600),
      maxLines: maxLine,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
    );
  }

  static Widget getAppBarText(String s) {
    return ConstantWidget.getCustomTextWithoutAlign(
        s, ConstantData.textColor1, FontWeight.bold, ConstantData.font18Px);
    // return       ConstantWidget.getCustomTextWithoutAlign(S.of(context).checkOut, ConstantData.textColor, FontWeight.bold, ConstantData.font18Px),
  }

  static Widget getAppBarIcon() {
    return Icon(
      Icons.arrow_back_ios_sharp,
      color: ConstantData.textColor1,
    );
    // return       ConstantWidget.getCustomTextWithoutAlign(S.of(context).checkOut, ConstantData.textColor, FontWeight.bold, ConstantData.font18Px),
  }

  static Widget getRoundCornerButton(String texts, Color color, Color textColor,
      IconData icons, double btnRadius, Function function) {
    return InkWell(
      child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: new BorderRadius.circular(btnRadius),
          ),
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              getCustomText(
                  texts, textColor, 1, TextAlign.center, FontWeight.w400, 18),
              SizedBox(
                width: 15,
              ),
              Icon(
                icons,
                size: 25,
                color: textColor,
              )
              // Icon(
              //
              //   icons,
              //   size: 25,
              //   color: textColor,
              // )
            ],
          )),
      onTap: () {
        function();
      },
    );
  }

  static Widget getRoundCornerBorderButton(String texts, Color color,
      Color borderColor, Color textColor, double btnRadius, Function function) {
    return InkWell(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: new BorderRadius.circular(btnRadius),
            border: Border.all(color: borderColor, width: 1),
          ),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              getCustomText(
                  texts, textColor, 1, TextAlign.center, FontWeight.w500, 18),
              // Icon(
              //
              //   icons,
              //   size: 25,
              //   color: textColor,
              // )
            ],
          )),
      onTap: () {
        function();
      },
    );
  }
}
