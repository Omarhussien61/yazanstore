import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/ads.dart';
import 'package:flutter_pos/model/app-config.dart';
import 'package:flutter_pos/model/gallery_model.dart';
import 'package:flutter_pos/screens/product/products_page.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/app_bar_custom.dart';
import 'package:flutter_pos/widget/slider/Banner.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';

class Gallaries extends StatefulWidget {
  const Gallaries({Key key}) : super(key: key);

  @override
  _GallariesState createState() => _GallariesState();
}

class _GallariesState extends State<Gallaries> {
  List<Sliders> ads;
  List<Gallery> _data;

  @override
  void initState() {
    API(context).get('homeAds').then((value) {
      if (value != null) {
        setState(() {
          ads = Ads.fromJson(value).Rsliders;
        });
      }
    });
    API(context).get('gallery').then((value) {
      // TODO: implement initState
      // TODO: implement initState

      if (value != null) {
        setState(() {
          _data = Gallery_model.fromJson(value).data;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarCustom(isback: true),
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
                          autoPlayInterval: Duration(seconds: 3),
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
            _data == null
                ? Container()
                : ResponsiveGridList(
                    desiredItemWidth: ScreenUtil.getWidth(context) / 2.4,
                    minSpacing: 10,
                    //rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    scroll: false,
                    children: _data
                        .map((e) => Padding(
                              padding:
                                  const EdgeInsets.only(right: 4, bottom: 4),
                              child: buildCategoryItemCard(e),
                            ))
                        .toList()),
          ],
        ),
      ),
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
