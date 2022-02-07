import 'package:flutter_pos/model/app-config.dart';

class ProductModel {
  ProductModel({
    this.products,
    this.success,
    this.status,
  });

  List<Product> products;
  bool success;
  int status;

  factory ProductModel.fromJson(List json) => ProductModel(
        products: List<Product>.from(json.map((x) => Product.fromJson(x))),

        //  meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        success: true,
        status: 200,
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(products.map((x) => x.toJson())),
        "success": success,
        "status": status,
      };
}

class Product {
  int _id;
  String _sku;
  String _productType;
  dynamic _affiliateLink;
  int _userId;
  int _categoryId;
  int _subcategoryId;
  int _childcategoryId;
  dynamic _attributes;
  String _name;
  dynamic _nameAr;
  String _slug;
  String _photo;
  bool Loading = false;
  String _thumbnail;
  dynamic _file;
  List<String> _size;
  List<String> _sizeQty;
  List<String> _sizePrice;
  String _color;
  String _price;
  String _previousPrice;
  String _details;
  dynamic _detailsAr;
  String _stock;
  String _policy;
  String _status;
  String _views;
  String _tags;
  String _features;
  List<dynamic> _colors;
  List<String> _galleries;
  String _productCondition;
  dynamic _ship;
  String _isMeta;
  String _metaTag;
  dynamic _metaDescription;
  dynamic _youtube;
  String _type;
  String _license;
  String _licenseQty;
  dynamic _link;
  dynamic _platform;
  dynamic _region;
  dynamic _licenceType;
  dynamic _measure;
  String _featured;
  String _best;
  String _top;
  String _hot;
  String _latest;
  String _big;
  String _trending;
  String _sale;
  String _createdAt;
  String _updatedAt;
  String _isDiscount;
  dynamic _discountDate;
  String _wholeSellQty;
  String _wholeSellDiscount;
  String _isCatalog;
  String _catalogId;
  dynamic _mazadPeriod;
  dynamic _mazadStartDate;
  dynamic _mazadEndDate;
  String _mailSent;
  String _shippingCost;
  User _user;
  List<Ratings> _ratings;

  int get id => _id;
  String get sku => _sku;
  String get productType => _productType;
  dynamic get affiliateLink => _affiliateLink;
  int get userId => _userId;
  int get categoryId => _categoryId;
  int get subcategoryId => _subcategoryId;
  int get childcategoryId => _childcategoryId;
  dynamic get attributes => _attributes;
  String get name => _name;
  dynamic get nameAr => _nameAr;
  String get slug => _slug;
  String get photo => _photo ?? '';
  String get thumbnail => _thumbnail;
  dynamic get file => _file;
  List<String> get size => _size;
  List<String> get sizeQty => _sizeQty;
  List<String> get sizePrice => _sizePrice;
  String get color => _color;
  String get price => _price;
  String get previousPrice => _previousPrice;
  String get details => _details.toString();
  dynamic get detailsAr => _detailsAr.toString();
  String get stock => _stock;
  String get policy => _policy;
  String get status => _status;
  String get tags => _tags;
  String get features => _features;
  List<String> get colors => _colors;
  List<String> get galleries => _galleries;
  String get productCondition => _productCondition;
  dynamic get ship => _ship;
  String get isMeta => _isMeta;
  String get metaTag => _metaTag;
  dynamic get metaDescription => _metaDescription;
  dynamic get youtube => _youtube;
  String get type => _type;
  String get license => _license;
  String get licenseQty => _licenseQty;
  dynamic get link => _link;
  dynamic get platform => _platform;
  dynamic get region => _region;
  dynamic get licenceType => _licenceType;
  dynamic get measure => _measure;
  String get featured => _featured;
  String get best => _best;
  String get top => _top;
  String get hot => _hot;
  String get latest => _latest;
  String get big => _big;
  String get trending => _trending;
  String get sale => _sale;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get isDiscount => _isDiscount;
  dynamic get discountDate => _discountDate;
  String get wholeSellQty => _wholeSellQty;
  String get wholeSellDiscount => _wholeSellDiscount;
  String get isCatalog => _isCatalog;
  String get catalogId => _catalogId;
  dynamic get mazadPeriod => _mazadPeriod;
  dynamic get mazadStartDate => _mazadStartDate;
  String get mazadEndDate => _mazadEndDate;
  String get mailSent => _mailSent;
  String get shippingCost => _shippingCost;
  User get user => _user;
  List<Ratings> get ratings => _ratings;

