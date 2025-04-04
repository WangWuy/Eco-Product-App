
// ignore_for_file: deprecated_member_use

import 'package:eco_product_ui_updated/generated/l10n.dart';
import 'package:eco_product_ui_updated/utils/ConstantData.dart';
import 'package:eco_product_ui_updated/utils/ConstantWidget.dart';
import 'package:eco_product_ui_updated/utils/CustomDialogBox.dart';
import 'package:eco_product_ui_updated/utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import 'WidgetNotificationConfirmation.dart';

class WidgetMobileVerification extends StatefulWidget {
  @override
  _WidgetMobileVerification createState() => _WidgetMobileVerification();
}

class _WidgetMobileVerification extends State<WidgetMobileVerification> {
  void finish() {
    Navigator.of(context).pop();
  }

  final GlobalKey<FormFieldState<String>> _formKey =
      GlobalKey<FormFieldState<String>>(debugLabel: '_formkey');
  TextEditingController _pinEditingController =
      TextEditingController(text: '123');
  bool _enable = true;
  bool _solidEnable = true;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ConstantWidget.getSpace(SizeConfig.safeBlockVertical!*20),
                  ConstantWidget.getLargeBoldTextWithMaxLine(
                      S.of(context).verify, Colors.black87, 1),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 3,
                  ),
                  Container(
                    width: SizeConfig.safeBlockHorizontal! * 70,
                    child: PinInputTextFormField(
                      key: _formKey,
                      pinLength: 4,
                      decoration: new CirclePinDecoration(
                        bgColorBuilder: _solidEnable
                            ? PinListenColorBuilder(ConstantData.primaryColor, Colors.grey)
                            : null,
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: ConstantData.fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        strokeColorBuilder:
                            PinListenColorBuilder(ConstantData.primaryColor, Colors.grey),
                        obscureStyle: ObscureStyle(
                          isTextObscure: false,
                          obscureText: '🤪',
                        ),
                        // hintText: _kDefaultHint,
                      ),
                      controller: _pinEditingController,
                      textInputAction: TextInputAction.go,
                      enabled: _enable,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.characters,
                      onSubmit: (pin) {
                        print("gtepin===$pin");
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }
                      },
                      onChanged: (pin) {
                        setState(() {
                          debugPrint('onChanged execute. pin:$pin');
                        });
                      },
                      onSaved: (pin) {
                        debugPrint('onSaved pin:$pin');
                      },
                      validator: (pin) {
                        if (pin!.isEmpty) {
                          setState(() {
                            // _hasError = true;
                          });
                          return 'Pin cannot empty.';
                        }
                        setState(() {
                          // _hasError = false;
                        });
                        return null;
                      },
                      cursor: Cursor(
                        width: 2,
                        color: Colors.white,
                        radius: Radius.circular(1),
                        enabled: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 3,
                  ),

                  ConstantWidget.getCustomText(
                      "We texted you a code to verify\nyour phone number",
                      Colors.black54,
                      2,
                      TextAlign.center,
                      FontWeight.w400,
                      15),
                  // getCustomText("Your mobile number", Colors.black87, 1,
                  SizedBox(
                    height: 15,
                  ),
                  ConstantWidget.getCustomText("Didn't receive code?", Colors.black, 2,
                      TextAlign.center, FontWeight.w500, 18),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ConstantWidget.getRoundCornerBorderButton(S.of(context).resend,
                        Colors.white, Colors.black, Colors.black, 25.0, () {}),
                  ),
                  Expanded(
                    child: SizedBox(),
                    flex: 1,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ConstantWidget.getRoundCornerButton(
                        S.of(context).next,
                         ConstantData.primaryColor,
                        Colors.white,
                        Icons.arrow_forward_rounded,
                        22.0, () {
                      //

                      showDialog(context: context,
                          builder: (BuildContext context){
                            return CustomDialogBox(
                              title: "Account Created!",
                              descriptions: "Your account has\nbeen successfully created!",
                              text: "Continue",
                              func: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WidgetNotificationConfirmation(),
                                    ));
                              },
                            );
                          }
                      );

                    }),
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          finish();
          return true;
        });
  }
}
