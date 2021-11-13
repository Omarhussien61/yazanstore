import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/screens/product/ProductPage.dart';
import 'package:flutter_pos/screens/product/products_page.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:provider/provider.dart';

class Banner_item extends StatelessWidget {
  const Banner_item({Key key, this.item, this.text}) : super(key: key);
  final String item;
  final String text;

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return InkWell(
      onTap: () {

      },
      child: Container(
        width: ScreenUtil.getWidth(context) / 1,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: item,
                fit: BoxFit.fill,
              ),
              text==null?Container() :    Positioned(
                bottom: 1,
                child: Container(
                  width: ScreenUtil.getWidth(context) / 1,
                  color: Colors.black38,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "$text",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
