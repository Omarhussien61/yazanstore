import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/app-config.dart';
import 'package:flutter_pos/model/cart_model.dart';
import 'package:flutter_pos/screens/product/ProductPage.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductCart extends StatefulWidget {
  const ProductCart({
    Key key,
    @required this.themeColor,
    this.carts,
  }) : super(key: key);

  final Provider_control themeColor;
  final Cart carts;

  @override
  _ProductCartState createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  List<String> items = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "other",
  ];

  bool other = true;
  final _formKey = GlobalKey<FormState>();
  int user_id;
  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      user_id = value.getInt('user_id');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ServiceData = Provider.of<Provider_Data>(context);
    final themeColor = Provider.of<Provider_control>(context);

    return InkWell(
      onTap: () {
        if (widget.carts != null) {
          Nav.route(
              context,
              ProductPage(
                product: widget.carts.product,
              ));
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: ScreenUtil.getWidth(context) / 3.5,
                  height: ScreenUtil.getWidth(context) / 6,
                  child: CachedNetworkImage(
                    imageUrl:
                        "${AppConfig.BASE_PATH}products/${widget.carts.product != null ? widget.carts.product.photo : ''}",
                    errorWidget: (context, url, error) => Icon(
                      Icons.image,
                      color: Colors.black12,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      deleteItem(ServiceData, themeColor);
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey,
                    )),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            //width: ScreenUtil.getWidth(context) / 1.7,
            padding: EdgeInsets.only(left: 10, top: 2, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AutoSizeText(
                  widget.carts.product == null ? '' : widget.carts.product.name,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  minFontSize: 11,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      widget.carts.Color == '0'
                          ? Container()
                          : Icon(
                              Icons.circle,
                              color:
                                  Color(_getColorFromHex(widget.carts.Color)),
                              size: 30,
                            ),
                      widget.carts.Size == '0'
                          ? Container()
                          : Card(
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0),
                                side: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(widget.carts.Size),
                                ),
                              )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                other = !other;
                              });
                            },
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.black12)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                        width: 50,
                                        child:
                                            Text("${widget.carts.quantity}")),
                                    Icon(Icons.arrow_drop_down)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: ScreenUtil.getWidth(context) / 3.2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: AutoSizeText(
                                    getTransrlate(context, 'price'),
                                    maxLines: 1,
                                    minFontSize: 14,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: AutoSizeText(
                                    widget.carts.product == null
                                        ? ''
                                        : " ${double.parse(widget.carts.product.price) + widget.carts.Size_price} ${themeColor.currency}",
                                    maxLines: 1,
                                    minFontSize: 14,
                                    style: TextStyle(
                                        color: widget.themeColor.getColor(),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: ScreenUtil.getWidth(context) / 3.2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: AutoSizeText(
                                    getTransrlate(context, 'total'),
                                    maxLines: 1,
                                    minFontSize: 14,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: AutoSizeText(
                                    widget.carts.product == null
                                        ? ''
                                        : " ${double.parse(widget.carts.product.price) * widget.carts.quantity + widget.carts.Size_price} ${themeColor.currency}",
                                    maxLines: 1,
                                    minFontSize: 14,
                                    style: TextStyle(
                                        color: widget.themeColor.getColor(),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      !other
                          ? Container(
                              child: Form(
                                key: _formKey,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 10, left: 2, right: 2, top: 10),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.black12)),
                                  height: 90,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "${getTransrlate(context, 'quantity')} :",
                                      ),
                                      Container(
                                        width: 100,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 2, vertical: 12),
                                        padding: const EdgeInsets.all(3.0),
                                        child: MyTextFormField(
                                          istitle: true,
                                          intialLabel:
                                              widget.carts.quantity.toString(),
                                          keyboard_type: TextInputType.number,
                                          labelText: getTransrlate(
                                              context, 'quantity'),
                                          hintText: getTransrlate(
                                              context, 'quantity'),
                                          isPhone: true,
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return "كمية";
                                            }
                                            _formKey.currentState.save();
                                            return null;
                                          },
                                          onSaved: (String value) {
                                            widget.carts.quantity =
                                                int.parse(value);
                                          },
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            _formKey.currentState.save();
                                            API(context).post('carts/edit', {
                                              "product_id":
                                                  widget.carts.product.id,
                                              "user_id": user_id,
                                              "lang":
                                                  "${themeColor.getlocal()}",
                                              "quantity": widget.carts.quantity
                                            }).then((value) {
                                              if (value != null) {
                                                if (value['status_code'] ==
                                                    200) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (_) =>
                                                          ResultOverlay(value[
                                                              'message']));

                                                  ServiceData.getCart(context);
                                                  setState(() {
                                                    other = !other;
                                                  });
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
                                        child: Container(
                                          height: 50,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 2, vertical: 1),
                                          padding: const EdgeInsets.all(12.0),
                                          color: themeColor.getColor(),
                                          child: Center(
                                              child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                CupertinoIcons.cart,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                getTransrlate(
                                                    context, 'updateCart'),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Container(
                    height: 1,
                    color: Colors.black12,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void deleteItem(Provider_Data ServiceData, Provider_control Service) {
    SharedPreferences.getInstance().then((value) {
      API(context).post('carts/remove', {
        "user_id": value.getInt('user_id'),
        "product_id": widget.carts.product.id,
        "lang": "${Service.getlocal()}",
        "size_price": widget.carts.product.sizePrice != null
            ? widget.carts.product.sizePrice.isNotEmpty
                ? widget.carts.Size_price
                : null
            : null,
        "color": widget.carts.product.colors != null
            ? widget.carts.product.colors.isNotEmpty
                ? widget.carts.Color
                : null
            : null,
        "size": widget.carts.product.size != null
            ? widget.carts.product.size.isNotEmpty
                ? widget.carts.Size
                : null
            : null,
      }).then((value) {
        if (value != null) {
          if (value['status_code'] == 200) {
            showDialog(
                context: context,
                builder: (_) => ResultOverlay("${value['message']}"));
            ServiceData.getCart(context);
          } else {
            showDialog(
                context: context,
                builder: (_) => ResultOverlay("${value['message']}"));
          }
        }
      });
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