  Product(
      {int id,
      String sku,
      String productType,
      dynamic affiliateLink,
      int userId,
      int categoryId,
      int subcategoryId,
      int childcategoryId,
      dynamic attributes,
      String name,
      dynamic nameAr,
      String slug,
      String photo,
      String thumbnail,
      dynamic file,
      List<String> size,
      List<String> sizeQty,
      List<String> sizePrice,
      String color,
      String price,
      String previousPrice,
      String details,
      dynamic detailsAr,
      String stock,
      String policy,
      String status,
      String views,
      String tags,
      String features,
      List<String> colors,
      List<String> galleries,
      String productCondition,
      dynamic ship,
      String isMeta,
      String metaTag,
      dynamic metaDescription,
      dynamic youtube,
      String type,
      String license,
      String licenseQty,
      dynamic link,
      dynamic platform,
      dynamic region,
      dynamic licenceType,
      dynamic measure,
      String featured,
      String best,
      String top,
      String hot,
      String latest,
      String big,
      String trending,
      String sale,
      String createdAt,
      String updatedAt,
      String isDiscount,
      dynamic discountDate,
      String wholeSellQty,
      String wholeSellDiscount,
      String isCatalog,
      String catalogId,
      dynamic mazadPeriod,
      dynamic mazadStartDate,
      dynamic mazadEndDate,
      String mailSent,
      String shippingCost,
      User user,
      List<Ratings> ratings}) {
    _id = id;
    _sku = sku;
    _productType = productType;
    _affiliateLink = affiliateLink;
    _userId = userId;
    _categoryId = categoryId;
    _subcategoryId = subcategoryId;
    _childcategoryId = childcategoryId;
    _attributes = attributes;
    _name = name;
    _nameAr = nameAr;
    _slug = slug;
    _photo = photo;
    _thumbnail = thumbnail;
    _file = file;
    _size = size;
    _sizeQty = sizeQty;
    _sizePrice = sizePrice;
    _color = color;
    _price = price;
    _previousPrice = previousPrice;
    _details = details;
    _detailsAr = detailsAr;
    _stock = stock;
    _policy = policy;
    _status = status;
    _views = views;
    _tags = tags;
    _features = features;
    _colors = colors;
    _productCondition = productCondition;
    _ship = ship;
    _isMeta = isMeta;
    _metaTag = metaTag;
    _metaDescription = metaDescription;
    _youtube = youtube;
    _type = type;
    _license = license;
    _licenseQty = licenseQty;
    _link = link;
    _platform = platform;
    _region = region;
    _licenceType = licenceType;
    _measure = measure;
    _featured = featured;
    _best = best;
    _top = top;
    _hot = hot;
    _latest = latest;
    _big = big;
    _trending = trending;
    _sale = sale;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _isDiscount = isDiscount;
    _discountDate = discountDate;
    _wholeSellQty = wholeSellQty;
    _wholeSellDiscount = wholeSellDiscount;
    _isCatalog = isCatalog;
    _catalogId = catalogId;
    _mazadPeriod = mazadPeriod;
    _mazadStartDate = mazadStartDate;
    _mazadEndDate = mazadEndDate;
    _mailSent = mailSent;
    _shippingCost = shippingCost;
    _user = user;
    _ratings = ratings;
  }

