import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/ads.dart';
import 'package:flutter_pos/model/app-config.dart';
import 'package:flutter_pos/model/gallery_model.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/screens/product/products_page.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/app_bar_custom.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/no_found_product.dart';
import 'package:flutter_pos/widget/product/product_card.dart';
import 'package:flutter_pos/widget/slider/Banner.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';

class Offers extends StatefulWidget {
  const Offers({Key key}) : super(key: key);

  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  List<Sliders> ads;

  @override
  void initState() {
    API(context).get('new_slider').then((value) {
      if (value != null) {
        print(value);
        ads = new List<Sliders>();

        setState(() {
          ads.add(Sliders.fromJson(value['data']));
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    final provider_data = Provider.of<Provider_Data>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarCustom(),
            ads == null
                ? Container()
                : Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: CarouselSlider(
                      items: ads
                          .map((item) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Banner_item(
                                  item:
                                      "${AppConfig.BASE_PATH}sliders/${item.photo}",
                                  //   text: item.titleText,
                                ),
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
                          autoPlayInterval: Duration(seconds: 10),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          //onPageChanged: callbackFunction,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            setState(() {});
                          }),
                    ),
                  ),
            provider_data.product == null
                ? Custom_Loading()
                : provider_data.product.isEmpty
                    ? NotFoundProduct()
                    : list_product(themeColor, provider_data.product),
          ],
        ),
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
}
