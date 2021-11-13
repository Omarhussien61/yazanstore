import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/app-config.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/screens/product/ProductPage.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({
    Key key,
    @required this.themeColor,
    this.product,
    this.ctx,
  }) : super(key: key);

  final Provider_control themeColor;
  final Product product;
  final BuildContext ctx;

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Provider_Data>(context);

    return Stack(
      children: <Widget>[
        Container(
          //width: ScreenUtil.getWidth(context) / 2,
          margin: EdgeInsets.only(left: 16, top: 8, right: 12, bottom: 2),
          decoration: new BoxDecoration(
            color: Colors.white,
            boxShadow: [
              new BoxShadow(
                color: Colors.black12,
                blurRadius: 20.0,
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              widget.ctx == null ? null : Navigator.pop(widget.ctx);
              Nav.route(
                  context,
                  ProductPage(
                    product: widget.product,
                  ));
            },
            child: Container(

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    height: ScreenUtil.getHeight(context) / 6,
                    width: ScreenUtil.getWidth(context) / 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        imageUrl: AppConfig.BASE_PATH +
                            'products/' +
                            widget.product.photo,
                        errorWidget: (context, url, error) => Icon(
                          Icons.image,
                          color: Colors.black12,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      //width: ScreenUtil.getWidth(context) / 1.7,
                      padding: EdgeInsets.only(left: 2, top: 5, right: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          AutoSizeText(
                            widget.product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF5D6A78),
                              fontWeight: FontWeight.w300,
                            ),
                            minFontSize: 14,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                  width: ScreenUtil.getWidth(context) / 3,
                                  child: AutoSizeText(
                                    "${widget.product.price} ${getTransrlate(context, 'Currency')} ",
                                    maxLines: 1,
                                    minFontSize: 14,
                                    maxFontSize: 16,
                                    style: TextStyle(
                                        color: widget.themeColor.getColor(),
                                        fontWeight: FontWeight.w400),
                                  )),
                              Expanded(
                                child: SizedBox(
                                  height: 6,
                                ),
                              ),
                              // InkWell(
                              //   onTap: () {
                              //     API(context).post('add/to/cart', {
                              //       "product_id": widget.product.id,
                              //       "quantity": 1
                              //     }).then((value) {
                              //       if (value != null) {
                              //         if (value['status_code'] == 200) {
                              //           showDialog(
                              //               context: context,
                              //               builder: (_) => ResultOverlay(
                              //                   value['message']));
                              //           data.getCart(context);
                              //         } else {
                              //           showDialog(
                              //               context: context,
                              //               builder: (_) => ResultOverlay(
                              //                   value['errors']??value['message']));
                              //         }
                              //       }
                              //     });
                              //   },
                              //   child: Icon(
                              //     CupertinoIcons.cart,
                              //     color: Colors.black,
                              //   ),
                              // ),
                              // IconButton(
                              //   onPressed: () {
                              //     widget.product.inWishlist == 0
                              //         ? API(context).post('user/add/wishlist', {
                              //             "product_id": widget.product.id
                              //           }).then((value) {
                              //             if (value != null) {
                              //               if (value['status_code'] == 200) {
                              //                 setState(() {
                              //                   widget.product.inWishlist = 1;
                              //                 });
                              //                 showDialog(
                              //                     context: context,
                              //                     builder: (_) => ResultOverlay(
                              //                         value['message']));
                              //               } else {
                              //                 showDialog(
                              //                     context: context,
                              //                     builder: (_) => ResultOverlay(
                              //                         value['errors']));
                              //               }
                              //             }
                              //           })
                              //         : API(context).post(
                              //             'user/removeitem/wishlist', {
                              //             "product_id": widget.product.id
                              //           }).then((value) {
                              //             if (value != null) {
                              //               if (value['status_code'] == 200) {
                              //                 setState(() {
                              //                   widget.product.inWishlist = 0;
                              //                 });
                              //                 showDialog(
                              //                     context: context,
                              //                     builder: (_) => ResultOverlay(
                              //                         value['message']));
                              //               } else {
                              //                 showDialog(
                              //                     context: context,
                              //                     builder: (_) => ResultOverlay(
                              //                         value['errors']));
                              //               }
                              //             }
                              //           });
                              //   },
                              //   icon: Icon(
                              //     widget.product.inWishlist == 0
                              //         ? Icons.favorite_border
                              //         : Icons.favorite,
                              //     color: Colors.grey,
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
