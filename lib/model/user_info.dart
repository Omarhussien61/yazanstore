class UserInformation {
  int statusCode;
  String message;
  USer data;

  UserInformation({this.statusCode, this.message, this.data});

  UserInformation.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != String ? new USer.fromJson(json['data']) : String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != String) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class USer {
  int id;
  String name;
  String photo;
  String userCover;
  String zip;
  String city;
  String country;
  String address;
  String address2;
  String phone;
  String phoneToken;
  String fax;
  String email;
  String createdAt;
  String updatedAt;
  String isProvider;
  String status;
  String verificationLink;
  String emailVerified;
  String affilateCode;
  double affilateIncome;
  String shopName;
  String ownerName;
  String shopNumber;
  String shopAddress;
  String regNumber;
  String shopMessage;
  String shopDetails;
  String shopImage;
  String fUrl;
  String gUrl;
  String tUrl;
  String lUrl;
  String isVendor;
  String fCheck;
  String gCheck;
  String tCheck;
  String lCheck;
  String mailSent;
  String shippingCost;
  String currentBalance;
  String date;
  String ban;
  String isStoreOwner;
  String isDelivery;
  String photoId;
  String carOwner;
  String photoId1;
  String photoId2;
  String photoId3;
  String photoId4;
  String realpassword;
  int isOwnShipping;

  USer(
      {this.id,
      this.name,
      this.photo,
      this.userCover,
      this.zip,
      this.city,
      this.country,
      this.address,
      this.address2,
      this.phone,
      this.phoneToken,
      this.fax,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.isProvider,
      this.status,
      this.verificationLink,
      this.emailVerified,
      this.affilateCode,
      this.affilateIncome,
      this.shopName,
      this.ownerName,
      this.shopNumber,
      this.shopAddress,
      this.regNumber,
      this.shopMessage,
      this.shopDetails,
      this.shopImage,
      this.fUrl,
      this.gUrl,
      this.tUrl,
      this.lUrl,
      this.isVendor,
      this.fCheck,
      this.gCheck,
      this.tCheck,
      this.lCheck,
      this.mailSent,
      this.shippingCost,
      this.currentBalance,
      this.date,
      this.ban,
      this.isStoreOwner,
      this.isDelivery,
      this.photoId,
      this.carOwner,
      this.photoId1,
      this.photoId2,
      this.photoId3,
      this.photoId4,
      this.realpassword,
      this.isOwnShipping});

  USer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    userCover = json['user_cover'];
    zip = json['zip'];
    city = json['city'];
    country = json['country'];
    address = json['address'];
    address2 = json['address2'];
    phone = json['phone'];
    phoneToken = json['phone_token'];
    fax = json['fax'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isProvider = json['is_provider'];
    status = json['status'];
    verificationLink = json['verification_link'];
    emailVerified = json['email_verified'];
    affilateCode = json['affilate_code'];
    shopName = json['shop_name'];
    ownerName = json['owner_name'];
    shopNumber = json['shop_number'];
    shopAddress = json['shop_address'];
    regNumber = json['reg_number'];
    shopMessage = json['shop_message'];
    shopDetails = json['shop_details'];
    shopImage = json['shop_image'];
    fUrl = json['f_url'];
    gUrl = json['g_url'];
    tUrl = json['t_url'];
    lUrl = json['l_url'];
    isVendor = json['is_vendor'];
    fCheck = json['f_check'];
    gCheck = json['g_check'];
    tCheck = json['t_check'];
    lCheck = json['l_check'];
    mailSent = json['mail_sent'];
    shippingCost = json['shipping_cost'];
    currentBalance = json['current_balance'];
    date = json['date'];
    ban = json['ban'];
    isStoreOwner = json['is_store_owner'];
    isDelivery = json['is_delivery'];
    photoId = json['photo_id'];
    carOwner = json['car_owner'];
    photoId1 = json['photo_id1'];
    photoId2 = json['photo_id2'];
    photoId3 = json['photo_id3'];
    photoId4 = json['photo_id4'];
    realpassword = json['realpassword'];
    isOwnShipping = json['is_own_shipping'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['user_cover'] = this.userCover;
    data['zip'] = this.zip;
    data['city'] = this.city;
    data['country'] = this.country;
    data['address'] = this.address;
    data['address2'] = this.address2;
    data['phone'] = this.phone;
    data['phone_token'] = this.phoneToken;
    data['fax'] = this.fax;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_provider'] = this.isProvider;
    data['status'] = this.status;
    data['verification_link'] = this.verificationLink;
    data['email_verified'] = this.emailVerified;
    data['affilate_code'] = this.affilateCode;
    data['affilate_income'] = this.affilateIncome;
    data['shop_name'] = this.shopName;
    data['owner_name'] = this.ownerName;
    data['shop_number'] = this.shopNumber;
    data['shop_address'] = this.shopAddress;
    data['reg_number'] = this.regNumber;
    data['shop_message'] = this.shopMessage;
    data['shop_details'] = this.shopDetails;
    data['shop_image'] = this.shopImage;
    data['f_url'] = this.fUrl;
    data['g_url'] = this.gUrl;
    data['t_url'] = this.tUrl;
    data['l_url'] = this.lUrl;
    data['is_vendor'] = this.isVendor;
    data['f_check'] = this.fCheck;
    data['g_check'] = this.gCheck;
    data['t_check'] = this.tCheck;
    data['l_check'] = this.lCheck;
    data['mail_sent'] = this.mailSent;
    data['shipping_cost'] = this.shippingCost;
    data['current_balance'] = this.currentBalance;
    data['date'] = this.date;
    data['ban'] = this.ban;
    data['is_store_owner'] = this.isStoreOwner;
    data['is_delivery'] = this.isDelivery;
    data['photo_id'] = this.photoId;
    data['car_owner'] = this.carOwner;
    data['photo_id1'] = this.photoId1;
    data['photo_id2'] = this.photoId2;
    data['photo_id3'] = this.photoId3;
    data['photo_id4'] = this.photoId4;
    data['realpassword'] = this.realpassword;
    data['is_own_shipping'] = this.isOwnShipping;
    return data;
  }
}
