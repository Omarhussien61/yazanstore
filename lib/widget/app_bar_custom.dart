import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/SearchOverlay.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AppBarCustom extends StatefulWidget {
    bool isback ;
    String title ;
     AppBarCustom({this.isback=false,this.title});

  @override
  _AppBarCustomState createState() => _AppBarCustomState();

}

class _AppBarCustomState extends State<AppBarCustom> {
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Container(
      height: ScreenUtil.getHeight(context) / 7,
      padding: const EdgeInsets.only(top: 35),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
           ! widget.isback?Container():IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
              ),
              color: themeColor.getColor(),
            ),
           widget.title!=null? Container(
             width: ScreenUtil.getWidth(context) / 2,
             child: AutoSizeText(
               '${widget.title}',
               maxLines: 2,
               maxFontSize: 15,
               minFontSize: 10,
               overflow: TextOverflow.ellipsis,
               style: TextStyle(color: themeColor.getColor()),
             ),
           ):
           InkWell(
             onTap: (){
               Phoenix.rebirth(context);
             },
             child: Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: ScreenUtil.getHeight(context) / 18,
                  width: ScreenUtil.getWidth(context) / 4,
                  fit: BoxFit.contain,
                ),
              ),
           ),
            Expanded(child: Container()),
            IconButton(
              onPressed: () {
                showDialog(context: context, builder: (_) => SearchOverlay());
              },
              icon: Icon(
                Icons.search,
                size: 30,
              ),
              color: themeColor.getColor(),
            ),
            SizedBox(width: 10,)
          ],
        ),
      ),
    );
  }
}
