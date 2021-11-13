import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_pos/main.dart';
import 'package:flutter_pos/model/app-config.dart';
import 'package:flutter_pos/model/category_model.dart';
import 'package:flutter_pos/screens/account/AuctionPolicy.dart';
import 'package:flutter_pos/screens/account/Conditions.dart';
import 'package:flutter_pos/screens/account/OrderHistory.dart';
import 'package:flutter_pos/screens/account/Policy.dart';
import 'package:flutter_pos/screens/account/infoPage.dart';
import 'package:flutter_pos/screens/account/login.dart';
import 'package:flutter_pos/screens/account/return.dart';
import 'package:flutter_pos/screens/account/user_information.dart';
import 'package:flutter_pos/screens/account/vendor_information.dart';
import 'package:flutter_pos/screens/account/wishlist_page.dart';
import 'package:flutter_pos/screens/homepage.dart';
import 'package:flutter_pos/screens/main_home/subcategory.dart';
import 'package:flutter_pos/screens/pages/about_us.dart';
import 'package:flutter_pos/screens/product/products_page.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/item_hidden_menu.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class HiddenMenu extends StatefulWidget {
  @override
  _HiddenMenuState createState() => _HiddenMenuState();
}

class _HiddenMenuState extends State<HiddenMenu> {
  bool isconfiguredListern = false;
  int id;
  String username, name, email, phone;
  String am_pm;

