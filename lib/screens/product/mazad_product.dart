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

class MazadProduct extends StatefulWidget {
  MazadProduct({Key key, this.product}) : super(key: key);
  Product product;

  @override
  _MazadProductState createState() => _MazadProductState();
}

class _MazadProductState extends State<MazadProduct> {
  int _carouselCurrentPage = 0;
  ProductDetail productDetail;
  int id;
  int checkColor = 0;
  int checkSize = 0;
  String name;
  int piece = 1;
  List<MazadOffer> mazadOffers = [];
  int _currentImage = 0;
  DateTime startrent;
  DateTime endrent;
  CarouselController _imageCarouselController = CarouselController();
  var _carouselImageList = [];
  final _formKey = GlobalKey<FormState>();
  double rateing = 5;
  String newPrice = '';
  double total = 0;
  double avg = 0;
  TextEditingController _price = TextEditingController();
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
                          widget.product.mazadStartDate != null
                              ? SizedBox(
                                  width: ScreenUtil.setWidth(context, 1),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: ScreenUtil.setWidth(context, .5),
                                      child: Center(
                                        child: MyCounterDownTimer(
                                          date: DateTime.tryParse(
                                              widget.product.mazadStartDate),
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
                                Text('${getTransrlate(context, 'lastPrice')}'),
                                Spacer(),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${widget.product.price} ${getTransrlate(context, 'Currency')} ",
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
                                              "${widget.product.previousPrice} ${getTransrlate(context, 'Currency')} ",
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
                          mazadOffers.isNotEmpty
                              ? Container(
                                  padding: EdgeInsets.all(15),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: List.generate(
                                        mazadOffers.length,
                                        (index) => Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(mazadOffers[index]
                                                        .name),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "${mazadOffers[index].price} ${getTransrlate(context, 'Currency')} ",
                                                      style: TextStyle(
                                                          fontSize: ScreenUtil
                                                              .getTxtSz(
                                                                  context, 18),
                                                          color: themeColor
                                                              .getColor(),
                                                          fontWeight:
                                                              FontWeight.w600),
                                                      maxLines: 2,
                                                    ),
                                                  ],
                                                ),
                                                Divider(),
                                              ],
                                            )),
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              _displayMazadDialog(context, themeColor);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 25),
                              padding: EdgeInsets.all(15),
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
                                children: [
                                  Text(getTransrlate(context, 'add_price')),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Divider(
                                    height: 2,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: InkWell(
                              onTap: () {
                                Share.share(
                                    'https://yazan-store.com/item/${widget.product.slug}',
                                    subject: 'Yazan');
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

  _displayMazadDialog(BuildContext context, themeColor) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
              key: _formKey,
              child: TextFormField(
                controller: _price,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: getTransrlate(context, 'add_price'),
                    hintStyle: TextStyle(),
                    focusColor: themeColor.getColor()),
                validator: (value) {
                  if (value.isEmpty) {
                    return '!!!';
                  }
                  _formKey.currentState.save();

                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    newPrice = value.toString();
                    print(newPrice);
                  });
                },
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  getTransrlate(context, 'cancel'),
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(
                  getTransrlate(context, 'add'),
                  style: TextStyle(color: themeColor.getColor()),
                ),
                onPressed: () {
                  if (int.tryParse(_price.text) > mazadOffers.first.price) {
                    print(_price.text);
                    API(context).post('mazad-prices', {
                      "user_id": "$id",
                      "product_id": widget.product.id,
                      "price": _price.text
                    }).then((value) => {
                          if (value != null)
                            {
                              _price.clear(),
                              getProduct(),
                              Navigator.pop(context),
                              showDialog(
                                  context: context,
                                  builder: (_) =>
                                      ResultOverlay("${value['message']}"))
                            }
                        });
                  } else {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (_) => ResultOverlay(
                            getTransrlate(context, "wrongPrice")));
                  }
                },
              )
            ],
          );
        });
  }

  getProduct() {
    print(widget.product.id);
    API(context).get('products/${widget.product.id}').then((value) {
      if (value != null) {
        List<dynamic> subs = value['data']['subscribers'];
        List<MazadOffer> mazzass =
            subs.map((e) => MazadOffer.fromJson(e)).toList();
        setState(() {
          productDetail = ProductDetails.fromJson(value).data;
          widget.product = productDetail.productt;
          _carouselImageList = widget.product.galleries;
          _carouselImageList
              .add("${AppConfig.BASE_PATH}products/${widget.product.photo}");
          mazzass.sort((b, a) => a.price.compareTo(b.price));
          mazadOffers = mazzass;
        });

        print('d ddddddddd  ${productDetail.productt.colors}');
      }
    });
  }

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
      return int.parse(hexColor, radix: 16);
    } else {
      return 000000;
    }
  }
}

class MazadOffer {
  int price;
  String userId;
  String name;

  MazadOffer({this.price, this.userId, this.name});

  MazadOffer.fromJson(Map<String, dynamic> json) {
    price = int.tryParse(json['price']);
    userId = json['user_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    return data;
  }
}
