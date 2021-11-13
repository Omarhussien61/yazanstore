import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:provider/provider.dart';

class Custom_Loading extends StatelessWidget {
  const Custom_Loading({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Container(
      height: ScreenUtil.getHeight(context) / 4,
      width: ScreenUtil.getWidth(context) / 1.5,
      child: Center(
          child: CircularProgressIndicator(
        backgroundColor: themeColor.getColor(),
        valueColor: AlwaysStoppedAnimation(Colors.white),
      )),
    );
  }
}