  @override
  void initState() {
    am_pm = new DateFormat('a').format(new DateTime.now());
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        id = prefs.getInt('user_id');
        name = prefs.getString('user_name');
        email = prefs.getString('user_email');
        phone = prefs.getString('phone');
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    final themeData = Provider.of<Provider_Data>(context);
    var size = MediaQuery.of(context).size;
    return Drawer(
      child: Container(
        // color: Colors.blueAccent,
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
          SizedBox(
            height: ScreenUtil.getHeight(context) / 15,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: ListTile(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    height: size.height * .2,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (scroll) {
                scroll.disallowGlow();
                return false;
              },
              child: Column(
                children: <Widget>[
                  AutoSizeText(
                    name == null
                        ? "${getTransrlate(context, 'gust')}"
                        : "${getTransrlate(context, 'gust')} $name",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black54,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  !themeColor.isLogin
                      ? ItemHiddenMenu(
                          onTap: () async {
                            themeColor.setLogin(false);
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.clear();
                            themeColor.isLogin
                                ? Nav.routeReplacement(context, Home())
                                : Nav.route(context, LoginPage());
                          },
                          icon: Icon(
                            Icons.exit_to_app,
                            size: 19,
                            color: themeColor.getColor(),
                          ),
                          name: themeColor.isLogin
                              ? getTransrlate(context, 'Logout')
                              : getTransrlate(context, 'login'),
                          baseStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 19.0,
                              fontWeight: FontWeight.w800),
                          colorLineSelected: themeColor.getColor(),
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
                              name: getTransrlate(context, 'ProfileSettings'),
                              baseStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.w800),
                              colorLineSelected: themeColor.getColor(),
                            ),
                            ItemHiddenMenu(
                              onTap: () {
                                Nav.route(context, OrderHistory());
                              },
                              icon: Icon(
                                Icons.local_shipping_outlined,
                                size: 25,
                                color: themeColor.getColor(),
                              ),
                              name: getTransrlate(context, 'Myorders'),
                              baseStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.w800),
                              colorLineSelected: themeColor.getColor(),
                            ),
                            ItemHiddenMenu(
                              onTap: () {
                                Nav.route(context, WishList());
                              },
                              icon: Icon(
                                Icons.favorite_border,
                                size: 25,
                                color: themeColor.getColor(),
                              ),
                              name: getTransrlate(context, 'MyFav'),
                              baseStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.w800),
                              colorLineSelected: themeColor.getColor(),
                            ),
                          ],
                        ),
                  // ItemHiddenMenu(
                  //   onTap: () {
                  //     Nav.route(context,
                  //         VendorInfo('https://qafeer.net/user/view-login'));
                  //   },
                  //   icon: SvgPicture.asset(
                  //     'assets/icons/store.svg',
                  //     height: 25,
                  //     color: themeColor.getColor(),
                  //   ),
                  //   name: getTransrlate(context, 'vendorRegister'),
                  //   baseStyle: TextStyle(
                  //       color: Colors.black,
                  //       fontSize: 19.0,
                  //       fontWeight: FontWeight.w800),
                  //   colorLineSelected: themeColor.getColor(),
                  // ),
                  themeData.categories == null
                      ? Container()
                      : ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          padding: EdgeInsets.all(1),
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: themeData.categories.length,
                          itemBuilder: (BuildContext context, int index) {
                            return themeData.categories[index].subs == null
                                ? ItemHiddenMenu(
                                    onTap: () {
                                      print("cccccccccccccc");
                                      themeData.categories[index].id != 20
                                          ? Nav.route(
                                              context,
                                              Products_Page(
                                                id: themeData
                                                    .categories[index].id,
                                                name: themeColor.getlocal() ==
                                                        'ar'
                                                    ? themeData
                                                        .categories[index]
                                                        .nameAr
                                                    : themeData
                                                        .categories[index].name,
                                                Url:
                                                    "products/category/${themeData.categories[index].id}",
                                              ))
                                          : Nav.route(
                                              context,
                                              Subcategory(
                                                themeColor.getlocal() == 'ar'
                                                    ? themeData
                                                        .categories[index]
                                                        .nameAr
                                                    : themeData
                                                        .categories[index].name,
                                                themeData
                                                    .categories[index].subs,
                                              ));
                                    },
                                    icon: Container(
                                        width:
                                            ScreenUtil.getWidth(context) / 10,
                                        height:
                                            ScreenUtil.getHeight(context) / 20,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.white, width: 1)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: CachedNetworkImage(
                                              imageUrl:
                                                  "${AppConfig.BASE_PATH}categories/${themeData.categories[index].photo}",
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Image.asset(
                                                      "assets/images/logo.png",
                                                      color: Colors.grey)),
                                        )),
                                    name:
                                        "${themeColor.getlocal() == 'ar' ? themeData.categories[index].nameAr : themeData.categories[index].name}",
                                    baseStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.w800),
                                    colorLineSelected: themeColor.getColor(),
                                  )
                                : themeData.categories[index].subs.isEmpty
                                    ? ItemHiddenMenu(
                                        onTap: () {
                                          themeData.categories[index].id != 20
                                              ? Nav.route(
                                                  context,
                                                  Products_Page(
                                                    id: themeData
                                                        .categories[index].id,
                                                    name: themeColor
                                                                .getlocal() ==
                                                            'ar'
                                                        ? themeData
                                                            .categories[index]
                                                            .nameAr
                                                        : themeData
                                                            .categories[index]
                                                            .name,
                                                    Url:
                                                        "products/category/${themeData.categories[index].id}",
                                                  ))
                                              : Nav.route(
                                                  context,
                                                  Subcategory(
                                                    themeColor.getlocal() ==
                                                            'ar'
                                                        ? themeData
                                                            .categories[index]
                                                            .nameAr
                                                        : themeData
                                                            .categories[index]
                                                            .name,
                                                    themeData
                                                        .categories[index].subs,
                                                  ));
                                        },
                                        icon: Container(
                                            width:
                                                ScreenUtil.getWidth(context) /
                                                    10,
                                            height:
                                                ScreenUtil.getHeight(context) /
                                                    20,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 1)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: CachedNetworkImage(
                                                  imageUrl:
                                                      "${AppConfig.BASE_PATH}categories/${themeData.categories[index].photo}",
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Image.asset(
                                                          "assets/images/logo.png",
                                                          color: Colors.grey)),
                                            )),
                                        name:
                                            "${themeColor.getlocal() == 'ar' ? themeData.categories[index].nameAr : themeData.categories[index].name}",
                                        baseStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 19.0,
                                            fontWeight: FontWeight.w800),
                                        colorLineSelected:
                                            themeColor.getColor(),
                                      )
                                    : ExpandablePanel(
                                        header: ItemHiddenMenu(
                                          onTap: () {
                                            themeData.categories[index].id != 20
                                                ? Nav.route(
                                                    context,
                                                    Products_Page(
                                                      id: themeData
                                                          .categories[index].id,
                                                      name: themeColor
                                                                  .getlocal() ==
                                                              'ar'
                                                          ? themeData
                                                              .categories[index]
                                                              .nameAr
                                                          : themeData
                                                              .categories[index]
                                                              .name,
                                                      Url:
                                                          "products/category/${themeData.categories[index].id}",
                                                    ))
                                                : Nav.route(
                                                    context,
                                                    Subcategory(
                                                      themeColor.getlocal() ==
                                                              'ar'
                                                          ? themeData
                                                              .categories[index]
                                                              .nameAr
                                                          : themeData
                                                              .categories[index]
                                                              .name,
                                                      themeData
                                                          .categories[index]
                                                          .subs,
                                                    ));
                                          },
                                          icon: Container(
                                              width:
                                                  ScreenUtil.getWidth(context) /
                                                      10,
                                              height: ScreenUtil.getHeight(
                                                      context) /
                                                  20,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 1)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: CachedNetworkImage(
                                                    imageUrl:
                                                        "${AppConfig.BASE_PATH}categories/${themeData.categories[index].photo}",
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Image.asset(
                                                            "assets/images/logo.png",
                                                            color:
                                                                Colors.grey)),
                                              )),
                                          name:
                                              "${themeColor.getlocal() == 'ar' ? themeData.categories[index].nameAr : themeData.categories[index].name}",
                                          baseStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 19.0,
                                              fontWeight: FontWeight.w800),
                                          colorLineSelected:
                                              themeColor.getColor(),
                                        ),
                                        expanded: themeData
                                                    .categories[index].subs ==
                                                null
                                            ? Container()
                                            : ListView.builder(
                                                primary: false,
                                                shrinkWrap: true,
                                                padding: EdgeInsets.all(1),
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: themeData
                                                    .categories[index]
                                                    .subs
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int ind) {
                                                  return ItemHiddenMenu(
                                                    onTap: () {
                                                      themeData
                                                                  .categories[
                                                                      index]
                                                                  .id !=
                                                              20
                                                          ? Nav.route(
                                                              context,
                                                              Products_Page(
                                                                id: themeData
                                                                    .categories[
                                                                        index]
                                                                    .subs[ind]
                                                                    .id,
                                                                name: themeColor
                                                                            .getlocal() ==
                                                                        'ar'
                                                                    ? themeData
                                                                        .categories[
                                                                            index]
                                                                        .subs[
                                                                            ind]
                                                                        .nameAr
                                                                    : themeData
                                                                        .categories[
                                                                            index]
                                                                        .subs[
                                                                            ind]
                                                                        .name,
                                                                Url:
                                                                    "products/subcategory/${themeData.categories[index].subs[ind].id}",
                                                              ))
                                                          : Nav.route(
                                                              context,
                                                              Subcategory(
                                                                themeColor.getlocal() ==
                                                                        'ar'
                                                                    ? themeData
                                                                        .categories[
                                                                            index]
                                                                        .subs[
                                                                            ind]
                                                                        .nameAr
                                                                    : themeData
                                                                        .categories[
                                                                            index]
                                                                        .subs[
                                                                            ind]
                                                                        .name,
                                                                themeData
                                                                    .categories[
                                                                        index]
                                                                    .subs,
                                                              ));
                                                    },
                                                    name:
                                                        "${themeColor.getlocal() == 'ar' ? themeData.categories[index].subs[ind].nameAr : themeData.categories[index].subs[ind].name}",
                                                    baseStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 19.0,
                                                        fontWeight:
                                                            FontWeight.w800),
                                                    colorLineSelected:
                                                        themeColor.getColor(),
                                                  );
                                                }),
                                      );
                          }),
                  InkWell(
                    onTap: () {
                      Nav.route(context, Contact());
                    },
                    child: ItemHiddenMenu(
                      icon: Icon(
                        Icons.call,
                        size: 25,
                        color: themeColor.getColor(),
                      ),
                      name: getTransrlate(context, 'contact'),
                      baseStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 19.0,
                          fontWeight: FontWeight.w800),
                      colorLineSelected: themeColor.getColor(),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Nav.route(context, Return());
                    },
                    child: ItemHiddenMenu(
                      icon: Icon(
                        Icons.reply,
                        size: 25,
                        color: themeColor.getColor(),
                      ),
                      name: getTransrlate(context, 'return'),
                      baseStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 19.0,
                          fontWeight: FontWeight.w800),
                      colorLineSelected: themeColor.getColor(),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Nav.route(context, Conditions());
                    },
                    child: ItemHiddenMenu(
                      icon: Icon(
                        Icons.content_paste,
                        size: 25,
                        color: themeColor.getColor(),
                      ),
                      name: getTransrlate(context, 'Conditions'),
                      baseStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 19.0,
                          fontWeight: FontWeight.w800),
                      colorLineSelected: themeColor.getColor(),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Nav.route(context, Policy());
                    },
                    child: ItemHiddenMenu(
                      icon: Icon(
                        Icons.policy,
                        size: 25,
                        color: themeColor.getColor(),
                      ),
                      name: getTransrlate(context, 'Support'),
                      baseStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 19.0,
                          fontWeight: FontWeight.w800),
                      colorLineSelected: themeColor.getColor(),
                    ),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     Nav.route(context, AboutUs());
                  //   },
                  //   child: ItemHiddenMenu(
                  //     icon: Icon(
                  //       Icons.info,
                  //       size: 25,
                  //       color: themeColor.getColor(),
                  //     ),
                  //     name: getTransrlate(context, 'About'),
                  //     baseStyle: TextStyle(
                  //         color: Colors.black,
                  //         fontSize: 19.0,
                  //         fontWeight: FontWeight.w800),
                  //     colorLineSelected: themeColor.getColor(),
                  //   ),
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     Nav.route(context, AuctionPolicy());
                  //   },
                  //   child: ItemHiddenMenu(
                  //     icon: Icon(
                  //       Icons.policy_outlined,
                  //       size: 25,
                  //       color: themeColor.getColor(),
                  //     ),
                  //     name: getTransrlate(context, 'AuctionPolicy'),
                  //     baseStyle: TextStyle(
                  //         color: Colors.black,
                  //         fontSize: 19.0,
                  //         fontWeight: FontWeight.w800),
                  //     colorLineSelected: themeColor.getColor(),
                  //   ),
                  // ),
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
                      // Phoenix.rebirth(context);
                    },
                    child: ItemHiddenMenu(
                      icon: Icon(
                        Icons.language,
                        size: 25,
                        color: themeColor.getColor(),
                      ),
                      name: Provider.of<Provider_control>(context).local == 'ar'
                          ? 'English'
                          : 'عربى',
                      baseStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 19.0,
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
                            themeColor.isLogin
                                ? Nav.routeReplacement(context, Home())
                                : Nav.route(context, LoginPage());
                          },
                          icon: Icon(
                            Icons.exit_to_app,
                            size: 19,
                            color: themeColor.getColor(),
                          ),
                          name: themeColor.isLogin
                              ? getTransrlate(context, 'Logout')
                              : getTransrlate(context, 'login'),
                          baseStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 19.0,
                              fontWeight: FontWeight.w800),
                          colorLineSelected: themeColor.getColor(),
                        )
                      : Container(),
                  Container(
                      height: 28,
                      margin: EdgeInsets.only(left: 24, right: 48),
                      child: Divider(
                        color: Colors.white.withOpacity(0.5),
                      )),
                ],
              ),
            ),
          ),
        ])),
      ),
    );
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
