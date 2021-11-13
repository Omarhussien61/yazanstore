import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/app-config.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/model/wishlist_model.dart';
import 'package:flutter_pos/screens/product/ProductPage.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/no_found_product.dart';
import 'package:flutter_pos/widget/not_login.dart';
import 'package:flutter_pos/widget/product/Wish_List_item.dart';
import 'package:flutter_pos/widget/product/product_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishList extends StatefulWidget {
  const WishList({Key key}) : super(key: key);

  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  List<Wishlist> wishList;
  int checkboxValue;
  int id;

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        id = prefs.getInt('user_id');
      });
    });
    getwWISHlIST();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          children: [
            Icon(
              Icons.favorite_border,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Container(
                width: ScreenUtil.getWidth(context) / 2,
                child: AutoSizeText(
                  getTransrlate(context, 'MyFav'),
                  minFontSize: 10,
                  maxFontSize: 16,
                  maxLines: 1,
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
      body: !themeColor.isLogin
          ? Notlogin()
          : Container(
              child: wishList == null
                  ? Center(child: Custom_Loading())
                  : wishList.isEmpty
                      ? Center(child: NotFoundProduct())
                      : SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: wishList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Nav.route(
                                        context,
                                        ProductPage(
                                          product: wishList[index].product,
                                        ));
                                  },
                                  child: SizedBox(
                                    width: ScreenUtil.getWidth(context),
                                    child: Card(
                                      //clipBehavior: Clip.antiAliasWithSaveLayer,

                                      shape: RoundedRectangleBorder(
                                        side: new BorderSide(
                                            color: Colors.black12, width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      elevation: 0.0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                  width: ScreenUtil.getWidth(
                                                          context) /
                                                      5,
                                                  //height: 158,
                                                  height: ScreenUtil.getHeight(
                                                          context) /
                                                      9,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: ClipRRect(
                                                        clipBehavior:
                                                            Clip.hardEdge,
                                                        borderRadius:
                                                            BorderRadius.vertical(
                                                                top: Radius
                                                                    .circular(
                                                                        16),
                                                                bottom: Radius
                                                                    .zero),
                                                        child: FadeInImage
                                                            .assetNetwork(
                                                          placeholder:
                                                              'assets/load.gif',
                                                          image:
                                                              "${AppConfig.BASE_PATH}products/${wishList[index].product.photo}",
                                                          fit: BoxFit.cover,
                                                        )),
                                                  )),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              16, 0, 16, 0),
                                                      child: Text(
                                                        "${wishList[index].product.name}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: themeColor
                                                                .getColor(),
                                                            fontSize: ScreenUtil
                                                                .getTxtSz(
                                                                    context,
                                                                    14),
                                                            height: 1.6,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  16, 4, 16, 0),
                                                          child: Text(
                                                            "${wishList[index].product.price} ${getTransrlate(context, 'Currency')}",
                                                            textAlign:
                                                                TextAlign.left,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                fontSize: ScreenUtil
                                                                    .getTxtSz(
                                                                        context,
                                                                        17),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          IconButton(
                                                            onPressed: () {
                                                              if (id == null) {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder: (_) =>
                                                                        ResultOverlay(
                                                                            "${getTransrlate(context, 'notlogin')}"));
                                                              } else {
                                                                API(context).post(
                                                                    'carts/add',
                                                                    {
                                                                      "product_id": wishList[
                                                                              index]
                                                                          .product
                                                                          .id,
                                                                      "user_id":
                                                                          id,
                                                                      "quantity":
                                                                          1,
                                                                      "lang":
                                                                          "${themeColor.getlocal()}",
                                                                      "size_price":
                                                                          '0',
                                                                      "color":
                                                                          '0',
                                                                      "size":
                                                                          '0',
                                                                    }).then(
                                                                    (value) {
                                                                  print(value);

                                                                  if (value !=
                                                                      null) {
                                                                    if (value[
                                                                            'status_code'] ==
                                                                        200) {
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder: (_) =>
                                                                              ResultOverlay(value['message']));
                                                                      getwWISHlIST();
                                                                      Provider.of<Provider_Data>(
                                                                              context,
                                                                              listen:
                                                                                  false)
                                                                          .getData(
                                                                              context);
                                                                    } else {
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder: (_) =>
                                                                              ResultOverlay("${value['message']}"));
                                                                    }
                                                                  }
                                                                });
                                                              }
                                                            },
                                                            icon: Image.asset(
                                                              "assets/images/download.png",
                                                              color: themeColor
                                                                  .getColor(),
                                                              height: 20,
                                                            ),
                                                          ),
                                                          IconButton(
                                                              onPressed: () {
                                                                API(context).post(
                                                                    'wishlists/remove/${wishList[index].id}',
                                                                    {
                                                                      "lang":
                                                                          "${themeColor.getlocal()}",
                                                                    }).then(
                                                                    (value) {
                                                                  if (value !=
                                                                      null) {
                                                                    if (value[
                                                                            'status_code'] ==
                                                                        200) {
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder: (_) =>
                                                                              ResultOverlay(value['message']));
                                                                      getwWISHlIST();

                                                                      Provider.of<Provider_Data>(
                                                                              context,
                                                                              listen:
                                                                                  false)
                                                                          .getCart(
                                                                              context);
                                                                    } else {
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder: (_) =>
                                                                              ResultOverlay('${value['message'] ?? ''}'));
                                                                    }
                                                                  }
                                                                });
                                                              },
                                                              icon: Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.grey,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
            ),
    );
  }

  void getwWISHlIST() {
    SharedPreferences.getInstance().then((pref) {
      API(context).get('wishlists/${pref.getInt('user_id')}').then((value) {
        if (value != null) {
          setState(() {
            wishList = Wishlist_model.fromJson(value['data']['wishlists']).data;
          });
        }
      });
    });
  }
}
