import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/app-config.dart';
import 'package:flutter_pos/model/category_model.dart';
import 'package:flutter_pos/model/vendores_model.dart';
import 'package:flutter_pos/screens/product/products_page.dart';
import 'package:flutter_pos/screens/product/vendor.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/app_bar_custom.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/no_found_product.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';

class BrandProducts extends StatefulWidget {
  String name;

  BrandProducts(this.name);

  @override
  _BrandProductsState createState() => _BrandProductsState();
}

class _BrandProductsState extends State<BrandProducts> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Vendores _data;

  @override
  void initState() {
    API(context).get('vendores').then((value) {
      if (value != null) {
        setState(() {
          _data = Vendores_model.fromJson(value).data;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        // drawer: MainDrawer(),
        backgroundColor: Colors.white,
        body: buildCategoryList(context));
  }

  buildCategoryList(BuildContext context) {
    final themeData = Provider.of<Provider_Data>(context);
    final themeColor = Provider.of<Provider_control>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          AppBarCustom(
            isback: true,
            title: widget.name,
          ),
          _data == null
              ? Custom_Loading()
              : Column(
                  children: [
                    _data.normal.isEmpty
                        ? NotFoundProduct()
                        : Container(
                            width: ScreenUtil.getWidth(context),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(2, 8, 8, 8),
                                child: Text(
                                  "التجــــار ",
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          ScreenUtil.getTxtSz(context, 22),
                                      height: 1.6,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                    Container(
                      color: themeColor.getColor(),
                      height: 10,
                    ),
                    ResponsiveGridList(
                        desiredItemWidth: ScreenUtil.getWidth(context) / 2.4,
                        minSpacing: 10,
                        //rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        scroll: false,
                        children: _data.normal
                            .map((e) => Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0,
                                      bottom: 4.0,
                                      left: 16.0,
                                      right: 16.0),
                                  child: buildCategoryItemCard(e),
                                ))
                            .toList()),
                    // ListView.builder(
                    //   itemCount:_data.normal.length,
                    //   scrollDirection: Axis.vertical,
                    //   physics: NeverScrollableScrollPhysics(),
                    //   padding: EdgeInsets.all(1),
                    //   shrinkWrap: true,
                    //   itemBuilder: (context, index) {
                    //     return Padding(
                    //       padding: const EdgeInsets.only(
                    //           top: 4.0, bottom: 4.0, left: 16.0, right: 16.0),
                    //       child: buildCategoryItemCard(_data.normal[index]),
                    //     );
                    //   },
                    // ),
                  ],
                ),
          // _data == null
          //     ? Custom_Loading()
          //     : Column(
          //         children: [
          //           Container(
          //             width: ScreenUtil.getWidth(context),
          //             child: Center(
          //               child: Padding(
          //                 padding: EdgeInsets.fromLTRB(2, 8, 8, 8),
          //                 child: Text(
          //                   "تجار ومعارض ذهبية",
          //                   textAlign: TextAlign.left,
          //                   overflow: TextOverflow.ellipsis,
          //                   maxLines: 1,
          //                   style: TextStyle(
          //                       color: Colors.black,
          //                       fontSize: ScreenUtil.getTxtSz(context, 16),
          //                       height: 1.6,
          //                       fontWeight: FontWeight.w600),
          //                 ),
          //               ),
          //             ),
          //           ),
          //           Container(
          //             color: themeColor.getColor(),
          //             height: 10,
          //           ),
          //           _data.gold.isEmpty
          //               ? NotFoundProduct(
          //                   Empty: ' ',
          //                 )
          //               : ResponsiveGridList(
          //                   desiredItemWidth:
          //                       ScreenUtil.getWidth(context) / 2.4,
          //                   minSpacing: 10,
          //                   //rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //                   scroll: false,
          //                   children: _data.gold
          //                       .map((e) => Padding(
          //                             padding: const EdgeInsets.only(
          //                                 top: 4.0,
          //                                 bottom: 4.0,
          //                                 left: 16.0,
          //                                 right: 16.0),
          //                             child: buildCategoryItemCard(e),
          //                           ))
          //                       .toList()),
          //         ],
          //       ),
          // _data == null
          //     ? Custom_Loading()
          //     : Column(
          //         children: [
          //           Container(
          //             width: ScreenUtil.getWidth(context),
          //             child: Center(
          //               child: Padding(
          //                 padding: EdgeInsets.fromLTRB(2, 8, 8, 8),
          //                 child: Text(
          //                   "تجار ومعارض vip",
          //                   textAlign: TextAlign.left,
          //                   overflow: TextOverflow.ellipsis,
          //                   maxLines: 1,
          //                   style: TextStyle(
          //                       color: Colors.black,
          //                       fontSize: ScreenUtil.getTxtSz(context, 16),
          //                       height: 1.6,
          //                       fontWeight: FontWeight.w600),
          //                 ),
          //               ),
          //             ),
          //           ),
          //           Container(
          //             color: themeColor.getColor(),
          //             height: 10,
          //           ),
          //           _data.vip.isEmpty
          //               ? NotFoundProduct(
          //                   Empty: ' ',
          //                 )
          //               : ResponsiveGridList(
          //                   desiredItemWidth:
          //                       ScreenUtil.getWidth(context) / 2.4,
          //                   minSpacing: 10,
          //                   //rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //                   scroll: false,
          //                   children: _data.vip
          //                       .map((e) => Padding(
          //                             padding: const EdgeInsets.only(
          //                                 top: 4.0,
          //                                 bottom: 4.0,
          //                                 left: 16.0,
          //                                 right: 16.0),
          //                             child: buildCategoryItemCard(e),
          //                           ))
          //                       .toList()),
          //         ],
          //       ),
        ],
      ),
    );
  }

  Container buildCategoryItemCard(Normal categoryResponse) {
    final themeColor = Provider.of<Provider_control>(context);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          // Set border width
          borderRadius: BorderRadius.all(
              Radius.circular(10.0)), // Set rounded corner radius
          boxShadow: [
            BoxShadow(
                blurRadius: 10, color: Colors.black12, offset: Offset(1, 3))
          ] // Make rounded corner of border
          ),
      child: InkWell(
        onTap: () {
          categoryResponse.users == null
              ? null
              : Nav.route(
                  context,
                  vendor_Page(
                    id: categoryResponse.id,
                    name:
                        '${categoryResponse.users == null ? '' : categoryResponse.users.name}',
                    Url:
                        "vendores/products/${categoryResponse.users == null ? '' : categoryResponse.users.id}",
                  ));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Padding(
            //   padding: EdgeInsets.fromLTRB(2, 8, 8, 0),
            //   child: Text(
            //     "${categoryResponse.title}",
            //     textAlign: TextAlign.left,
            //     overflow: TextOverflow.ellipsis,
            //     maxLines: 1,
            //     style: TextStyle(
            //         color: themeColor.getColor(),
            //         fontSize: ScreenUtil.getTxtSz(context, 16),
            //         height: 1.6,
            //         fontWeight: FontWeight.w600),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.fromLTRB(2, 8, 8, 4),
              child: Text(
                "${categoryResponse.users == null ? '' : categoryResponse.users.name}",
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: themeColor.getColor()),
              ),
            ),
            Center(
              child: CachedNetworkImage(
                imageUrl:
                    "${categoryResponse.users == null ? 'https://qafeer.net/assets/images/noimage.png' : 'https://qafeer.net/assets/images/${categoryResponse.users.photo ?? 'noimage.png'}'}",
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
