import 'package:flutter_pos/model/product_model.dart';

class Wishlist_model {
  int currentPage;
  List<Wishlist> data;

  Wishlist_model({this.currentPage, this.data});

  Wishlist_model.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<Wishlist>();
      json['data'].forEach((v) {
        data.add(new Wishlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wishlist {
  int id;
  int userId;
  int productId;
  Product product;

  Wishlist({this.id, this.userId, this.productId, this.product});

  Wishlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = int.tryParse(json['user_id']);
    productId = int.tryParse(json['product_id']);
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}
