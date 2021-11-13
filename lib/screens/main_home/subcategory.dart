import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/app-config.dart';
import 'package:flutter_pos/model/category_model.dart';
import 'package:flutter_pos/model/gallery_model.dart';
import 'package:flutter_pos/screens/product/products_page.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/app_bar_custom.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';

class Subcategory extends StatefulWidget {
  String name;
  List<Subs>  _data;

  Subcategory(this.name,this._data);

  @override
  _SubcategoryState createState() => _SubcategoryState();
}

class _SubcategoryState extends State<Subcategory> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {

   super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        // drawer: MainDrawer(),
        backgroundColor: Colors.white,
        body:buildCategoryList(context));
  }



  buildCategoryList(BuildContext context) {
    final themeData = Provider.of<Provider_Data>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          AppBarCustom(
            isback: true,
            title: widget.name,
          ),
          widget._data==null?Custom_Loading():ResponsiveGridList(

        desiredItemWidth: ScreenUtil.getWidth(context)/2.2,
    minSpacing: 10,
    //rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
    scroll: false,
    children: widget._data.map((e) =>Padding(
    padding: const EdgeInsets.only(right: 4, bottom: 4),
    child:  Padding(
                padding: const EdgeInsets.only(
                    top: 4.0, bottom: 4.0, left: 2.0, right: 2.0),
                child: buildCategoryItemCard(e),
              ))).toList()

          ),
        ],
      ),
    );
  }

  Widget buildCategoryItemCard(Subs categoryResponse) {
    final themeColor = Provider.of<Provider_control>(context);

    return InkWell(
      onTap: (){
        Nav.route(
            context,
            Products_Page(
              id: categoryResponse.categoryId,
              name:themeColor.getlocal()=='ar'? categoryResponse.nameAr:categoryResponse.name,
              Url: "products/category/${categoryResponse.categoryId}",
            ));
      },
      child: Container(
margin: EdgeInsets.all(1),
padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: Colors.white,
            // Set border width
            borderRadius: BorderRadius.all(
                Radius.circular(10.0)), // Set rounded corner radius
            boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black12,offset: Offset(1,3))] // Make rounded corner of border
        ),

        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Container(
             width: ScreenUtil.getWidth(context)/2.1,
              height: ScreenUtil.getHeight(context)/10,
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  child: CachedNetworkImage(
                    width: ScreenUtil.getWidth(context) / 1.5,
                    height: ScreenUtil.getHeight(context) / 10,
                    imageUrl:
                    "https://qafeer.net/assets/front/images/store-vendors/${categoryResponse.photo}",
                    errorWidget: (context, url, error) =>
                        Image.asset("assets/load.gif",),
                    fit: BoxFit.contain,
                  ))),
          Padding(
            padding: EdgeInsets.fromLTRB(2, 8, 8, 0),
            child: Text(
              "${themeColor.getlocal()=='ar'? categoryResponse.nameAr:categoryResponse.name}",
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
