import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_pos/main.dart';
import 'package:flutter_pos/screens/address/Address_Page.dart';
import 'package:flutter_pos/screens/account/OrderHistory.dart';
import 'package:flutter_pos/screens/account/infoPage.dart';
import 'package:flutter_pos/screens/account/login.dart';
import 'package:flutter_pos/screens/account/user_information.dart';
import 'package:flutter_pos/screens/account/vendor_information.dart';
import 'package:flutter_pos/screens/homepage.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/SearchOverlay.dart';
import 'package:flutter_pos/widget/app_bar_custom.dart';
import 'package:flutter_pos/widget/item_hidden_menu.dart';
import 'package:flutter_pos/screens/account/wishlist_page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Account extends StatefulWidget {
  const Account({Key key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String name;
  String token;
  String vendor;

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        name = prefs.getString('user_name');
        print(prefs.getInt("user_id"));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    final _cart_model = Provider.of<Provider_Data>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarCustom(),
          themeColor.isLogin
              ? Container(
                  width: ScreenUtil.getWidth(context),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2.0,
                        spreadRadius: 1,
                        offset: Offset(0.0, 1)),
                  ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: AutoSizeText(
                          name == null
                              ? getTransrlate(context, 'gust')
                              : "${getTransrlate(context, 'gust')} : ${name}",
                          style: TextStyle(
                              fontSize: ScreenUtil.getTxtSz(context, 24),
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 16, left: 16),
                            child: NotificationListener<
                                OverscrollIndicatorNotification>(
                              onNotification: (scroll) {
                                scroll.disallowGlow();
                                return false;
                              },
                              child: Column(
                                children: <Widget>[
                                  ResponsiveGridList(
                                      desiredItemWidth:
                                          ScreenUtil.getWidth(context) / 2.4,
                                      minSpacing: 10,
                                      //rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      scroll: false,
                                      children: [
                                        Card(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  width: ScreenUtil.getWidth(
                                                          context) /
                                                      4.5,
                                                  child: Text(
                                                      '${getTransrlate(context, 'DisplayPromotions')}',
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                        color: themeColor
                                                            .getColor(),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            ScreenUtil.getTxtSz(
                                                                context, 14),
                                                      )),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: SvgPicture.asset(
                                                  "assets/icons/1611137442over.6dc8070d.svg",
                                                  height: ScreenUtil.setHeight(
                                                      context, .04),
                                                  width: ScreenUtil.setWidth(
                                                      context, .15),
                                                  color: themeColor.getColor(),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Card(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  width: ScreenUtil.getWidth(
                                                          context) /
                                                      4.5,
                                                  child: Text(
                                                      '${getTransrlate(context, 'PermanentOffers')}',
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                        color: themeColor
                                                            .getColor(),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            ScreenUtil.getTxtSz(
                                                                context, 14),
                                                      )),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: SvgPicture.asset(
                                                  "assets/icons/1611137475over2.143c236a.svg",
                                                  height: ScreenUtil.setHeight(
                                                      context, .04),
                                                  width: ScreenUtil.setWidth(
                                                      context, .15),
                                                  color: themeColor.getColor(),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Card(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  width: ScreenUtil.getWidth(
                                                          context) /
                                                      4.5,
                                                  child: Text(
                                                      '${getTransrlate(context, 'DeliveryServices')}',
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                        color: themeColor
                                                            .getColor(),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            ScreenUtil.getTxtSz(
                                                                context, 14),
                                                      )),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: SvgPicture.asset(
                                                  "assets/icons/1611137512over3.c14b4620.svg",
                                                  color: themeColor.getColor(),
                                                  height: ScreenUtil.setHeight(
                                                      context, .04),
                                                  width: ScreenUtil.setWidth(
                                                      context, .15),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Card(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  width: ScreenUtil.getWidth(
                                                          context) /
                                                      4.5,
                                                  child: Text(
                                                      '${getTransrlate(context, 'HelpCenter')}',
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                        color: themeColor
                                                            .getColor(),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            ScreenUtil.getTxtSz(
                                                                context, 14),
                                                      )),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: SvgPicture.asset(
                                                  "assets/icons/1611137556over4.350c9104.svg",
                                                  height: ScreenUtil.setHeight(
                                                      context, .04),
                                                  width: ScreenUtil.setWidth(
                                                      context, .15),
                                                  color: themeColor.getColor(),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ]),
                                  !themeColor.isLogin
                                      ? ItemHiddenMenu(
                                          onTap: () async {
                                            themeColor.setLogin(false);
                                            final SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefs.clear();
                                            themeColor.isLogin
                                                ? Nav.routeReplacement(
                                                    context, Home())
                                                : Nav.route(
                                                    context, LoginPage());
                                          },
                                          icon: Icon(
                                            Icons.exit_to_app,
                                            size: ScreenUtil.getTxtSz(
                                                context, 23),
                                            color: themeColor.getColor(),
                                          ),
                                          name: themeColor.isLogin
                                              ? getTransrlate(context, 'Logout')
                                              : getTransrlate(context, 'login'),
                                          baseStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: ScreenUtil.getTxtSz(
                                                  context, 22),
                                              fontWeight: FontWeight.w800),
                                          colorLineSelected:
                                              themeColor.getColor(),
                                        )
                                      : Column(
                                          children: [
                                            ItemHiddenMenu(
                                              onTap: () {
                                                Nav.route(context, UserInfo());
                                              },
                                              icon: SvgPicture.asset(
                                                'assets/icons/account.svg',
                                                color: themeColor.getColor(),
                                              ),
                                              name: getTransrlate(
                                                  context, 'ProfileSettings'),
                                              baseStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: ScreenUtil.getTxtSz(
                                                      context, 23),
                                                  fontWeight: FontWeight.w800),
                                              colorLineSelected:
                                                  themeColor.getColor(),
                                            ),
                                            ItemHiddenMenu(
                                              onTap: () {
                                                Nav.route(
                                                    context, OrderHistory());
                                              },
                                              icon: Icon(
                                                Icons.local_shipping_outlined,
                                                size: ScreenUtil.getTxtSz(
                                                    context, 30),
                                                color: themeColor.getColor(),
                                              ),
                                              name: getTransrlate(
                                                  context, 'Myorders'),
                                              baseStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: ScreenUtil.getTxtSz(
                                                      context, 23),
                                                  fontWeight: FontWeight.w800),
                                              colorLineSelected:
                                                  themeColor.getColor(),
                                            ),
                                            ItemHiddenMenu(
                                              onTap: () {
                                                Nav.route(context, WishList());
                                              },
                                              icon: Icon(
                                                Icons.favorite_border,
                                                size: ScreenUtil.getTxtSz(
                                                    context, 30),
                                                color: themeColor.getColor(),
                                              ),
                                              name: getTransrlate(
                                                  context, 'MyFav'),
                                              baseStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: ScreenUtil.getTxtSz(
                                                      context, 23),
                                                  fontWeight: FontWeight.w800),
                                              colorLineSelected:
                                                  themeColor.getColor(),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    color: Color(0xffF6F6F6),
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            await themeColor.local == 'ar'
                                ? themeColor.setLocal('en')
                                : themeColor.setLocal('ar');
                            MyApp.setlocal(
                                context, Locale(themeColor.getlocal(), ''));
                            SharedPreferences.getInstance().then((prefs) {
                              prefs.setString('local', themeColor.local);
                            });
                            Phoenix.rebirth(context);
                          },
                          child: ItemHiddenMenu(
                            icon: Icon(
                              Icons.language,
                              size: ScreenUtil.getTxtSz(context, 30),
                              color: themeColor.getColor(),
                            ),
                            name:
                                Provider.of<Provider_control>(context).local ==
                                        'ar'
                                    ? 'English'
                                    : 'عربى',
                            baseStyle: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenUtil.getTxtSz(context, 23),
                                fontWeight: FontWeight.w800),
                            colorLineSelected: themeColor.getColor(),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Nav.route(context, Contact());
                          },
                          child: ItemHiddenMenu(
                            icon: Icon(
                              Icons.help_outline_rounded,
                              size: ScreenUtil.getTxtSz(context, 30),
                              color: themeColor.getColor(),
                            ),
                            name: getTransrlate(context, 'contact'),
                            baseStyle: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenUtil.getTxtSz(context, 23),
                                fontWeight: FontWeight.w800),
                            colorLineSelected: themeColor.getColor(),
                          ),
                        ),
                        themeColor.isLogin
                            ? ItemHiddenMenu(
                                onTap: () async {
                                  themeColor.setLogin(false);
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.clear();
                                  fb.FirebaseAuth.instance.signOut();
                                  themeColor.isLogin
                                      ? Nav.routeReplacement(context, Home())
                                      : Nav.route(context, LoginPage());
                                },
                                icon: Icon(
                                  Icons.exit_to_app,
                                  size: ScreenUtil.getTxtSz(context, 23),
                                  color: themeColor.getColor(),
                                ),
                                name: themeColor.isLogin
                                    ? getTransrlate(context, 'Logout')
                                    : getTransrlate(context, 'login'),
                                baseStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: ScreenUtil.getTxtSz(context, 23),
                                    fontWeight: FontWeight.w800),
                                colorLineSelected: themeColor.getColor(),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
