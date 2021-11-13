// user_id:22
// pay_amount:1200
// shipping:2
// customer_email:a@a.c
// customer_name:aa
// shipping_cost:20
// packing_cost:0
// tax:0
// customer_phone:434363434643
// customer_address:dddd dd
// customer_city:sddsd
// customer_zip:22234
// customer_email:c@c.p
// shipping_email:a@a.ccc
// shipping_name:rrwerwe
// shipping_phone:23525235
// shipping_address:wtewet
// shipping_country:tewtwet
// shipping_city:wetwet
// shipping_zip:23523
// order_note:ttttttttttttt
// coupon_id:3
// coupon_code:0
// coupon_discount:0
// vendor_shipping_id:0
// vendor_packing_id:0
class CreateOrder {
  String id;
  String pay_amount;
  String lang;
  String customer_name;
  String customer_email;
  String customer_phone;
  String customer_city;
  String customer_zip;
  String tax;
  double packing_cost=0.0;
  double shipping_cost=0.0;
  String customer_address;
  String country_id;
  String customerNotes;
  String shipping_email;
  String shipping_name;
  String shipping_phone;
  String shipping_address;
  String shipping_country;
  String shipping_zip;
  String order_note;
  String coupon_id;
  String coupon_code;
  String coupon_discount;
  String vendor_shipping_id;
  String vendor_packing_id;

  CreateOrder(
      {this.customer_name,
      this.customer_email,
      this.customer_phone,
      this.country_id,
      this.customerNotes,
      this.shipping_email,
      this.shipping_name,
      this.shipping_phone,
      this.shipping_address,
      this.shipping_country,
      this.shipping_zip,
      this.order_note,
      this.id,
      this.coupon_code,
      this.coupon_discount,
      this.coupon_id,
      this.customer_address,
      this.customer_city,
      this.customer_zip,
      this.pay_amount,
      this.tax,
      this.lang,
      this.vendor_packing_id,
      this.vendor_shipping_id,
      this.packing_cost,
        this.shipping_cost});



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.id;
    data['customer_name'] = this.customer_name;
    data['customer_email'] = this.customer_email;
    data['customer_phone'] = this.customer_phone;
    data['country_id'] = this.country_id;
    data['coupon_id'] = this.coupon_id;
    data['coupon_discount'] = this.coupon_discount;
    data['coupon_code'] = this.coupon_code;
    data['customerNotes'] = this.customerNotes;
    data['shipping_email'] = this.shipping_email;
    data['shipping_name'] = this.shipping_name;
    data['shipping_phone'] = this.shipping_phone;
    data['shipping_address'] = this.shipping_address;
    data['shipping_country'] = this.shipping_country;
    data['shipping_cost'] = this.shipping_cost;
    data['packing_cost'] = this.packing_cost;
    data['tax'] = 10;
    data['shipping_zip'] = this.shipping_zip;
    data['lang'] = this.lang;
    data['pay_amount'] = this.pay_amount;
    data['vendor_shipping_id'] = this.vendor_shipping_id;
    data['vendor_packing_id'] = this.vendor_packing_id;
    data['order_note'] = this.order_note;
    return data;
  }
}
