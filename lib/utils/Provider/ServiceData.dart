import 'package:flutter/material.dart';
import 'package:flutter_pos/model/cart_model.dart';
import 'package:flutter_pos/model/category_model.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/model/product_most_view.dart';
import 'package:flutter_pos/model/shipping_address.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Provider_Data with ChangeNotifier {
  Cart_model cart_model;
  Address address;
  List<Product> product, productMostSale, feature, productvip, bestProducts;
  List<Categories> categories;
  double total = 0;
  Provider_Data();

  getCart_model() => cart_model;

  getCart(BuildContext context) {
    SharedPreferences.getInstance().then((value) {
      API(context, Check: false)
          .post('carts', {"user_id": value.getInt('user_id')}).then((value) {
        if (value != null) {
          print(value);
          cart_model = Cart_model.fromJson(value);
          total = 0;
          cart_model.data.forEach((element) {
            total = total +
                (double.parse(element.product.price.toString()) ??
                    1 * element.quantity + element.Size_price);
          });
          notifyListeners();
        }
      });
    });
  }

  getData(BuildContext context) {
    API(context, Check: false).get('urgentDeals').then((value) {
      if (value != null) {
        product = ProductModel.fromJson(value['data']).products;
        print(product.length);
      }
    });
    API(context, Check: false).get('vendor-vip-products').then((value) {
      if (value != null) {
        productvip = ProductModel.fromJson(value['data']).products;
        print(productvip.length);
      }
    });
    API(context, Check: false).get('feature').then((value) {
      if (value != null) {
        feature = ProductModel.fromJson(value['data']).products;
      }
    });
    API(context, Check: false).get('bestProducts').then((value) {
      if (value != null) {
        bestProducts = ProductModel.fromJson(value['data']).products;
      }
    });
    API(context).get('categories').then((value) {
      if (value != null) {
        categories = Category_model.fromJson(value).data;
      }
    });
    API(context).get('MazadProducts').then((value) {
      if (value != null) {
        if (value['status_code'] == 200) {
          productMostSale = ProductModel.fromJson(value['data']).products;
        }
      }
    });
    notifyListeners();
  }

  getShipping(BuildContext context) {
    API(context, Check: false).get('user/get/default/shipping').then((value) {
      if (value != null) {
        if (value['status_code'] == 200) {
          value['data'] == null
              ? null
              : address = Address.fromJson(value['data']);
          notifyListeners();
        }
      }
    });
  }

  setShipping(Address address) {
    this.address = address;
    notifyListeners();
  }
}
