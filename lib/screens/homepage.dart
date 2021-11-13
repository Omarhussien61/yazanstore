import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_pos/screens/account/Account.dart';
import 'package:flutter_pos/screens/filter.dart';
import 'package:flutter_pos/screens/gallary.dart';
import 'package:flutter_pos/screens/offers.dart';
import 'package:flutter_pos/screens/order/cart.dart';
import 'package:flutter_pos/screens/product/category.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/SearchOverlay.dart';

import 'package:flutter_pos/widget/hidden_menu.dart';

import 'package:provider/provider.dart';

import 'home.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int checkboxType = 0;
  int _currentIndex = 0;

  void onTapped(int i) {
    setState(() {
      _currentIndex = i;
    });
  }

  int complete;
  var _children = [
    HomePage(),
    Offers(),
    CategoryScreen(),
    CartScreen(),
    Account()
  ];

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    final themeData = Provider.of<Provider_Data>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom ==
            0.0, // if the kyeboard is open then hide, else show
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {},
          tooltip: "start FAB",
          child: Container(
              margin: EdgeInsets.all(8.0),
              child: IconButton(
                  icon: new Image.asset('assets/images/logo.png'),
                  tooltip: 'Action',
                  onPressed: () {
                    Nav.route(context, Gallaries());
                  })),
          elevation: 0.0,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: onTapped,
            currentIndex: _currentIndex,
            backgroundColor: Colors.white.withOpacity(0.8),
            fixedColor: themeColor.getColor(),
            unselectedItemColor: Color.fromRGBO(153, 153, 153, 1),
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/images/home.png",
                    color: _currentIndex == 0
                        ? themeColor.getColor()
                        : Color.fromRGBO(153, 153, 153, 1),
                    height: ScreenUtil.setHeight(context, .028),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      getTransrlate(context, 'home'),
                      style:
                          TextStyle(fontSize: ScreenUtil.getTxtSz(context, 12)),
                    ),
                  )),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/images/bell.png",
                    color: _currentIndex == 1
                        ? themeColor.getColor()
                        : Color.fromRGBO(153, 153, 153, 1),
                    height: ScreenUtil.setHeight(context, .028),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      getTransrlate(context, "offers"),
                      style:
                          TextStyle(fontSize: ScreenUtil.getTxtSz(context, 12)),
                    ),
                  )),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.circle,
                  color: Colors.transparent,
                ),
                title: Text(""),
              ),
              BottomNavigationBarItem(
                  icon: Container(
                    width: ScreenUtil.setWidth(context, .1),
                    height: ScreenUtil.setHeight(context, .028),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 1,
                          child: Image.asset(
                            "assets/images/download.png",
                            color: _currentIndex == 3
                                ? themeColor.getColor()
                                : Color.fromRGBO(153, 153, 153, 1),
                            height: ScreenUtil.setHeight(context, .028),
                            width: ScreenUtil.setWidth(context, .1),
                          ),
                        ),
                        themeData.cart_model == null
                            ? Container()
                            : themeData.cart_model.data == null
                                ? Container()
                                : themeData.cart_model.data.isEmpty
                                    ? Container()
                                    : Positioned(
                                        top: 1,
                                        left: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: themeColor.getColor(),
                                            borderRadius:
                                                BorderRadius.circular(90),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              "${themeData.cart_model == null ? '' : themeData.cart_model.data.length == 0 ? '' : themeData.cart_model.data.length}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: ScreenUtil.getTxtSz(
                                                      context, 10)),
                                            ),
                                          ),
                                        ))
                      ],
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      getTransrlate(context, "cart"),
                      style:
                          TextStyle(fontSize: ScreenUtil.getTxtSz(context, 12)),
                    ),
                  )),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/images/profile.png",
                    color: _currentIndex == 4
                        ? themeColor.getColor()
                        : Color.fromRGBO(153, 153, 153, 1),
                    height: ScreenUtil.setHeight(context, .028),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      getTransrlate(context, "profile"),
                      style:
                          TextStyle(fontSize: ScreenUtil.getTxtSz(context, 12)),
                    ),
                  )),
            ],
          ),
        ),
      ),
      body: _children[_currentIndex],
    );
  }
}
