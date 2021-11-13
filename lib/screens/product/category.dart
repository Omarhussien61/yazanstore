import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pos/model/app-config.dart';
import 'package:flutter_pos/model/category_model.dart';
import 'package:flutter_pos/screens/product/products_page.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/app_bar_custom.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/no_found_product.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Categories> categories;
  int checkboxType = 0;
  int checkboxPart = 0;

  @override
  void initState() {
    API(context).get('categories').then((value) {
      if (value != null) {
        setState(() {
          categories = Category_model.fromJson(value).data;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Scaffold(
      body: Column(
        children: [
          AppBarCustom(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border:
                    Border.symmetric(vertical: BorderSide(color: Colors.grey)),
              ),
              child: Container(
                color: Colors.white70,
                child: categories == null
                    ? Center(child: Custom_Loading())
                    : Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: ScreenUtil.getHeight(context) / 1.25,
                              decoration: BoxDecoration(
                                border: Border.symmetric(
                                    vertical: BorderSide(color: Colors.grey)),
                              ),
                              child: SingleChildScrollView(
                                child: Container(
                                  width: ScreenUtil.getWidth(context) / 2.5,
                                  // height: ScreenUtil.getHeight(context) / 1.25,
                                  child: Container(
                                    child: ListView.builder(
                                      primary: false,
                                      shrinkWrap: true,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: categories.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        bool selected = checkboxType == index;
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              checkboxType = index;
                                              checkboxPart = 0;
                                            });
                                          },
                                          child: Container(
                                            height:
                                                ScreenUtil.getHeight(context) /
                                                    10,
                                            decoration: BoxDecoration(
                                                color: !selected
                                                    ? Colors.white
                                                    : themeColor.getColor(),
                                                border: Border.symmetric(
                                                    horizontal: BorderSide(
                                                        color: selected
                                                            ? Colors.black12
                                                            : Colors.black26))),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                        width:
                                                            ScreenUtil.getWidth(
                                                                    context) /
                                                                12,
                                                        height: ScreenUtil
                                                                .getHeight(
                                                                    context) /
                                                            18,
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 5),
                                                        decoration: BoxDecoration(
                                                            shape: BoxShape
                                                                .circle,
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color: themeColor
                                                                    .getColor(),
                                                                width: 1)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: CachedNetworkImage(
                                                              imageUrl:
                                                                  "${AppConfig.BASE_PATH}categories/${categories[index].photo}",
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  Image.asset(
                                                                      "assets/images/logo.png",
                                                                      color: Colors
                                                                          .grey)),
                                                        )),
                                                    Container(
                                                      width:
                                                          ScreenUtil.getWidth(
                                                                  context) /
                                                              3.5,
                                                      height:
                                                          ScreenUtil.getHeight(
                                                                  context) /
                                                              12,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 2,
                                                              left: 2),
                                                      child: Center(
                                                        child: AutoSizeText(
                                                          "${themeColor.getlocal() == 'ar' ? categories[index].nameAr : categories[index].name}",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              color: selected
                                                                  ? Colors.white
                                                                  : themeColor
                                                                      .getColor(),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                    width: ScreenUtil.getWidth(
                                                            context) /
                                                        2.5,
                                                    height: 5,
                                                    color: !selected
                                                        ? Colors.white
                                                        : themeColor
                                                            .getColor()),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: getPartCategories(
                                    categories[checkboxType].subs),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getPartCategories(List<Subs> partCategories) {
    final themeColor = Provider.of<Provider_control>(context);

    return partCategories == null
        ? Container()
        : partCategories.isEmpty
            ? Container(
                child: Container(
                    height: ScreenUtil.getWidth(context) / 2,
                    child: NotFoundProduct()))
            : ListView.builder(
                primary: false,
                shrinkWrap: true,
                padding: EdgeInsets.all(1),
                physics: NeverScrollableScrollPhysics(),
                itemCount: partCategories.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        Nav.route(
                            context,
                            Products_Page(
                              id: partCategories[index].id,
                              name:
                                  "${themeColor.getlocal() == 'ar' ? partCategories[index].nameAr : partCategories[index].name}",
                              Url:
                                  "products/subcategory/${partCategories[index].id}",
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: themeColor.getColor()),
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.black12,
                              blurRadius: 20.0,
                            ),
                          ],
                        ),
                        width: ScreenUtil.getWidth(context) / 1.5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.all(4.0),
                              //   child: CachedNetworkImage(
                              //     width: ScreenUtil.getWidth(context) / 1.5,
                              //     height: ScreenUtil.getHeight(context) / 10,
                              //     imageUrl:
                              //         "${AppConfig.BASE_PATH}categories/${categories[index].photo}",
                              //     errorWidget: (context, url, error) =>
                              //         Image.asset("assets/load.gif",),
                              //     fit: BoxFit.contain,
                              //   ),
                              // ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: ScreenUtil.getWidth(context) / 1.5,
                                  color: themeColor.getColor(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: Center(
                                      child: Text(
                                        "${themeColor.getlocal() == 'ar' ? partCategories[index].nameAr : partCategories[index].name}",
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil.getTxtSz(
                                                context, 14)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(top: 8),
                              //   child: Container(
                              //     height: 1,
                              //     color: Colors.black12,
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
  }
}
