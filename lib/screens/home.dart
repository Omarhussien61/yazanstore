import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/ads.dart';
import 'package:flutter_pos/model/app-config.dart';
import 'package:flutter_pos/model/car_type.dart';
import 'package:flutter_pos/model/gallery_model.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/screens/main_home/subcategory.dart';
import 'package:flutter_pos/screens/product/products_page.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/SearchOverlay.dart';
import 'package:flutter_pos/widget/hidden_menu.dart';
import 'package:flutter_pos/widget/product/product_card.dart';
import 'package:flutter_pos/widget/product/product_list_titlebar.dart';
import 'package:flutter_pos/widget/slider/Banner.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';

import 'main_home/brand_products.dart';
import 'main_home/category_list.dart';
import 'main_home/top_selling_products.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CarType> cartype;
  List<Sliders> ads, Lsliders, homeSlider;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Gallery> _data;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      getData();
    });
    super.initState();
  }

  getData() {
    API(context).get('homeAds').then((value) {
      if (value != null) {
        setState(() {
          ads = Ads.fromJson(value).Rsliders;
          Lsliders = Ads.fromJson(value).Lsliders;
        });
      }
    });
    API(context).get('gallery').then((value) {
      if (value != null) {
        setState(() {
          _data = Gallery_model.fromJson(value).data;
        });
      }
    });
    API(context).get('homeSlider').then((value) {
      if (value != null) {
        homeSlider = new List<Sliders>();

        setState(() {
          value['data'].forEach((v) {
            homeSlider.add(new Sliders.fromJson(v));
          });
        });
      }
    });
    Provider.of<Provider_Data>(context, listen: false).getCart(context);
    Provider.of<Provider_Data>(context, listen: false).getData(context);
  }

  bool test = false;
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    final provider_data = Provider.of<Provider_Data>(context);

    return Scaffold(
        key: _scaffoldKey,
        appBar: buildAppBar(ScreenUtil.setHeight(context, .075), context),
        drawer: HiddenMenu(),
        body: test
            ? Container(
                height: ScreenUtil.setHeight(context, .9),
                width: ScreenUtil.setWidth(context, 1),
                child: Column(
                  children: [
                    SizedBox(
                      child: homeSlider == null
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: CarouselSlider(
                                items: homeSlider
                                    .map((item) => Banner_item(
                                          item:
                                              "${AppConfig.BASE_PATH}sliders/${item.photo}",
                                          text: item.titleText,
                                        ))
                                    .toList(),
                                options: CarouselOptions(
                                    height: ScreenUtil.getHeight(context) / 5,
                                    viewportFraction: 1.0,
                                    enlargeCenterPage: false,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    //onPageChanged: callbackFunction,
                                    scrollDirection: Axis.horizontal,
                                    onPageChanged: (index, reason) {
                                      // setState(() {});
                                    }),
                              ),
                            ),
                    ),
                    SizedBox(
                      child: buildHomeMenuRow(context),
                    ),
                    hList(themeColor, provider_data.bestProducts)
                  ],
                ),
              )
            : Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Expanded(
                      child: RefreshIndicator(
                        color: themeColor.getColor(),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                child: homeSlider == null
                                    ? Container()
                                    : Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: CarouselSlider(
                                          items: homeSlider
                                              .map((item) => Banner_item(
                                                    item:
                                                        "${AppConfig.BASE_PATH}sliders/${item.photo}",
                                                    text: item.titleText,
                                                  ))
                                              .toList(),
                                          options: CarouselOptions(
                                              height: ScreenUtil.getHeight(
                                                      context) /
                                                  5,
                                              viewportFraction: 1.0,
                                              enlargeCenterPage: false,
                                              initialPage: 0,
                                              enableInfiniteScroll: true,
                                              reverse: false,
                                              autoPlay: true,
                                              autoPlayInterval:
                                                  Duration(seconds: 3),
                                              autoPlayAnimationDuration:
                                                  Duration(milliseconds: 800),
                                              autoPlayCurve:
                                                  Curves.fastOutSlowIn,
                                              //onPageChanged: callbackFunction,
                                              scrollDirection: Axis.horizontal,
                                              onPageChanged: (index, reason) {
                                                // setState(() {});
                                              }),
                                        ),
                                      ),
                              ),
                              SizedBox(
                                height: ScreenUtil.setHeight(context, .01),
                              ),
                              SizedBox(
                                child: buildHomeMenuRow(context),
                              ),
                              ProductListTitleBar(
                                themeColor: themeColor,
                                title: getTransrlate(
                                    context, 'featured_categories'),
                                description: "",
                                url: 'urgentDeals',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              provider_data.categories == null
                                  ? Container()
                                  : Container(
                                      height: ScreenUtil.getHeight(context) / 8,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          padding: EdgeInsets.all(1),
                                          itemCount:
                                              provider_data.categories.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                              onTap: () {
                                                provider_data.categories[index]
                                                            .id !=
                                                        20
                                                    ? Nav.route(
                                                        context,
                                                        Products_Page(
                                                          id: provider_data
                                                              .categories[index]
                                                              .id,
                                                          name: themeColor
                                                                      .getlocal() ==
                                                                  'ar'
                                                              ? provider_data
                                                                  .categories[
                                                                      index]
                                                                  .nameAr
                                                              : provider_data
                                                                  .categories[
                                                                      index]
                                                                  .name,
                                                          Url:
                                                              "products/category/${provider_data.categories[index].id}",
                                                        ))
                                                    : Nav.route(
                                                        context,
                                                        Subcategory(
                                                          themeColor.getlocal() ==
                                                                  'ar'
                                                              ? provider_data
                                                                  .categories[
                                                                      index]
                                                                  .nameAr
                                                              : provider_data
                                                                  .categories[
                                                                      index]
                                                                  .name,
                                                          provider_data
                                                              .categories[index]
                                                              .subs,
                                                        ));
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Column(
                                                  // mainAxisAlignment: MainAxisAlignment.start,
                                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: CachedNetworkImage(
                                                        width:
                                                            ScreenUtil.getWidth(
                                                                    context) /
                                                                3.5,
                                                        height: ScreenUtil
                                                                .getHeight(
                                                                    context) /
                                                            20,
                                                        imageUrl:
                                                            "${AppConfig.BASE_PATH}categories/${provider_data.categories[index].photo}",
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Image.asset(
                                                          "assets/load.gif",
                                                        ),
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Container(
                                                        width:
                                                            ScreenUtil.getWidth(
                                                                    context) /
                                                                3.5,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child: Center(
                                                            child: Text(
                                                              "${themeColor.getlocal() == 'ar' ? provider_data.categories[index].nameAr : provider_data.categories[index].name}",
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
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
                                            );
                                          }),
                                    ),
                              SizedBox(
                                child: SizedBox(
                                  height: ScreenUtil.setHeight(context, .01),
                                ),
                              ),
                              SizedBox(
                                child: provider_data.product == null
                                    ? Container()
                                    : provider_data.product.isEmpty
                                        ? Container()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ProductListTitleBar(
                                                themeColor: themeColor,
                                                title: getTransrlate(context,
                                                    'featured_products'),
                                                description: getTransrlate(
                                                    context, 'showAll'),
                                                url: 'urgentDeals',
                                              ),
                                              hList(themeColor,
                                                  provider_data.product),
                                            ],
                                          ),
                                // ads == null
                                //     ? Container()
                                //     : Padding(
                                //         padding: EdgeInsets.only(top: 10),
                                //         child: CarouselSlider(
                                //           items: ads
                                //               .map((item) => Padding(
                                //                     padding: const EdgeInsets.all(8.0),
                                //                     child: Banner_item(
                                //                       item:
                                //                           "${AppConfig.BASE_PATH}sliders/${item.photo}",
                                //                       //   text: item.titleText,
                                //                     ),
                                //                   ))
                                //               .toList(),
                                //           options: CarouselOptions(
                                //               height: ScreenUtil.getHeight(context) / 5,
                                //               viewportFraction: 1.0,
                                //               enlargeCenterPage: false,
                                //               initialPage: 0,
                                //               enableInfiniteScroll: true,
                                //               reverse: false,
                                //               autoPlay: true,
                                //               autoPlayInterval: Duration(seconds: 3),
                                //               autoPlayAnimationDuration:
                                //                   Duration(milliseconds: 800),
                                //               autoPlayCurve: Curves.fastOutSlowIn,
                                //               //onPageChanged: callbackFunction,
                                //               scrollDirection: Axis.horizontal,
                                //               onPageChanged: (index, reason) {
                                //                 setState(() {});
                                //               }),
                                //         ),
                                //       ),
                              ),
                              SizedBox(
                                child: provider_data.bestProducts == null
                                    ? Container()
                                    : provider_data.bestProducts.isEmpty
                                        ? Container()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ProductListTitleBar(
                                                themeColor: themeColor,
                                                title: getTransrlate(
                                                    context, 'moresale'),
                                                description: getTransrlate(
                                                    context, 'showAll'),
                                                url: 'bestProducts',
                                              ),
                                              hList(themeColor,
                                                  provider_data.bestProducts),
                                            ],
                                          ),
                              ),
                              // SizedBox(
                              //   child: Lsliders == null
                              //       ? Container()
                              //       : Padding(
                              //           padding: EdgeInsets.only(top: 10),
                              //           child: CarouselSlider(
                              //             items: Lsliders.map((item) => Padding(
                              //                   padding: const EdgeInsets.all(8.0),
                              //                   child: Banner_item(
                              //                     item:
                              //                         "${AppConfig.BASE_PATH}sliders/${item.photo}",
                              //                     //   text: item.titleText,
                              //                   ),
                              //                 )).toList(),
                              //             options: CarouselOptions(
                              //                 height:
                              //                     ScreenUtil.getHeight(context) / 5,
                              //                 viewportFraction: 1.0,
                              //                 enlargeCenterPage: false,
                              //                 initialPage: 0,
                              //                 enableInfiniteScroll: true,
                              //                 reverse: false,
                              //                 autoPlay: true,
                              //                 autoPlayInterval: Duration(seconds: 3),
                              //                 autoPlayAnimationDuration:
                              //                     Duration(milliseconds: 800),
                              //                 autoPlayCurve: Curves.fastOutSlowIn,
                              //                 //onPageChanged: callbackFunction,
                              //                 scrollDirection: Axis.horizontal,
                              //                 onPageChanged: (index, reason) {
                              //                   setState(() {});
                              //                 }),
                              //           ),
                              //         ),
                              // ),

                              SizedBox(
                                child: provider_data.productMostSale == null
                                    ? Container()
                                    : provider_data.productMostSale.isEmpty
                                        ? Container()
                                        : Column(
                                            children: [
                                              ProductListTitleBar(
                                                themeColor: themeColor,
                                                title: getTransrlate(
                                                    context, 'vip_products'),
                                                description: getTransrlate(
                                                    context, 'showAll'),
                                                url: 'vendor-vip-products',
                                              ),
                                              hList(
                                                  themeColor,
                                                  provider_data
                                                      .productMostSale),
                                              SizedBox(
                                                height: 10,
                                              )
                                            ],
                                          ),
                              ),
                              // ProductListTitleBar(
                              //   themeColor: themeColor,
                              //   title: getTransrlate(context, 'vip_products'),
                              //   description: getTransrlate(context, 'showAll'),
                              //   url: 'vendor-vip-products',
                              // ),
                              // provider_data.productvip == null
                              //     ? Container()
                              //     : provider_data.productvip.isEmpty
                              //         ? Container()
                              //         : hList(
                              //             themeColor, provider_data.productvip),
                              SizedBox(
                                height: 25,
                              )
                            ],
                          ),
                        ),
                        onRefresh: _refreshLocalGallery,
                      ),
                    ),
                  ],
                ),
              ));
  }

  buildHomeMenuRow(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CategoryList(
                    '${getTransrlate(context, 'top_categories')}');
              }));
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 5 - 4,
              child: Column(
                children: [
                  Container(
                      height: ScreenUtil.setHeight(context, .065),
                      width: ScreenUtil.setWidth(context, .18),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: themeColor.getColor(), width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset("assets/images/top_categories.png"),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, right: 2, left: 2),
                    child: Text(
                      "${getTransrlate(context, 'top_categories')}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil.getTxtSz(context, 14),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BrandProducts(getTransrlate(context, 'brands'));
              }));
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 5 - 4,
              child: Column(
                children: [
                  Container(
                      height: ScreenUtil.setHeight(context, .065),
                      width: ScreenUtil.setWidth(context, .18),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: themeColor.getColor(), width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          "assets/icons/store.svg",
                          color: Colors.blue,
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text("${getTransrlate(context, 'brands')}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil.getTxtSz(context, 14),
                          ))),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TopSellingProducts(
                    getTransrlate(context, 'top_sellers'));
              }));
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 5 - 4,
              child: Column(
                children: [
                  Container(
                      height: ScreenUtil.setHeight(context, .065),
                      width: ScreenUtil.setWidth(context, .18),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: themeColor.getColor(), width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset("assets/images/top_sellers.png"),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(getTransrlate(context, 'top_sellers'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil.getTxtSz(context, 14),
                          ))),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Nav.route(
                  context,
                  Products_Page(
                    Url: "MazadProducts",
                    name: "${getTransrlate(context, 'today_deals')}",
                  ));
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 5 - 4,
              child: Column(
                children: [
                  Container(
                      height: ScreenUtil.setHeight(context, .065),
                      width: ScreenUtil.setWidth(context, .18),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: themeColor.getColor(), width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset("assets/images/todays_deal.png"),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(getTransrlate(context, 'today_deals'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil.getTxtSz(context, 14),
                          ))),
                ],
              ),
            ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     Nav.route(
          //         context,
          //         Products_Page(
          //           Url: "MazadProducts",
          //           name: "${getTransrlate(context, 'flash_deal')}",
          //         ));
          //   },
          //   child: Container(
          //     width: MediaQuery.of(context).size.width / 5 - 4,
          //     child: Column(
          //       children: [
          //         Container(
          //             height: ScreenUtil.setHeight(context, .14),
          //             width: ScreenUtil.setWidth(context, .18),
          //             decoration: BoxDecoration(
          //                 shape: BoxShape.circle,
          //                 border: Border.all(
          //                     color: themeColor.getColor(), width: 1)),
          //             child: Padding(
          //               padding: const EdgeInsets.all(16.0),
          //               child: Image.asset("assets/images/flash_deal.png"),
          //             )),
          //         Padding(
          //             padding: const EdgeInsets.only(top: 8, right: 2, left: 2),
          //             child: Text(getTransrlate(context, 'flash_deal'),
          //                 textAlign: TextAlign.center,
          //                 style: TextStyle(
          //                   color: Colors.black,
          //                   fontWeight: FontWeight.w600,
          //                   fontSize: ScreenUtil.getTxtSz(context, 14),
          //                 ))),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Future<Null> _refreshLocalGallery() async {
    getData();
  }

  Widget hList(Provider_control themeColor, List<Product> product) {
    return product.isEmpty
        ? Container()
        : SizedBox(
            height: ScreenUtil.setHeight(context, .45),

            //width: ScreenUtil.getWidth(context),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: product.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4, bottom: 4),
                    child: Container(
                      width: ScreenUtil.getWidth(context) / 2.2,
                      child: ProductCard(
                        themeColor: themeColor,
                        product: product[index],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }

  Widget list_product(Provider_control themeColor, List<Product> product) {
    return product.isEmpty
        ? Container()
        : Container(
            color: Colors.white,
            child: ResponsiveGridList(
              scroll: false,
              desiredItemWidth: ScreenUtil.getWidth(context) / 2.2,
              minSpacing: 10,
              children: product
                  .map((e) => Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4, bottom: 4),
                          child: ProductCard(
                            themeColor: themeColor,
                            product: e,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          );
  }

  AppBar buildAppBar(double statusBarHeight, BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return AppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          _scaffoldKey.currentState.openDrawer();
        },
        child: Builder(
          builder: (context) => Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 18.0, horizontal: 0.0),
            child: Container(
              child: Image.asset(
                'assets/images/hamburger.png',
                height: 16,
                //color: MyTheme.dark_grey,
                color: themeColor.getColor(),
              ),
            ),
          ),
        ),
      ),
      title: Container(
        height: kToolbarHeight +
            statusBarHeight -
            (MediaQuery.of(context).viewPadding.top > 40 ? 16.0 : 16.0),
        //MediaQuery.of(context).viewPadding.top is the statusbar height, with a notch phone it results almost 50, without a notch it shows 24.0.For safety we have checked if its greater than thirty
        child: Container(
          child: Padding(
              padding: const EdgeInsets.only(
                  top: 14.0, bottom: 14, left: 14, right: 12),
              // when notification bell will be shown , the right padding will cease to exist.
              child: Center(
                child: Container(
                  height: 40,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context, builder: (_) => SearchOverlay());
                      },
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          fillColor: Colors.white,

                          hintText: "  ${getTransrlate(context, 'search')}",
                          contentPadding: EdgeInsets.all(5.0),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: themeColor.getColor(),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: themeColor.getColor(),
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: themeColor.getColor(),
                              width: 1.0,
                            ),
                          ),

                          filled: true,
                          // enabled:
                        ),
                      ),
                    ),
                  ),
                ),
              )),
        ),
      ),
      elevation: 0.0,
      titleSpacing: 0,
      actions: <Widget>[
        InkWell(
          onTap: () {
            // ToastComponent.showDialog("Coming soon", context,
            //     gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
          },
          child: Visibility(
            visible: false,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
              child: Image.asset(
                'assets/images/bell.png',
                height: 16,
                color: themeColor.getColor(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCategoryItemCard(Gallery categoryResponse) {
    final themeColor = Provider.of<Provider_control>(context);

    return InkWell(
      onTap: () {
        Nav.route(
            context,
            Products_Page(
              id: categoryResponse.id,
              name: themeColor.getlocal() == 'ar'
                  ? categoryResponse.nameAr
                  : categoryResponse.name,
              Url: "products/subcategory/${categoryResponse.id}",
            ));
      },
      child: Container(
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.all(4),
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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: ScreenUtil.getWidth(context) / 2.1,
                  height: ScreenUtil.getHeight(context) / 10,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/load.gif',
                        image: "${categoryResponse.photo}",
                        fit: BoxFit.contain,
                      ))),
              Padding(
                padding: EdgeInsets.fromLTRB(2, 8, 8, 0),
                child: Text(
                  "${themeColor.getlocal() == 'ar' ? categoryResponse.nameAr : categoryResponse.name}",
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      height: 1.6,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ]),
      ),
    );
  }
}
