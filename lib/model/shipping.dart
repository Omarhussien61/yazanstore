/// status_code : 200
/// message : "success"
/// data : {"shipping_data":[{"id":1,"user_id":0,"title":"شحن","subtitle":"(2 - 7 يوم)","price":2},{"id":2,"user_id":0,"title":"شحن سريع","subtitle":"(1 - 4 يوم)","price":5}],"package_data":[{"id":1,"user_id":0,"title":"تغليف عادي","subtitle":"التعبئة التلقائية حسب المتج","price":0},{"id":6,"user_id":0,"title":"تغليف قفير","subtitle":"تغليف قفير","price":10}]}

class Shipping_model {
  int _statusCode;
  String _message;
  Shipping _data;

  int get statusCode => _statusCode;
  String get message => _message;
  Shipping get data => _data;

  Shipping_model({int statusCode, String message, Shipping data}) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  Shipping_model.fromJson(dynamic json) {
    _statusCode = json["status_code"];
    _message = json["message"];
    _data = json["data"] != null ? Shipping.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status_code"] = _statusCode;
    map["message"] = _message;
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    return map;
  }
}

/// shipping_data : [{"id":1,"user_id":0,"title":"شحن","subtitle":"(2 - 7 يوم)","price":2},{"id":2,"user_id":0,"title":"شحن سريع","subtitle":"(1 - 4 يوم)","price":5}]
/// package_data : [{"id":1,"user_id":0,"title":"تغليف عادي","subtitle":"التعبئة التلقائية حسب المتج","price":0},{"id":6,"user_id":0,"title":"تغليف قفير","subtitle":"تغليف قفير","price":10}]

class Shipping {
  List<Shipping_data> _shippingData;
  List<Package_data> _packageData;

  List<Shipping_data> get shippingData => _shippingData;
  List<Package_data> get packageData => _packageData;

  Shipping({List<Shipping_data> shippingData, List<Package_data> packageData}) {
    _shippingData = shippingData;
    _packageData = packageData;
  }

  Shipping.fromJson(dynamic json) {
    if (json["shipping_data"] != null) {
      _shippingData = [];
      json["shipping_data"].forEach((v) {
        _shippingData.add(Shipping_data.fromJson(v));
      });
    }
    if (json["package_data"] != null) {
      _packageData = [];
      json["package_data"].forEach((v) {
        _packageData.add(Package_data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_shippingData != null) {
      map["shipping_data"] = _shippingData.map((v) => v.toJson()).toList();
    }
    if (_packageData != null) {
      map["package_data"] = _packageData.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// user_id : 0
/// title : "تغليف عادي"
/// subtitle : "التعبئة التلقائية حسب المتج"
/// price : 0

class Package_data {
  int _id;
  int _userId;
  String _title;
  String _title_en;
  String _subtitle;
  String _subtitle_en;
  int _price;

  int get id => _id;
  int get userId => _userId;
  String get title => _title;
  String get title_en => _title_en;
  String get subtitle => _subtitle;
  String get subtitle_en => _subtitle_en;
  int get price => _price;

  Package_data(
      {int id,
      int userId,
      String title,
      String title_en,
      String subtitle,
      String subtitle_en,
      int price}) {
    _id = id;
    _userId = userId;
    _title = title;
    _title_en = title_en;
    _subtitle = subtitle;
    _subtitle_en = subtitle_en;
    _price = price;
  }

  Package_data.fromJson(dynamic json) {
    _id = int.tryParse(json["id"]);
    _userId = int.tryParse(json["user_id"]);
    _title = json["title"];
    _title_en = json["title_en"];
    _subtitle = json["subtitle"];
    _subtitle_en = json["subtitle_en"];
    _price = int.tryParse(json["price"]);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["user_id"] = _userId;
    map["title"] = _title;
    map["subtitle"] = _subtitle;
    map["price"] = _price;
    return map;
  }
}

/// id : 1
/// user_id : 0
/// title : "شحن"
/// subtitle : "(2 - 7 يوم)"
/// price : 2

class Shipping_data {
  int _id;
  int _userId;
  String _title;
  String _title_en;
  String _subtitle;
  String _subtitle_en;
  int _price;

  int get id => _id;
  int get userId => _userId;
  String get title => _title;
  String get title_en => _title_en;
  String get subtitle => _subtitle;
  String get subtitle_en => _subtitle_en;
  int get price => _price;

  Shipping_data(
      {int id,
      int userId,
      String title,
      String subtitle,
      String subtitle_en,
      int price}) {
    _id = id;
    _userId = userId;
    _title = title;
    _title_en = title_en;
    _subtitle = subtitle;
    _subtitle_en = subtitle_en;
    _price = price;
  }

  Shipping_data.fromJson(dynamic json) {
    _id = int.tryParse(json["id"]);
    _userId = int.tryParse(json["user_id"]);
    _title = json["title"];
    _title_en = json["title_en"];
    _subtitle = json["subtitle"];
    _subtitle_en = json["subtitle_en"];
    _price = int.tryParse(json["price"]);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["user_id"] = _userId;
    map["title"] = _title;
    map["subtitle"] = _subtitle;
    map["price"] = _price;
    return map;
  }
}
