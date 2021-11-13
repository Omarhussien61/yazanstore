/// status_code : 200
/// message : "success"
/// data : [{"id":18,"category_id":20,"name":"Car rental exhibition","name_ar":"معرض تأجير السيارات","slug":"store-of-rent-cars","photo":"https://qafeer.net/assets/front/images/store-vendors/store-of-rent-cars.jpg","url":"https://qafeer.net/category/stores/store-of-rent-cars","status":1},{"id":19,"category_id":20,"name":"Used products exhibition","name_ar":"معرض السيارات","slug":"store-of-used","photo":"https://qafeer.net/assets/front/images/store-vendors/store-of-used.jpg","url":"https://qafeer.net/category/stores/store-of-used","status":1},{"id":20,"category_id":20,"name":"Popular Food Gallery","name_ar":"معرض المأكولات الشعبية","slug":"store-of-popular-cooking","photo":"https://qafeer.net/assets/front/images/store-vendors/store-of-popular-cooking.jpg","url":"https://qafeer.net/category/stores/store-of-popular-cooking","status":1},{"id":21,"category_id":20,"name":"Omani Sweets Gallery","name_ar":"معرض الحلوى العمانيه","slug":"store-of-sweets","photo":"https://qafeer.net/assets/front/images/store-vendors/store-of-sweets.jpg","url":"https://qafeer.net/category/stores/store-of-sweets","status":1},{"id":22,"category_id":20,"name":"Mares Gallery","name_ar":"معرض المعاريس","slug":"store-of-maress","photo":"https://qafeer.net/assets/front/images/store-vendors/store-of-maress.jpg","url":"https://qafeer.net/category/stores/store-of-maress","status":1},{"id":23,"category_id":20,"name":"Gallery of lounges and halls","name_ar":"معرض الاستراحات والقاعات","slug":"store-of-rest","photo":"https://qafeer.net/assets/front/images/store-vendors/store-of-rest.jpg","url":"https://qafeer.net/category/stores/store-of-rest","status":1},{"id":24,"category_id":20,"name":"Honey and dates store","name_ar":"معرض العسل والتمور","slug":"store-of-twomowr","photo":"https://qafeer.net/assets/front/images/store-vendors/store-of-twomowr.jpg","url":"https://qafeer.net/category/stores/store-of-twomowr","status":1}]

class Gallery_model {
  int _statusCode;
  String _message;
  List<Gallery> _data;

  int get statusCode => _statusCode;
  String get message => _message;
  List<Gallery> get data => _data;

  Gallery_model({int statusCode, String message, List<Gallery> data}) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  Gallery_model.fromJson(dynamic json) {
    _statusCode = json["status_code"];
    _message = json["message"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Gallery.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status_code"] = _statusCode;
    map["message"] = _message;
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 18
/// category_id : 20
/// name : "Car rental exhibition"
/// name_ar : "معرض تأجير السيارات"
/// slug : "store-of-rent-cars"
/// photo : "https://qafeer.net/assets/front/images/store-vendors/store-of-rent-cars.jpg"
/// url : "https://qafeer.net/category/stores/store-of-rent-cars"
/// status : 1

class Gallery {
  int _id;
  int _categoryId;
  String _name;
  String _nameAr;
  String _slug;
  String _photo;
  String _url;
  int _status;

  int get id => _id;
  int get categoryId => _categoryId;
  String get name => _name;
  String get nameAr => _nameAr;
  String get slug => _slug;
  String get photo => _photo;
  String get url => _url;
  int get status => _status;

  Gallery(
      {int id,
      int categoryId,
      String name,
      String nameAr,
      String slug,
      String photo,
      String url,
      int status}) {
    _id = id;
    _categoryId = categoryId;
    _name = name;
    _nameAr = nameAr;
    _slug = slug;
    _photo = photo;
    _url = url;
    _status = status;
  }

  Gallery.fromJson(dynamic json) {
    print(json["photo"]);
    _id = json["id"];
    _categoryId = int.tryParse(json["category_id"]);
    _name = json["name"];
    _nameAr = json["name_ar"];
    _slug = json["slug"];
    _photo = json["photo"];
    _url = json["url"];
    _status = int.parse(json["status"]);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["category_id"] = _categoryId;
    map["name"] = _name;
    map["name_ar"] = _nameAr;
    map["slug"] = _slug;
    map["photo"] = _photo;
    map["url"] = _url;
    map["status"] = _status;
    return map;
  }
}
