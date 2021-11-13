import 'package:flutter_pos/model/product_model.dart';

class Vendores_model {
  int statusCode;
  String message;
  Vendores data;

  Vendores_model({this.statusCode, this.message, this.data});

  Vendores_model.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new Vendores.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Vendores {
  List<Normal> normal;
  List<Normal> vip;
  List<Normal> gold;
  String ti;

  Vendores({this.normal, this.vip, this.gold, this.ti});

  Vendores.fromJson(Map<String, dynamic> json) {
    if (json['normal'] != null) {
      normal = new List<Normal>();
      json['normal'].forEach((v) {
        normal.add(new Normal.fromJson(v));
      });
    }
    if (json['vip'] != null) {
      vip = new List<Normal>();
      json['vip'].forEach((v) {
        vip.add(new Normal.fromJson(v));
      });
    }
    if (json['gold'] != null) {
      gold = new List<Normal>();
      json['gold'].forEach((v) {
        gold.add(new Normal.fromJson(v));
      });
    }
    ti = json['Ti'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.normal != null) {
      data['normal'] = this.normal.map((v) => v.toJson()).toList();
    }
    if (this.vip != null) {
      data['vip'] = this.vip.map((v) => v.toJson()).toList();
    }
    if (this.gold != null) {
      data['gold'] = this.gold.map((v) => v.toJson()).toList();
    }
    data['Ti'] = this.ti;
    return data;
  }
}

class Normal {
  int id;
  int userId;
  int subscriptionId;
  String title;
  String currency;
  String currencyCode;
  int price;
  int days;
  int allowedProducts;
  String details;
  String method;
  Null txnid;
  Null chargeId;
  String createdAt;
  String updatedAt;
  int status;
  Null paymentNumber;
  int type;
  User users;

  Normal(
      {this.id,
      this.userId,
      this.subscriptionId,
      this.title,
      this.currency,
      this.currencyCode,
      this.price,
      this.days,
      this.allowedProducts,
      this.details,
      this.method,
      this.txnid,
      this.chargeId,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.paymentNumber,
      this.type,
      this.users});

  Normal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = int.tryParse(json['user_id']);
    subscriptionId = int.tryParse(json['subscription_id']);
    title = json['title'];
    currency = json['currency'];
    currencyCode = json['currency_code'];
    price = int.tryParse(json['price']);
    days = int.tryParse(json['days']);
    allowedProducts = int.tryParse(json['allowed_products']);
    details = json['details'];
    method = json['method'];
    txnid = json['txnid'];
    chargeId = json['charge_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = int.tryParse(json['status']);
    paymentNumber = json['payment_number'];
    type = int.tryParse(json['type']);
    users = json['users'] != null ? new User.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['subscription_id'] = this.subscriptionId;
    data['title'] = this.title;
    data['currency'] = this.currency;
    data['currency_code'] = this.currencyCode;
    data['price'] = this.price;
    data['days'] = this.days;
    data['allowed_products'] = this.allowedProducts;
    data['details'] = this.details;
    data['method'] = this.method;
    data['txnid'] = this.txnid;
    data['charge_id'] = this.chargeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['payment_number'] = this.paymentNumber;
    data['type'] = this.type;
    if (this.users != null) {
      data['users'] = this.users.toJson();
    }
    return data;
  }
}
