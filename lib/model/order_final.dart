class orderFinal {
  int id;
  String userId;
  List<Cart> cart;
  String method;
  String shipping;
  String pickupLocation;
  String totalQty;
  String payAmount;
  String txnid;
  String chargeId;
  String orderNumber;
  String paymentStatus;
  String customerEmail;
  String customerName;
  String customerCountry;
  String customerPhone;
  String customerAddress;
  String customerCity;
  String customerZip;
  String shippingName;
  String shippingCountry;
  String shippingEmail;
  String shippingPhone;
  String shippingAddress;
  String shippingCity;
  String shippingZip;
  String orderNote;
  String couponCode;
  String couponDiscount;
  String status;
  String createdAt;
  String updatedAt;
  String affilateUser;
  String affilateCharge;
  String currencySign;
  String currencyValue;
  String shippingCost;
  String packingCost;
  String tax;
  String dp;
  String payId;
  String vendorShippingId;
  String vendorPackingId;
  String isPickuped;
  String deliveryId;
  String locationUrl;
  String isVendorOrder;

  orderFinal(
      {this.id,
      this.userId,
      this.cart,
      this.method,
      this.shipping,
      this.pickupLocation,
      this.totalQty,
      this.payAmount,
      this.txnid,
      this.chargeId,
      this.orderNumber,
      this.paymentStatus,
      this.customerEmail,
      this.customerName,
      this.customerCountry,
      this.customerPhone,
      this.customerAddress,
      this.customerCity,
      this.customerZip,
      this.shippingName,
      this.shippingCountry,
      this.shippingEmail,
      this.shippingPhone,
      this.shippingAddress,
      this.shippingCity,
      this.shippingZip,
      this.orderNote,
      this.couponCode,
      this.couponDiscount,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.affilateUser,
      this.affilateCharge,
      this.currencySign,
      this.currencyValue,
      this.shippingCost,
      this.packingCost,
      this.tax,
      this.dp,
      this.payId,
      this.vendorShippingId,
      this.vendorPackingId,
      this.isPickuped,
      this.deliveryId,
      this.locationUrl,
      this.isVendorOrder});

  orderFinal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    if (json['cart'] != null) {
      cart = new List<Cart>();
      json['cart'].forEach((v) {
        cart.add(new Cart.fromJson(v));
      });
    }
    method = json['method'];
    shipping = json['shipping'];
    pickupLocation = json['pickup_location'];
    totalQty = json['totalQty'];
    payAmount = json['pay_amount'];
    txnid = json['txnid'];
    chargeId = json['charge_id'];
    orderNumber = json['order_number'];
    paymentStatus = json['payment_status'];
    customerEmail = json['customer_email'];
    customerName = json['customer_name'];
    customerCountry = json['customer_country'];
    customerPhone = json['customer_phone'];
    customerAddress = json['customer_address'];
    customerCity = json['customer_city'];
    customerZip = json['customer_zip'];
    shippingName = json['shipping_name'];
    shippingCountry = json['shipping_country'];
    shippingEmail = json['shipping_email'];
    shippingPhone = json['shipping_phone'];
    shippingAddress = json['shipping_address'];
    shippingCity = json['shipping_city'];
    shippingZip = json['shipping_zip'];
    orderNote = json['order_note'];
    couponCode = json['coupon_code'];
    couponDiscount = json['coupon_discount'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    affilateUser = json['affilate_user'];
    affilateCharge = json['affilate_charge'];
    currencySign = json['currency_sign'];
    currencyValue = json['currency_value'];
    shippingCost = json['shipping_cost'];
    packingCost = json['packing_cost'];
    tax = json['tax'];
    dp = json['dp'];
    payId = json['pay_id'];
    vendorShippingId = json['vendor_shipping_id'];
    vendorPackingId = json['vendor_packing_id'];
    isPickuped = json['is_pickuped'];
    deliveryId = json['delivery_id'];
    locationUrl = json['location_url'];
    isVendorOrder = json['is_vendor_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    if (this.cart != null) {
      data['cart'] = this.cart.map((v) => v.toJson()).toList();
    }
    data['method'] = this.method;
    data['shipping'] = this.shipping;
    data['pickup_location'] = this.pickupLocation;
    data['totalQty'] = this.totalQty;
    data['pay_amount'] = this.payAmount;
    data['txnid'] = this.txnid;
    data['charge_id'] = this.chargeId;
    data['order_number'] = this.orderNumber;
    data['payment_status'] = this.paymentStatus;
    data['customer_email'] = this.customerEmail;
    data['customer_name'] = this.customerName;
    data['customer_country'] = this.customerCountry;
    data['customer_phone'] = this.customerPhone;
    data['customer_address'] = this.customerAddress;
    data['customer_city'] = this.customerCity;
    data['customer_zip'] = this.customerZip;
    data['shipping_name'] = this.shippingName;
    data['shipping_country'] = this.shippingCountry;
    data['shipping_email'] = this.shippingEmail;
    data['shipping_phone'] = this.shippingPhone;
    data['shipping_address'] = this.shippingAddress;
    data['shipping_city'] = this.shippingCity;
    data['shipping_zip'] = this.shippingZip;
    data['order_note'] = this.orderNote;
    data['coupon_code'] = this.couponCode;
    data['coupon_discount'] = this.couponDiscount;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['affilate_user'] = this.affilateUser;
    data['affilate_charge'] = this.affilateCharge;
    data['currency_sign'] = this.currencySign;
    data['currency_value'] = this.currencyValue;
    data['shipping_cost'] = this.shippingCost;
    data['packing_cost'] = this.packingCost;
    data['tax'] = this.tax;
    data['dp'] = this.dp;
    data['pay_id'] = this.payId;
    data['vendor_shipping_id'] = this.vendorShippingId;
    data['vendor_packing_id'] = this.vendorPackingId;
    data['is_pickuped'] = this.isPickuped;
    data['delivery_id'] = this.deliveryId;
    data['location_url'] = this.locationUrl;
    data['is_vendor_order'] = this.isVendorOrder;
    return data;
  }
}

class Cart {
  int id;
  String cartId;
  String productId;
  String quantity;
  String from;
  String to;

  Cart(
      {this.id,
      this.cartId,
      this.productId,
      this.quantity,
      this.from,
      this.to});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartId = json['cart_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cart_id'] = this.cartId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
  }
}
