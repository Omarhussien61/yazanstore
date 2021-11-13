import 'package:flutter/material.dart';

class Provider_control with ChangeNotifier {
  Color _themeData = Color(0xff2FB7EC); //Color.fromRGBO(199, 154, 71, 1);
  String local;
  String car_made = 'إختر المركبة';
  int car_type = 1;
  Color color;
  bool isLogin = false;

  String aboutUs;
  String privacy;
  String terms;

  setAboutUs(String data) {
    aboutUs = data;
    notifyListeners();
  }

  setPrivacy(String data) {
    privacy = data;
    notifyListeners();
  }

  setTerms(String data) {
    terms = data;
    notifyListeners();
  }

  Provider_control(this.local) {
    if (this.local == 'en') {
      car_made = 'Select Car';
    } else if (this.local == 'ar') {
      car_made = 'إختر المركبة';
    }
  }
  getColor() => _themeData;
  getCar_made() => car_made;
  getcar_type() => car_type;
  getlocal() => local;

  setCar_made(String Car_made) async {
    car_made = Car_made;
    notifyListeners();
  }

  setCar_type(int Car_type) async {
    car_type = Car_type;
    notifyListeners();
  }

  setColor(Color themeData) async {
    _themeData = themeData;
    notifyListeners();
  }

  setLogin(bool isLog) {
    isLogin = isLog;
    notifyListeners();
  }

  setLocal(String st) {
    local = st;
    if (st == 'en') {
      car_made = 'Select Car';
    } else if (st == 'ar') {
      car_made = 'إختر المركبة';
    }
    notifyListeners();
  }
}
