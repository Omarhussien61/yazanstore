import 'package:flutter/material.dart';

class ScreenUtil {
  static getSize(context) {
    return MediaQuery.of(context).size;
  }

  static getWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(context) {
    return MediaQuery.of(context).size.height;
  }

  static double setWidth(context, double wid) {
    return MediaQuery.of(context).size.width * wid;
  }

  static double setHeight(context, double hei) {
    return MediaQuery.of(context).size.height * hei;
  }

  static double getTxtSz(BuildContext context, double value) {
    return (value / 812) * MediaQuery.of(context).size.height;
  }

  static divideHeight(context, {divided = 1}) {
    return MediaQuery.of(context).size.height / divided;
  }

  static divideWidth(context, {divided = 1}) {
    return MediaQuery.of(context).size.width / divided;
  }
}
