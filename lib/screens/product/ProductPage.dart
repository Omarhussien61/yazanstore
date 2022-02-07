import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_pos/model/app-config.dart';
import 'package:flutter_pos/model/product_details.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/screens/order/cart.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/app_bar_custom.dart';
import 'package:flutter_pos/widget/count_down_time.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/dialog_comment.dart';
import 'package:flutter_pos/widget/not_login.dart';
import 'package:flutter_pos/widget/product/product_card.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key, this.product}) : super(key: key);
  Product product;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int _carouselCurrentPage = 0;
  ProductDetail productDetail;
  int id;
  int checkColor = 0;
  int checkSize = 0;
  String name;
  int piece = 1;
  int _currentImage = 0;
  DateTime startrent;
  DateTime endrent;
  CarouselController _imageCarouselController = CarouselController();
  var _carouselImageList = [];
  final _formKey = GlobalKey<FormState>();
  double rateing = 5;
  String review = '';
  double total = 0;
  double avg = 0;

  @override
  void dispose() {
    super.dispose();
  }

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
        name = prefs.getString('user_name');
      });
    });
    getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.product.type);
    print(widget.product.discountDate);

    final themeColor = Provider.of<Provider_control>(context);
    final ServiceData = Provider.of<Provider_Data>(context);
    return Scaffold(
      body: Column(
        children: [
          AppBarCustom(
            isback: true,
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: productDetail == null
                  ? Center(
                      child: Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil.getHeight(context) / 4),
                      child: Custom_Loading(),
                    ))
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: ScreenUtil.setHeight(context, .3),
                            width: double.infinity,
                            child: CarouselSlider(
                              carouselController: _imageCarouselController,
                              options: CarouselOptions(
                                  aspectRatio: 1,
                                  viewportFraction: 1,
                                  initialPage: 0,
                                  enableInfiniteScroll: false,
                                  reverse: false,
                                  autoPlay: false,
                                  scrollDirection: Axis.horizontal,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _currentImage = index;
                                    });
                                  }),
                              items: _carouselImageList.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Stack(
                                      children: <Widget>[
                                        Container(
                                            width: double.infinity,
                                            child: FadeInImage.assetNetwork(
                                              placeholder: 'assets/load.gif',
                                              image: i,
                                              fit: BoxFit.scaleDown,
                                            )),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children:
                                                _carouselImageList.map((url) {
                                              int index = _carouselImageList
                                                  .indexOf(url);
                                              return Flexible(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    //print(index);
                                                    return _imageCarouselController
                                                        .animateToPage(index,
                                                            curve: Curves
                                                                .elasticOut);
                                                  },
                                                  child: Container(
                                                    width: 50,
                                                    height: 50,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4.0,
                                                            horizontal: 2.0),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: _currentImage ==
                                                                  index
                                                              ? Colors
                                                                  .lightGreen
                                                              : Color.fromRGBO(
                                                                  112,
                                                                  112,
                                                                  112,
                                                                  .3),
                                                          width:
                                                              _currentImage ==
                                                                      index
                                                                  ? 2
                                                                  : 1),
                                                      //shape: BoxShape.rectangle,
                                                    ),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child:
                                                            /*Image.asset(
                                                  singleProduct.product_images[index])*/
                                                            FadeInImage
                                                                .assetNetwork(
                                                          placeholder:
                                                              'assets/images/logo.png',
                                                          image: url,
                                                          fit: BoxFit.contain,
                                                        )),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${themeColor.getlocal() == 'ar' ? widget.product.name ?? widget.product.nameAr : widget.product.nameAr ?? widget.product.name}",
                              style: TextStyle(
                                  fontSize: ScreenUtil.getTxtSz(context, 20),
                                  color: themeColor.getColor(),
                                  fontWeight: FontWeight.w600),
                              maxLines: 2,
                            ),
                          ),
                          widget.product.isDiscount == '1'
                              ? SizedBox(
                                  width: ScreenUtil.setWidth(context, 1),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: ScreenUtil.setWidth(context, .5),
                                      child: Center(
                                        child: MyCounterDownTimer(
                                          date: DateTime.tryParse(
                                              widget.product.discountDate),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          widget.product.mazadStartDate != null &&
                                  DateTime.parse(widget.product.mazadStartDate)
                                      .isAfter(DateTime.now())
                              ? SizedBox(
                                  width: ScreenUtil.setWidth(context, 1),
                                  child: Center(
                                    child: Container(
                                      width: ScreenUtil.setWidth(context, .5),
                                      child: Center(
                                        child: MyCounterDownTimer(
                                          date: DateTime.tryParse(widget
                                              .product.mazadStartDate
                                              .substring(0, 10)),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${widget.product.price} ${themeColor.currency} ",
                                        style: TextStyle(
                                            fontSize: ScreenUtil.getTxtSz(
                                                context, 18),
                                            color: themeColor.getColor(),
                                            fontWeight: FontWeight.w600),
                                        maxLines: 2,
                                      ),
                                    ),
                                    widget.product.previousPrice == '0' ||
                                            widget.product.previousPrice == null
                                        ? Container()
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "${widget.product.previousPrice} ${themeColor.currency} ",
                                              style: TextStyle(
                                                  fontSize: ScreenUtil.getTxtSz(
                                                      context, 15),
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w600),
                                              maxLines: 2,
                                            ),
                                          ),
                                  ],
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: Text(
                                    "(" +
                                        "${avg.isNaN ? 5.0 : avg ?? 5.0}" +
                                        ")",
                                    style: TextStyle(
                                        color: Color.fromRGBO(152, 152, 153, 1),
                                        fontSize:
                                            ScreenUtil.getTxtSz(context, 15)),
                                  ),
                                ),
                                RatingBar(
                                  itemSize: ScreenUtil.getTxtSz(context, 22),
                                  ignoreGestures: true,
                                  initialRating: double.parse("${avg ?? 5.0}"),
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  ratingWidget: RatingWidget(
                                    full: Icon(Icons.star,
                                        color: themeColor.getColor()),
                                    half: Icon(Icons.star_half,
                                        color: themeColor.getColor()),
                                    empty: Icon(Icons.star,
                                        color:
                                            Color.fromRGBO(224, 224, 225, 1)),
                                  ),
                                  itemPadding: EdgeInsets.only(right: 1.0),
                                  onRatingUpdate: (rating) {
                                    //print(rating);
                                  },
                                ),
                              ],
                            ),
                          ),
                          widget.product.type.toLowerCase() != 'rent'
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      FlatButton(
                                          onPressed: () {
                                            showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2021),
                                                    lastDate: DateTime(2025))
                                                .then((value) {
                                              setState(() {
                                                startrent = value;
                                              });
                                            });
                                          },
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: themeColor.getColor(),
                                                  width: 1,
                                                  style: BorderStyle.solid),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Row(
                                            children: [
                                              Icon(
                                                  Icons.calendar_today_outlined,
                                                  color: themeColor.getColor()),
                                              SizedBox(width: 5),
                                              Text(
                                                  startrent != null
                                                      ? startrent
                                                          .toString()
                                                          .substring(0, 10)
                                                      : '${getTransrlate(context, 'start_rent')}',
                                                  style: TextStyle(
                                                      fontSize:
                                                          ScreenUtil.getTxtSz(
                                                              context, 15))),
                                            ],
                                          )),
                                      Spacer(),
                                      FlatButton(
                                          onPressed: () {
                                            showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2021),
                                                    lastDate: DateTime(2025))
                                                .then((value) {
                                              setState(() {
                                                endrent = value;
                                              });
                                            });
                                          },
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: themeColor.getColor(),
                                                  width: 1,
                                                  style: BorderStyle.solid),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Row(
                                            children: [
                                              Icon(
                                                  Icons.calendar_today_outlined,
                                                  color: themeColor.getColor()),
                                              SizedBox(width: 5),
                                              Text(
                                                  endrent != null
                                                      ? endrent
                                                          .toString()
                                                          .substring(0, 10)
                                                      : '${getTransrlate(context, 'end_rent')}',
                                                  style: TextStyle(
                                                      fontSize:
                                                          ScreenUtil.getTxtSz(
                                                              context, 15))),
                                            ],
                                          )),
                                      Spacer(),
                                    ],
                                  )),
                          widget.product.stock == null ||
                                  widget.product.stock == '0'
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "${getTransrlate(context, "quantity")} : ${widget.product.stock} ",
                                    style: TextStyle(
                                        fontSize:
                                            ScreenUtil.getTxtSz(context, 18),
                                        color: Colors.lightGreen,
                                        fontWeight: FontWeight.w600),
                                    maxLines: 2,
                                  ),
                                ),
                          widget.product.colors == null
                              ? Container()
                              : Row(
                                  children: [
                                    Text(
                                        '  ${getTransrlate(context, "Color")} : '),
                                    SizedBox(
                                      width: ScreenUtil.getWidth(context) / 1.5,
                                      child: ResponsiveGridList(
                                        scroll: false,
                                        desiredItemWidth:
                                            ScreenUtil.getWidth(context) / 10,
                                        minSpacing: 10,
                                        children:
                                            widget.product.colors.map((e) {
                                          bool select = widget.product.colors
                                                  .indexOf(e) ==
                                              checkColor;
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                checkColor = widget
                                                    .product.colors
                                                    .indexOf(e);
                                              });
                                            },
                                            child: Stack(
                                              children: [
                                                Icon(
                                                  Icons.circle,
                                                  color: Color(
                                                      _getColorFromHex(e)),
                                                  size: ScreenUtil.getTxtSz(
                                                      context, 35),
                                                ),
                                                !select
                                                    ? Container()
                                                    : Icon(
                                                        Icons
                                                            .check_circle_outline,
                                                        color: Colors.white,
                                                        size:
                                                            ScreenUtil.getTxtSz(
                                                                context, 35),
                                                      ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                          widget.product.size == null
                              ? Container()
                              : Row(
                                  children: [
                                    Text(
                                        '  ${getTransrlate(context, "Size")} : '),
                                    SizedBox(
                                      width: ScreenUtil.getWidth(context) / 1.5,
                                      child: ResponsiveGridList(
                                        scroll: false,
                                        desiredItemWidth:
                                            ScreenUtil.getWidth(context) / 9,
                                        minSpacing: 10,
                                        children: widget.product.size.map((e) {
                                          bool select =
                                              widget.product.size.indexOf(e) ==
                                                  checkSize;

                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                checkSize = widget.product.size
                                                    .indexOf(e);
                                              });
                                            },
                                            child: SizedBox(
                                              width:
                                                  ScreenUtil.getWidth(context) /
                                                      9,
                                              child: Card(
                                                  shape: BeveledRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.0),
                                                    side: BorderSide(
                                                      color: select
                                                          ? themeColor
                                                              .getColor()
                                                          : Colors.white,
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text('$e'),
                                                    ),
                                                  )),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          widget.product.type == 'Rent'
                              ? SizedBox()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height:
                                          ScreenUtil.setHeight(context, .06),
                                      child: FloatingActionButton(
                                          heroTag: false,
                                          onPressed: () {
                                            setState(() {
                                              if (piece != 1) {
                                                piece--;
                                              }
                                            });
                                          },
                                          backgroundColor:
                                              themeColor.getColor(),
                                          child: Icon(
                                            Icons.remove,
                                            size: ScreenUtil.getTxtSz(
                                                context, 35),
                                          )),
                                    ),
                                    Container(
                                      width: ScreenUtil.setHeight(context, .06),
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.only(
                                          top: 8, bottom: 4),
                                      child: Text('$piece',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w800,
                                              fontSize: ScreenUtil.getTxtSz(
                                                  context, 22))),
                                    ),
                                    Container(
                                      height:
                                          ScreenUtil.setHeight(context, .06),
                                      child: FloatingActionButton(
                                          backgroundColor:
                                              themeColor.getColor(),
                                          onPressed: () {
                                            setState(() {
                                              if (piece !=
                                                  int.tryParse(
                                                      widget.product.stock ??
                                                          0)) {
                                                piece++;
                                              }
                                            });
                                          },
                                          child: Icon(
                                            Icons.add,
                                            size: ScreenUtil.getTxtSz(
                                                context, 35),
                                          )),
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          widget.product.Loading
                              ? Container(
                                  height: 90,
                                  child: Center(
                                      child: Image.asset(
                                    'assets/load.gif',
                                  )))
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FlatButton(
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
                                            if (startrent != null &&
                                                endrent != null) {
                                              setState(() {
                                                piece = endrent
                                                    .difference(startrent)
                                                    .inDays;
                                              });
                                            }
                                            API(context).post('carts/add', {
                                              "product_id": widget.product.id,
                                              "user_id": id,
                                              "from": startrent
                                                  .toString()
                                                  .substring(0, 10),
                                              "to": endrent
                                                  .toString()
                                                  .substring(0, 10),
                                              "lang":
                                                  "${themeColor.getlocal()}",
                                              "quantity": piece,
                                              // "product_id": widget.product.id,
                                              // "user_id": id,
                                              // "lang":
                                              //     "${themeColor.getlocal()}",
                                              "size_price": widget
                                                          .product.sizePrice !=
                                                      null
                                                  ? widget.product.sizePrice
                                                          .isNotEmpty
                                                      ? widget.product
                                                          .sizePrice[checkSize]
                                                      : '0'
                                                  : '0',
                                              "color": widget.product.colors !=
                                                      null
                                                  ? widget.product.colors
                                                          .isNotEmpty
                                                      ? widget.product
                                                          .colors[checkColor]
                                                      : '0'
                                                  : '0',
                                              "size":
                                                  widget.product.size != null
                                                      ? widget.product.size
                                                              .isNotEmpty
                                                          ? widget.product
                                                              .size[checkSize]
                                                          : '0'
                                                      : '0',
                                            }).then((value) {
                                              setState(() {
                                                widget.product.Loading = false;
                                              });
                                              if (value != null) {
                                                if (value['status_code'] ==
                                                    200) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (_) => ResultOverlay(
                                                          " ${value['message']}"));
                                                  ServiceData.getCart(context);
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
                                                color: Colors.white),
                                            SizedBox(width: 2),
                                            Text(
                                                '${getTransrlate(context, 'ADDtoCart')}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        ScreenUtil.getTxtSz(
                                                            context, 12))),
                                          ],
                                        )),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    FlatButton(
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
                                              "lang":
                                                  "${themeColor.getlocal()}",
                                              "quantity": piece,
                                              "size_price": widget
                                                          .product.sizePrice !=
                                                      null
                                                  ? widget.product.sizePrice
                                                          .isNotEmpty
                                                      ? widget.product
                                                          .sizePrice[checkSize]
                                                      : '0'
                                                  : '0',
                                              "color": widget.product.colors !=
                                                      null
                                                  ? widget.product.colors
                                                          .isNotEmpty
                                                      ? widget.product
                                                          .colors[checkColor]
                                                      : '0'
                                                  : '0',
                                              "size":
                                                  widget.product.size != null
                                                      ? widget.product.size
                                                              .isNotEmpty
                                                          ? widget.product
                                                              .size[checkSize]
                                                          : '0'
                                                      : '0',
                                            }).then((value) {
                                              setState(() {
                                                widget.product.Loading = false;
                                              });
                                              if (value != null) {
                                                if (value['status_code'] ==
                                                    200) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (_) => ResultOverlay(
                                                          " ${value['message']}"));
                                                  ServiceData.getCart(context);
                                                  Nav.route(
                                                      context, CartScreen());
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
                                            Text(
                                                '${getTransrlate(context, widget.product.type == 'Rent' ? 'rent' : 'Shopping')}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        ScreenUtil.getTxtSz(
                                                            context, 12))),
                                          ],
                                        )),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    FlatButton(
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
                                            API(context).post('wishlists', {
                                              "product_id": widget.product.id,
                                              "lang":
                                                  "${themeColor.getlocal()}",
                                              "user_id": id,
                                            }).then((value) {
                                              setState(() {
                                                widget.product.Loading = false;
                                              });
                                              if (value != null) {
                                                if (value['status_code'] ==
                                                    200) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (_) => ResultOverlay(
                                                          "${value['message']}"));
                                                } else {
                                                  showDialog(
                                                      context: context,
                                                      builder: (_) =>
                                                          ResultOverlay(value[
                                                              'message']));
                                                }
                                              }
                                            });
                                          }
                                        },
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                        )),
                                    SizedBox(
                                      width: 2,
                                    ),
                                  ],
                                ),
                          widget.product.details != null
                              ? widget.product.details.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "${getTransrlate(context, 'description')} : ${themeColor.getlocal() == 'ar' ? widget.product.detailsAr.toString() ?? 'منتج جيد' : widget.product.details.toString() ?? 'منتج جديد '}",
                                        style: TextStyle(
                                          fontSize:
                                              ScreenUtil.getTxtSz(context, 14),
                                          // color: MyTheme.font_grey,
                                        ),
                                        //  maxLines: 2,
                                      ),
                                    )
                                  : Container(
                                      child: Text('data'),
                                    )
                              : Container(),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: InkWell(
                              onTap: () {
                                Share.share(
                                    'https://yazan-store.com/item/${widget.product.slug}',
                                    subject: 'Qafeer');
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.share_outlined,
                                      size: 20, color: Colors.grey),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: ScreenUtil.getWidth(context) / 2,
                                    child: Text(
                                      getTransrlate(context, 'share'),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          widget.product.sku == null
                              ? Container()
                              : widget.product.sku.isEmpty
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Text(
                                        "${getTransrlate(context, 'codeProduct')}: ${widget.product.sku}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600),
                                        maxLines: 2,
                                      ),
                                    ),
                          widget.product.policy == null
                              ? Container()
                              : widget.product.policy.isEmpty
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Text(
                                        "${getTransrlate(context, 'return')}: ${widget.product.policy}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600),
                                        maxLines: 2,
                                      ),
                                    ),
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(.2),
                                    blurRadius: 6.0, // soften the shadow
                                    spreadRadius: 0.0, //extend the shadow
                                    offset: Offset(
                                      0.0, // Move to right 10  horizontally
                                      1.0, // Move to bottom 10 Vertically
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(26)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: <Widget>[
                                      Text(getTransrlate(context, 'Reviews'),
                                          style: TextStyle(
                                              fontSize: ScreenUtil.getTxtSz(
                                                  context, 20),
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF5D6A78))),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      RatingBar.builder(
                                        initialRating: double.parse('4.5'),
                                        itemSize:
                                            ScreenUtil.getTxtSz(context, 23),
                                        minRating: 1,
                                        ignoreGestures: true,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        tapOnlyMode: false,
                                        itemBuilder: (context, _) => Container(
                                          height: 12,
                                          child: SvgPicture.asset(
                                            "assets/icons/ic_star.svg",
                                            color: themeColor.getColor(),
                                            width: 9,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                          '${productDetail == null ? 0 : productDetail.productt.ratings.length}' +
                                              ' ' +
                                              getTransrlate(context, 'Reviews'),
                                          style: TextStyle(
                                              fontSize: ScreenUtil.getTxtSz(
                                                  context, 15),
                                              fontWeight: FontWeight.w300,
                                              color: Color(0xFF5D6A78))),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(name == null ? ' ' : name,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF5D6A78))),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          !themeColor.isLogin
                                              ? showDialog(
                                                  context: context,
                                                  builder: (_) => ResultOverlay(
                                                      "${getTransrlate(context, 'notlogin')}"))
                                              : _displayDialog(
                                                  context, themeColor);
                                        },
                                        child: Container(
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                  getTransrlate(
                                                      context, 'AddComment'),
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color:
                                                          Color(0xFF5D6A78))),
                                              Container(
                                                color: Colors.grey,
                                                height: 0.7,
                                                width: ScreenUtil.getWidth(
                                                        context) /
                                                    1.5,
                                              )
                                            ],
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    child: Text(
                                      getTransrlate(context, 'SeeAllComments'),
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: themeColor.getColor()),
                                    ),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return MyDialog(
                                                productDetail.productt.ratings);
                                          }).then((value) => {getProduct()});
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: ScreenUtil.getWidth(context) / 2,
                              child: Text(
                                getTransrlate(context, 'ProductRelated'),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: themeColor.getColor()),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          productDetail == null
                              ? Container()
                              : productDetail.related == null
                                  ? Container()
                                  : productDetail.related.isEmpty
                                      ? Container()
                                      : Container(
                                          child: Container(
                                            height: ScreenUtil.setHeight(
                                                context, .5),
                                            color: Colors.white,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                padding: EdgeInsets.all(1),
                                                itemCount: productDetail
                                                    .related.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Container(
                                                    color: Colors.white,
                                                    width: ScreenUtil.getWidth(
                                                            context) /
                                                        2.2,
                                                    child: ProductCard(
                                                      themeColor: themeColor,
                                                      product: productDetail
                                                          .related[index],
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  _displayDialog(BuildContext context, themeColor) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: RatingBar.builder(
                initialRating: 5,
                itemSize: 22,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => Container(
                  height: 12,
                  child: SvgPicture.asset(
                    "assets/icons/ic_star.svg",
                    color: themeColor.getColor(),
                    width: 9,
                  ),
                ),
                onRatingUpdate: (rating) {
                  rateing = rating;
                  print(rating);
                },
              ),
            ),
            content: Form(
              key: _formKey,
              child: TextFormField(
                initialValue: review,
                decoration: InputDecoration(
                    hintText: getTransrlate(context, 'yourComment'),
                    hintStyle: TextStyle(),
                    focusColor: themeColor.getColor()),
                validator: (String value) {
                  if (value.isEmpty) {
                    return getTransrlate(context, 'avalidComment');
                  }
                  _formKey.currentState.save();

                  return null;
                },
                onSaved: (value) {
                  review = value;
                },
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  getTransrlate(context, 'cancel'),
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(
                  getTransrlate(context, 'Comment'),
                  style: TextStyle(color: themeColor.getColor()),
                ),
                onPressed: () async {
                  API(context).post('review/submit', {
                    "user_id": "$id",
                    "lang": "${themeColor.getlocal()}",
                    "product_id": widget.product.id,
                    "rating": rateing,
                    "review": review
                  }).then((value) => {
                        if (value != null)
                          {
                            getProduct(),
                            Navigator.pop(context),
                            showDialog(
                                context: context,
                                builder: (_) =>
                                    ResultOverlay("${value['message']}"))
                          }
                      });
                },
              )
            ],
          );
        });
  }

  getProduct() {
    print(widget.product.id);
    API(context).get('products/${widget.product.id}').then((value) {
      print(value);
      if (value != null) {
        setState(() {
          productDetail = ProductDetails.fromJson(value).data;
          widget.product = productDetail.productt;
          _carouselImageList = widget.product.galleries;
          _carouselImageList
              .add("${AppConfig.BASE_PATH}products/${widget.product.photo}");
        });
        print('d ddddddddd  ${productDetail.productt.colors}');
      }
    });
  }

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