  Product.fromJson(dynamic json) {
    _id = json["id"];
    _sku = json["sku"];
    _productType = json["product_type"];
    _affiliateLink = json["affiliate_link"];
    _userId = int.tryParse(json["user_id"]);
    _categoryId = int.tryParse(json["category_id"]);
    _subcategoryId = int.tryParse(json["subcategory_id"] ?? '') ?? null;
//    _childcategoryId = int.tryParse(json["childcategory_id"]) ?? 0;
    _attributes = json["attributes"];
    _name = json["name"];
    _nameAr = json["name_ar"];
    _slug = json["slug"];
    _photo = json["photo"];
    _thumbnail = json["thumbnail"];
    _file = json["file"];
    //_size = json["size"];
    //_sizeQty = json["size_qty"];
    // _sizePrice = json["size_price"];
    //_color = json["color"];
    _price = json["price"].toString();
    _previousPrice = json["previous_price"];
    _details = json["details"];
    _detailsAr = json["details_ar"];
    _stock = json["stock"];
    _policy = json["policy"];
    _status = json["status"];
    _views = json["views"].toString();
    //_tags = json["tags"];
    //_features = json["features"];
    if (json["color"] != null) {
      _colors = [];
      json["color"].forEach((v) {
        _colors.add("$v");
      });
    }
    if (json["size"] != null) {
      _size = [];
      json["size"].forEach((v) {
        _size.add("$v");
      });
    }
    if (json["size_qty"] != null) {
      _sizeQty = [];
      json["size_qty"].forEach((v) {
        _sizeQty.add("$v");
      });
    }
    if (json["size_price"] != null) {
      _sizePrice = [];
      json["size_price"].forEach((v) {
        _sizePrice.add("$v");
      });
    }
    json["color"].runtimeType == List ? _colors = json["color"] : null;
    _productCondition = json["product_condition"];
    _ship = json["ship"];
    _isMeta = json["is_meta"];
    //_metaTag = json["meta_tag"];
    _metaDescription = json["meta_description"];
    _youtube = json["youtube"];
    _type = json["type"];
    _license = json["license"];
    _licenseQty = json["license_qty"];
    _link = json["link"];
    _platform = json["platform"];
    _region = json["region"];
    _licenceType = json["licence_type"];
    _measure = json["measure"];
    _featured = json["featured"];
    _best = json["best"];
    _top = json["top"];
    _hot = json["hot"];
    _latest = json["latest"];
    _big = json["big"];
    _trending = json["trending"];
    _sale = json["sale"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _isDiscount = json["is_discount"];
    _discountDate = json["discount_date"].toString().replaceAll("-", '');
    print("_discountDate = ${_discountDate} ${json["discount_date"]}");
    //_wholeSellQty = json["whole_sell_qty"];
    //_wholeSellDiscount = json["whole_sell_discount"];
    _isCatalog = json["is_catalog"];
    _catalogId = json["catalog_id"];
    _mazadPeriod = json["mazad_period"];
    _mazadStartDate = json["mazad_start_date"];
    _mazadEndDate = json["mazad_end_date"];
    _mailSent = json["mail_sent"];

    _shippingCost = json["shipping_cost"];
    _user = json["user"] != null ? User.fromJson(json["user"]) : null;
    if (json["ratings"] != null) {
      _ratings = [];
      json["ratings"].forEach((v) {
        _ratings.add(Ratings.fromJson(v));
      });
    }
    if (json["galleries"] != null) {
      _galleries = [];
      json["galleries"].forEach((v) {
        _galleries.add("${AppConfig.BASE_PATH}galleries/${v['photo']}");
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["sku"] = _sku;
    map["product_type"] = _productType;
    map["affiliate_link"] = _affiliateLink;
    map["user_id"] = _userId;
    map["category_id"] = _categoryId;
    map["subcategory_id"] = _subcategoryId;
    map["childcategory_id"] = _childcategoryId;
    map["attributes"] = _attributes;
    map["name"] = _name;
    map["name_ar"] = _nameAr;
    map["slug"] = _slug;
    map["photo"] = _photo;
    map["thumbnail"] = _thumbnail;
    map["file"] = _file;
    map["size"] = _size;
    map["size_qty"] = _sizeQty;
    map["size_price"] = _sizePrice;
    map["color"] = _color;
    map["price"] = _price;
    map["previous_price"] = _previousPrice;
    map["details"] = _details;
    map["details_ar"] = _detailsAr;
    map["stock"] = _stock;
    map["policy"] = _policy;
    map["status"] = _status;
    map["views"] = _views;
    map["tags"] = _tags;
    map["features"] = _features;
    map["colors"] = _colors;
    map["product_condition"] = _productCondition;
    map["ship"] = _ship;
    map["is_meta"] = _isMeta;
    map["meta_tag"] = _metaTag;
    map["meta_description"] = _metaDescription;
    map["youtube"] = _youtube;
    map["type"] = _type;
    map["license"] = _license;
    map["license_qty"] = _licenseQty;
    map["link"] = _link;
    map["platform"] = _platform;
    map["region"] = _region;
    map["licence_type"] = _licenceType;
    map["measure"] = _measure;
    map["featured"] = _featured;
    map["best"] = _best;
    map["top"] = _top;
    map["hot"] = _hot;
    map["latest"] = _latest;
    map["big"] = _big;
    map["trending"] = _trending;
    map["sale"] = _sale;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["is_discount"] = _isDiscount;
    map["discount_date"] = _discountDate;
    map["whole_sell_qty"] = _wholeSellQty;
    map["whole_sell_discount"] = _wholeSellDiscount;
    map["is_catalog"] = _isCatalog;
    map["catalog_id"] = _catalogId;
    map["mazad_period"] = _mazadPeriod;
    map["mazad_start_date"] = _mazadStartDate;
    map["mazad_end_date"] = _mazadEndDate;
    map["mail_sent"] = _mailSent;
    map["shipping_cost"] = _shippingCost;
    if (_user != null) {
      map["user"] = _user.toJson();
    }
    if (_ratings != null) {
      map["ratings"] = _ratings.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// user_id : 110
/// product_id : 3
/// review : "ddddd"
/// rating : 5
/// review_date : "2021-07-08 10:57:51"

class Ratings {
  int _id;
  String _userId;
  int _productId;
  String _review;
  int _rating;
  String _reviewDate;

  int get id => _id;
  String get userId => _userId;
  int get productId => _productId;
  String get review => _review;
  int get rating => _rating;
  String get reviewDate => _reviewDate;

  Ratings(
      {int id,
      String userId,
      int productId,
      String review,
      int rating,
      String reviewDate}) {
    _id = id;
    _userId = userId;
    _productId = productId;
    _review = review;
    _rating = rating;
    _reviewDate = reviewDate;
  }

  Ratings.fromJson(dynamic json) {
    _id = json["id"];
    //_userId = json["user_id"]["name"];
    _productId = json["product_id"];
    _review = json["review"];
    _rating = json["rating"];
    _reviewDate = json["review_date"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["user_id"] = _userId;
    map["product_id"] = _productId;
    map["review"] = _review;
    map["rating"] = _rating;
    map["review_date"] = _reviewDate;
    return map;
  }
}

/// id : 259
/// name : "mostafa mostafa"
/// photo : null
/// user_cover : null
/// zip : null
/// city : null
/// country : null
/// address : "kafer elgazzar"
/// address2 : null
/// phone : "01224707846"
/// phone_token : ""
/// fax : null
/// email : "mostafazeid@outlook.com"
/// created_at : "2021-06-01T13:41:50.000000Z"
/// updated_at : "2021-06-01T13:42:38.000000Z"
/// is_provider : 0
/// status : 0
/// verification_link : "1b769481dcb3101d82095d891b77827f"
/// email_verified : "Yes"
/// affilate_code : "ec56ba2b092f96534ce7f261a3c13ef3"
/// affilate_income : 0
/// shop_name : null
/// owner_name : null
/// shop_number : null
/// shop_address : null
/// reg_number : null
/// shop_message : null
/// shop_details : null
/// shop_image : null
/// f_url : null
/// g_url : null
/// t_url : null
/// l_url : null
/// is_vendor : 1
/// f_check : 0
/// g_check : 0
/// t_check : 0
/// l_check : 0
/// mail_sent : 0
/// shipping_cost : 0
/// current_balance : 0
/// date : null
/// ban : 0
/// is_store_owner : 0
/// is_delivery : 0
/// photo_id : null
/// car_owner : null
/// photo_id1 : null
/// photo_id2 : null
/// photo_id3 : null
/// photo_id4 : null
/// realpassword : null
/// is_own_shipping : 0

class User {
  String _id;
  String _name;
  dynamic _photo;
  dynamic _userCover;
  dynamic _zip;
  dynamic _city;
  dynamic _country;
  String _address;
  dynamic _address2;
  String _phone;
  String _phoneToken;
  dynamic _fax;
  String _email;
  String _createdAt;
  String _updatedAt;
  String _isProvider;
  String _status;
  String _verificationLink;
  String _emailVerified;
  String _affilateCode;
  String _affilateIncome;
  dynamic _shopName;
  dynamic _ownerName;
  dynamic _shopNumber;
  dynamic _shopAddress;
  dynamic _regNumber;
  dynamic _shopMessage;
  dynamic _shopDetails;
  dynamic _shopImage;
  dynamic _fUrl;
  dynamic _gUrl;
  dynamic _tUrl;
  dynamic _lUrl;
  String _isVendor;
  String _fCheck;
  String _gCheck;
  String _tCheck;
  String _lCheck;
  String _mailSent;
  String _shippingCost;
  String _currentBalance;
  dynamic _date;
  String _ban;
  String _isStoreOwner;
  String _isDelivery;
  dynamic _photoId;
  dynamic _carOwner;
  dynamic _photoId1;
  dynamic _photoId2;
  dynamic _photoId3;
  dynamic _photoId4;
  dynamic _realpassword;
  String _isOwnShipping;

  String get id => _id;
  String get name => _name;
  dynamic get photo => _photo;
  dynamic get userCover => _userCover;
  dynamic get zip => _zip;
  dynamic get city => _city;
  dynamic get country => _country;
  String get address => _address;
  dynamic get address2 => _address2;
  String get phone => _phone;
  String get phoneToken => _phoneToken;
  dynamic get fax => _fax;
  String get email => _email;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get isProvider => _isProvider;
  String get status => _status;
  String get verificationLink => _verificationLink;
  String get emailVerified => _emailVerified;
  String get affilateCode => _affilateCode;
  String get affilateIncome => _affilateIncome;
  dynamic get shopName => _shopName;
  dynamic get ownerName => _ownerName;
  dynamic get shopNumber => _shopNumber;
  dynamic get shopAddress => _shopAddress;
  dynamic get regNumber => _regNumber;
  dynamic get shopMessage => _shopMessage;
  dynamic get shopDetails => _shopDetails;
  dynamic get shopImage => _shopImage;
  dynamic get fUrl => _fUrl;
  dynamic get gUrl => _gUrl;
  dynamic get tUrl => _tUrl;
  dynamic get lUrl => _lUrl;
  String get isVendor => _isVendor;
  String get fCheck => _fCheck;
  String get gCheck => _gCheck;
  String get tCheck => _tCheck;
  String get lCheck => _lCheck;
  String get mailSent => _mailSent;
  String get shippingCost => _shippingCost;
  String get currentBalance => _currentBalance;
  dynamic get date => _date;
  String get ban => _ban;
  String get isStoreOwner => _isStoreOwner;
  String get isDelivery => _isDelivery;
  dynamic get photoId => _photoId;
  dynamic get carOwner => _carOwner;
  dynamic get photoId1 => _photoId1;
  dynamic get photoId2 => _photoId2;
  dynamic get photoId3 => _photoId3;
  dynamic get photoId4 => _photoId4;
  dynamic get realpassword => _realpassword;
  String get isOwnShipping => _isOwnShipping;

  User(
      {String id,
      String name,
      dynamic photo,
      dynamic userCover,
      dynamic zip,
      dynamic city,
      dynamic country,
      String address,
      dynamic address2,
      String phone,
      String phoneToken,
      dynamic fax,
      String email,
      String createdAt,
      String updatedAt,
      String isProvider,
      String status,
      String verificationLink,
      String emailVerified,
      String affilateCode,
      String affilateIncome,
      dynamic shopName,
      dynamic ownerName,
      dynamic shopNumber,
      dynamic shopAddress,
      dynamic regNumber,
      dynamic shopMessage,
      dynamic shopDetails,
      dynamic shopImage,
      dynamic fUrl,
      dynamic gUrl,
      dynamic tUrl,
      dynamic lUrl,
      String isVendor,
      String fCheck,
      String gCheck,
      String tCheck,
      String lCheck,
      String mailSent,
      String shippingCost,
      String currentBalance,
      dynamic date,
      String ban,
      String isStoreOwner,
      String isDelivery,
      dynamic photoId,
      dynamic carOwner,
      dynamic photoId1,
      dynamic photoId2,
      dynamic photoId3,
      dynamic photoId4,
      dynamic realpassword,
      String isOwnShipping}) {
    _id = id;
    _name = name;
    _photo = photo;
    _userCover = userCover;
    _zip = zip;
    _city = city;
    _country = country;
    _address = address;
    _address2 = address2;
    _phone = phone;
    _phoneToken = phoneToken;
    _fax = fax;
    _email = email;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _isProvider = isProvider;
    _status = status;
    _verificationLink = verificationLink;
    _emailVerified = emailVerified;
    _affilateCode = affilateCode;
    _affilateIncome = affilateIncome;
    _shopName = shopName;
    _ownerName = ownerName;
    _shopNumber = shopNumber;
    _shopAddress = shopAddress;
    _regNumber = regNumber;
    _shopMessage = shopMessage;
    _shopDetails = shopDetails;
    _shopImage = shopImage;
    _fUrl = fUrl;
    _gUrl = gUrl;
    _tUrl = tUrl;
    _lUrl = lUrl;
    _isVendor = isVendor;
    _fCheck = fCheck;
    _gCheck = gCheck;
    _tCheck = tCheck;
    _lCheck = lCheck;
    _mailSent = mailSent;
    _shippingCost = shippingCost;
    _currentBalance = currentBalance;
    _date = date;
    _ban = ban;
    _isStoreOwner = isStoreOwner;
    _isDelivery = isDelivery;
    _photoId = photoId;
    _carOwner = carOwner;
    _photoId1 = photoId1;
    _photoId2 = photoId2;
    _photoId3 = photoId3;
    _photoId4 = photoId4;
    _realpassword = realpassword;
    _isOwnShipping = isOwnShipping;
  }

  User.fromJson(dynamic json) {
    _id = json["id"].toString();
    _name = json["name"];
    _photo = json["photo"];
    _userCover = json["user_cover"];
    _zip = json["zip"];
    _city = json["city"];
    _country = json["country"];
    _address = json["address"];
    _address2 = json["address2"];
    _phone = json["phone"];
    _phoneToken = json["phone_token"];
    _fax = json["fax"];
    _email = json["email"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _isProvider = json["is_provider"];
    _status = json["status"];
    _verificationLink = json["verification_link"];
    _emailVerified = json["email_verified"];
    _affilateCode = json["affilate_code"];
    _affilateIncome = json["affilate_income"];
    _shopName = json["shop_name"];
    _ownerName = json["owner_name"];
    _shopNumber = json["shop_number"];
    _shopAddress = json["shop_address"];
    _regNumber = json["reg_number"];
    _shopMessage = json["shop_message"];
    _shopDetails = json["shop_details"];
    _shopImage = json["shop_image"];
    _fUrl = json["f_url"];
    _gUrl = json["g_url"];
    _tUrl = json["t_url"];
    _lUrl = json["l_url"];
    _isVendor = json["is_vendor"];
    _fCheck = json["f_check"];
    _gCheck = json["g_check"];
    _tCheck = json["t_check"];
    _lCheck = json["l_check"];
    _mailSent = json["mail_sent"];
    _shippingCost = json["shipping_cost"];
    _currentBalance = json["current_balance"];
    _date = json["date"];
    _ban = json["ban"];
    _isStoreOwner = json["is_store_owner"];
    _isDelivery = json["is_delivery"];
    _photoId = json["photo_id"];
    _carOwner = json["car_owner"];
    _photoId1 = json["photo_id1"];
    _photoId2 = json["photo_id2"];
    _photoId3 = json["photo_id3"];
    _photoId4 = json["photo_id4"];
    _realpassword = json["realpassword"];
    _isOwnShipping = json["is_own_shipping"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["photo"] = _photo;
    map["user_cover"] = _userCover;
    map["zip"] = _zip;
    map["city"] = _city;
    map["country"] = _country;
    map["address"] = _address;
    map["address2"] = _address2;
    map["phone"] = _phone;
    map["phone_token"] = _phoneToken;
    map["fax"] = _fax;
    map["email"] = _email;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["is_provider"] = _isProvider;
    map["status"] = _status;
    map["verification_link"] = _verificationLink;
    map["email_verified"] = _emailVerified;
    map["affilate_code"] = _affilateCode;
    map["affilate_income"] = _affilateIncome;
    map["shop_name"] = _shopName;
    map["owner_name"] = _ownerName;
    map["shop_number"] = _shopNumber;
    map["shop_address"] = _shopAddress;
    map["reg_number"] = _regNumber;
    map["shop_message"] = _shopMessage;
    map["shop_details"] = _shopDetails;
    map["shop_image"] = _shopImage;
    map["f_url"] = _fUrl;
    map["g_url"] = _gUrl;
    map["t_url"] = _tUrl;
    map["l_url"] = _lUrl;
    map["is_vendor"] = _isVendor;
    map["f_check"] = _fCheck;
    map["g_check"] = _gCheck;
    map["t_check"] = _tCheck;
    map["l_check"] = _lCheck;
    map["mail_sent"] = _mailSent;
    map["shipping_cost"] = _shippingCost;
    map["current_balance"] = _currentBalance;
    map["date"] = _date;
    map["ban"] = _ban;
    map["is_store_owner"] = _isStoreOwner;
    map["is_delivery"] = _isDelivery;
    map["photo_id"] = _photoId;
    map["car_owner"] = _carOwner;
    map["photo_id1"] = _photoId1;
    map["photo_id2"] = _photoId2;
    map["photo_id3"] = _photoId3;
    map["photo_id4"] = _photoId4;
    map["realpassword"] = _realpassword;
    map["is_own_shipping"] = _isOwnShipping;
    return map;
  }
}
