// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:eco_product_ui_updated/providers/auth_provider.dart';
import 'package:eco_product_ui_updated/services/api_service.dart';
import 'package:eco_product_ui_updated/services/token_storage.dart';
import 'package:eco_product_ui_updated/utils/ConstantData.dart';
import 'package:eco_product_ui_updated/utils/ConstantWidget.dart';
import 'package:eco_product_ui_updated/utils/PrefData.dart';
import 'package:eco_product_ui_updated/utils/SizeConfig.dart';
import 'package:eco_product_ui_updated/widget/IntroPage.dart';
import 'package:eco_product_ui_updated/widget/my_widget/RegisterPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';
import 'widget/my_widget/LoginPage.dart';
import 'widget/TabWidget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final apiService = ApiService();
  final tokenStorage = TokenStorage();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            apiService: apiService,
            tokenStorage: tokenStorage,
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate
      ],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: ConstantData.primaryColor,
        primaryColorDark: ConstantData.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(surfaceTintColor: Colors.transparent),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: ConstantData.accentColor),
      ),
      home: MyHomePage(
        title: "title",
        isNotSplash: false,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String? title;

  final bool? isNotSplash;

  MyHomePage({this.title, this.isNotSplash});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    signInValue();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
        child: Scaffold(
            backgroundColor: ConstantData.bgColor,
            body: Container(
              child: getSignInWidget(),
            )),
        onWillPop: _requestPop);
  }

  Future<bool> _requestPop() {
    Future.delayed(const Duration(milliseconds: 200), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });

    return new Future.value(false);
  }

  bool _isSignIn = false;
  bool _isIntro = false;

  void signInValue() async {
    _isSignIn = await PrefData.getIsSignIn();
    _isIntro = await PrefData.getIsIntro();

    setState(() {});
    if (_isIntro) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => IntroPage(),
          ));
    } else if (_isSignIn) {
      print("isSignIn--" + _isSignIn.toString());
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => TabWidget(),
            ));
      });
    }
  }

  Widget getSignInWidget() {
    if (_isSignIn) {
      return splashPage();
    } else {
      return choosePage();
    }
  }

  Widget splashPage() {
    return Container(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: ExactAssetImage("assets/images/splash.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget choosePage() {
    double margin = MediaQuery.of(context).size.width * 0.03;
    double left = MediaQuery.of(context).size.width * 0.05;
    return Container(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: ExactAssetImage("assets/images/splash.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Expanded(
          //   child:
          Container(
            margin: EdgeInsets.only(bottom: margin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child: Container(
                      margin: EdgeInsets.only(
                          top: margin, bottom: margin, left: left, right: left),
                      height: 50,
                      decoration: BoxDecoration(
                          color: ConstantData.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: InkWell(
                        child: Center(
                          child: ConstantWidget.getCustomTextWithoutSize(
                              S.of(context).register,
                              Colors.white,
                              FontWeight.w900),
                        ),
                      )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                ),
                InkWell(
                  child: Container(
                      margin: EdgeInsets.only(
                          bottom: margin, left: left, right: left),
                      height: 50,
                      decoration: BoxDecoration(
                          color: ConstantData.whiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: InkWell(
                        child: Center(
                          child: ConstantWidget.getCustomTextWithFontSize(
                              S.of(context).login,
                              ConstantData.textColor,
                              ConstantData.font15Px,
                              FontWeight.w900),
                        ),
                      )),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
