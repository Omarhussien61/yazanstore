import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/model/app-config.dart';
import 'package:flutter_pos/screens/homepage.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen();
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Provider_control themeColor;
  Provider_Data _provider_data;
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => _auth());
  }

  @override
  Widget build(BuildContext context) {
    themeColor = Provider.of<Provider_control>(context);
    _provider_data = Provider.of<Provider_Data>(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: themeColor.getColor(),
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(50),
            color: Colors.white,
            height: ScreenUtil.getHeight(context),
            width: ScreenUtil.getWidth(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                  height: size.height * .25,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'مرحباً بكم في متجر يزن',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff2FB7EC),
                      fontSize: ScreenUtil.getTxtSz(context, 19),
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _auth() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt("user_id") != null) {
      print(prefs.getInt("user_id"));
      themeColor.setLogin(true);
    } else {
      themeColor.setLogin(false);
    }
    Nav.routeReplacement(context, Home());
  }
}
