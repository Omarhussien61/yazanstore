import 'package:flutter_pos/model/product_model.dart';

class Cart_model {
  int statusCode;
  String message;
  List<Cart> data;

  Cart_model({this.statusCode, this.message, this.data});

  Cart_model.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Cart>();
      json['data'].forEach((v) {
        data.add(new Cart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cart {
  int id;
  int cartId;
  Product product;
  int quantity;
  String Color;
  String Size;
  int Size_price;

  Cart({this.id, this.cartId, this.product, this.quantity});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartId = int.tryParse(json['cart_id']);
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    quantity = int.tryParse(json['quantity']);
    Size = json['size'];
    Color = json['color'];
    Size_price = int.tryParse(json['size_price']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cart_id'] = this.cartId;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    data['quantity'] = this.quantity;
    return data;
  }
}
