import 'package:flutter/material.dart';
import 'package:flutter_pos/model/app-config.dart';
import 'package:flutter_pos/model/category_model.dart';
import 'package:flutter_pos/screens/product/products_page.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/app_bar_custom.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';

class CategoryList extends StatefulWidget {
  String name;

  CategoryList(this.name);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
          ResponsiveGridList(

              desiredItemWidth: ScreenUtil.getWidth(context)/2.2,
              minSpacing: 10,
              //rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
              scroll: false,
              children: themeData.categories.map((e) =>Padding(
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

  Container buildCategoryItemCard(Categories categoryResponse) {
    final themeColor = Provider.of<Provider_control>(context);

    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          // Set border width
            borderRadius: BorderRadius.all(
                Radius.circular(10.0)), // Set rounded corner radius
            boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black12,offset: Offset(1,3))] // Make rounded corner of border
        ),
      child: InkWell(
        onTap: () {
          Nav.route(
              context,
              Products_Page(
                id: categoryResponse.id,
                name:themeColor.getlocal()=='ar'? categoryResponse.nameAr:categoryResponse.name,
                Url: "products/category/${categoryResponse.id}",
              ));
        },
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Container(
              width: ScreenUtil.getWidth(context)/5,
              height: 80,
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/load.gif',
                    image:
                        "${AppConfig.BASE_PATH}categories/${categoryResponse.image}",
                    fit: BoxFit.cover,
                  ))),
          Container(
            width: ScreenUtil.getWidth(context)/2,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 8, 16),
              child: Center(
                child: Text(
                  "${themeColor.getlocal()=='ar'? categoryResponse.nameAr:categoryResponse.name}",
                  textAlign: themeColor.getlocal()=='ar'?TextAlign.right:TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      height: 1.6,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

}
