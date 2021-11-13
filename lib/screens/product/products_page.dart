import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/screens/product/Filter.dart';
import 'package:flutter_pos/screens/product/Sort.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/widget/List/gridview.dart';
import 'package:flutter_pos/widget/List/listview.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/app_bar_custom.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/no_found_product.dart';
import 'package:provider/provider.dart';

class Products_Page extends StatefulWidget {
  int id;
  String name;
  String Url;

  Products_Page({this.id, this.name, this.Url});

  @override
  _Products_PageState createState() => _Products_PageState();
}

class _Products_PageState extends State<Products_Page> {
  List<Product> product;
  bool list = false;
  String sort = 'ASC&ordered_by=price';
  @override
  void initState() {
    print(widget.Url);
    API(context).get(widget.Url).then((value) {
      if (value != null) {
        setState(() {
          product = ProductModel.fromJson(value['data']).products;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppBarCustom(
            isback: true,
            title: widget.name,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  product == null
                      ? Custom_Loading()
                      : product.isEmpty
                          ? NotFoundProduct()
                          : grid_product(
                              product: product,
                            ),
                  SizedBox(
                    height: 25,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
