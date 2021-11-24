import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/app-config.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/screens/order/cart.dart';
import 'package:flutter_pos/screens/product/ProductPage.dart';
import 'package:flutter_pos/screens/product/mazad_product.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/count_down_time.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ResultOverlay.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key key,
    @required this.themeColor,
    this.product,
  }) : super(key: key);

  final Provider_control themeColor;
  final Product product;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int id;
  double total = 0;
  double avg = 0;

  @override
  void initState() {
    if (widget.product.ratings != null) {
      widget.product.ratings.forEach((element) {
        total = total + element.rating;
      });
      setState(() {
        avg = total / widget.product.ratings.length;
        print('go = $avg');
      });
    }

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        id = prefs.getInt('user_id');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    final themeData = Provider.of<Provider_Data>(context);

    print((MediaQuery.of(context).size.width - 48) / 2);
    return Stack(
      children: [
        InkWell(
          onTap: () {
            if (widget.product.type != 'Mazad') {
              Nav.route(
                  context,
                  ProductPage(
                    product: widget.product,
                  ));
            } else {
              Nav.route(
                  context,
                  MazadProduct(
                    product: widget.product,
                  ));
            }
          },
          child: Container(
            decoration: new BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  color: Color(0xffeeeeee),
                  blurRadius: 20.0,
                ),
              ],
            ),
            child: Card(
              //clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                side: new BorderSide(color: Colors.black12, width: 1.0),
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 0.0,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        width: double.infinity,
                        //height: 158,

                        height: ScreenUtil.setHeight(context, .15),
                        child: ClipRRect(
                            clipBehavior: Clip.hardEdge,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16), bottom: Radius.zero),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/load.gif',
                              placeholderCacheHeight: 20,
                              image:
                                  "${AppConfig.BASE_PATH}products/${widget.product.photo}",
                              fit: BoxFit.contain,
                            ))),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Text(
                        "${themeColor.getlocal() == 'ar' ? widget.product.nameAr ?? widget.product.name : widget.product.name ?? widget.product.nameAr}",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            color: themeColor.getColor(),
                            fontSize: ScreenUtil.getTxtSz(context, 14),
                            height: 1.6,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 4, 16, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "${widget.product.price} ${getTransrlate(context, 'Currency')}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: ScreenUtil.getTxtSz(context, 12),
                                  fontWeight: FontWeight.w100),
                            ),
                          ),
                          RatingBar(
                            itemSize: ScreenUtil.getTxtSz(context, 13),
                            ignoreGestures: true,
                            initialRating: avg ?? 5.0,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            ratingWidget: RatingWidget(
                              full: Icon(Icons.star,
                                  color: themeColor.getColor()),
                              half: Icon(Icons.star_half,
                                  color: themeColor.getColor()),
                              empty: Icon(Icons.star,
                                  color: Color.fromRGBO(224, 224, 225, 1)),
                            ),
                            itemPadding: EdgeInsets.only(right: 1.0),
                            onRatingUpdate: (rating) {
                              //print(rating);
                            },
                          ),
                        ],
                      ),
                    ),
                    widget.product.Loading
                        ? Container(
                            height: ScreenUtil.setHeight(context, .1),
                            child: Center(
                                child: Image.asset(
                              'assets/load.gif',
                            )))
                        : Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: themeColor.getColor(),
                                            width: 1,
                                            style: BorderStyle.solid),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    color: themeColor.getColor(),
                                    onPressed: () {
                                      if (!themeColor.isLogin) {
                                        showDialog(
                                            context: context,
                                            builder: (_) => ResultOverlay(
                                                "${getTransrlate(context, 'notlogin')}"));
                                      } else {
                                        setState(() {
                                          widget.product.Loading = true;
                                        });
                                        API(context).post('carts/add', {
                                          "product_id": widget.product.id,
                                          "user_id": id,
                                          "lang": "${themeColor.getlocal()}",
                                          "quantity": 1,
                                          "size_price": '0',
                                          "color": '0',
                                          "size": '0',
                                        }).then((value) {
                                          setState(() {
                                            widget.product.Loading = false;
                                          });
                                          if (value != null) {
                                            if (value['status_code'] == 200) {
                                              themeData.getCart(context);
                                              showDialog(
                                                  context: context,
                                                  builder: (_) => ResultOverlay(
                                                      "${value['message']}"));
                                            } else {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) => ResultOverlay(
                                                      "${value['message']}"));
                                            }
                                          }
                                        });
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/download.png",
                                          color: Colors.white,
                                          scale: 1.8,
                                          height: ScreenUtil.setHeight(
                                              context, .035),
                                        ),
                                        SizedBox(width: 3),
                                        Text(
                                            '${getTransrlate(context, 'ADDtoCart')}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: ScreenUtil.getTxtSz(
                                                    context, 10))),
                                      ],
                                    )),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: FlatButton(
                                    color: themeColor.getColor(),
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: themeColor.getColor(),
                                            width: 1,
                                            style: BorderStyle.solid),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    onPressed: () {
                                      if (id == null) {
                                        showDialog(
                                            context: context,
                                            builder: (_) => ResultOverlay(
                                                "${getTransrlate(context, 'notlogin')}"));
                                      } else {
                                        setState(() {
                                          widget.product.Loading = true;
                                        });
                                        API(context).post('carts/add', {
                                          "product_id": widget.product.id,
                                          "user_id": id,
                                          "lang": "${themeColor.getlocal()}",
                                          "quantity": 1,
                                          "size_price": '0',
                                          "color": '0',
                                          "size": '0'
                                        }).then((value) {
                                          setState(() {
                                            widget.product.Loading = false;
                                          });
                                          if (value != null) {
                                            if (value['status_code'] == 200) {
                                              themeData.getCart(context);
                                              Nav.route(context, CartScreen());
                                            } else {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) => ResultOverlay(
                                                      "${value['message']}"));
                                            }
                                          }
                                        });
                                      }
                                    },
                                    child: Center(
                                      child: Text(
                                          '${getTransrlate(context, widget.product.type == 'Rent' ? 'rent' : 'Shopping')}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: ScreenUtil.getTxtSz(
                                                  context, 14))),
                                    )),
                              ),
                              if (widget.product.isDiscount == '1')
                                SizedBox(
                                  width: ScreenUtil.setWidth(context, 1),
                                  child: Center(
                                    child: Container(
                                      width: ScreenUtil.setWidth(context, .4),
                                      child: Center(
                                        child: MyCounterDownTimer(
                                          date: DateTime.tryParse(
                                              widget.product.discountDate),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if (widget.product.mazadStartDate != null)
                                SizedBox(
                                  width: ScreenUtil.setWidth(context, 1),
                                  child: Center(
                                    child: Container(
                                      width: ScreenUtil.setWidth(context, .4),
                                      child: Center(
                                        child: MyCounterDownTimer(
                                          date: DateTime.tryParse(widget
                                              .product.mazadStartDate
                                              .substring(0, 10)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                  ]),
            ),
          ),
        ),
        Positioned(
          top: 5,
          left: 5,
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 38,
              width: 32,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: InkWell(
                  onTap: () {
                    if (!themeColor.isLogin) {
                      showDialog(
                          context: context,
                          builder: (_) => ResultOverlay(
                              "${getTransrlate(context, 'notlogin')}"));
                    } else {
                      API(context).post('wishlists', {
                        "product_id": widget.product.id,
                        "lang": "${themeColor.getlocal()}",
                        "user_id": id,
                      }).then((value) {
                        if (value != null) {
                          if (value['status_code'] == 200) {
                            setState(() {});
                            showDialog(
                                context: context,
                                builder: (_) =>
                                    ResultOverlay("${value['message']}"));
                          } else {
                            showDialog(
                                context: context,
                                builder: (_) =>
                                    ResultOverlay(value['message']));
                          }
                        }
                      });
                    }
                  },
                  child: Icon(
                    Icons.favorite_border,
                    color: themeColor.getColor(),
                  )),
            ),
          ),
        )
      ],
    );
  }
}
