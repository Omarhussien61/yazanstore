import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/model/CreateOrder.dart';
import 'package:flutter_pos/model/shipping.dart';
import 'package:flutter_pos/model/shipping_address.dart';
import 'package:flutter_pos/screens/account/OrderHistory.dart';
import 'package:flutter_pos/screens/account/checkout_information.dart';
import 'package:flutter_pos/screens/address/Address_Page.dart';
import 'package:flutter_pos/screens/order/DetailScreen.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderPage extends StatefulWidget {
  OrderPage();

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  //  checkboxValuePayment = 1,
  //     checkboxValuePacking = 0,
  int checkboxValueShipping = 0;

  List<String> city = new List<String>();
  CreateOrder model_ordel = CreateOrder();
  List<Address> address;
  Shipping shipping;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String name, email, addres, phone, code, CoponCode, CoponId, _coponButton;
  TextEditingController _CoponController;
  bool _loading = false;
  bool _isedit = false;
  final _formKey = GlobalKey<FormState>();
  var pickedFile;
  double total = 0.0;
  double Carttotal = 0.0;
  double coupon = 0.0;
  @override
  void initState() {
    total = Provider.of<Provider_Data>(context, listen: false).total;
    Carttotal = Provider.of<Provider_Data>(context, listen: false).total;
    _CoponController = new TextEditingController();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        model_ordel.id = "${prefs.getInt('user_id')}";
        model_ordel.customer_name = prefs.getString('user_name');
        model_ordel.customer_email = prefs.getString('user_email');
        model_ordel.customer_phone = prefs.getString('phone');
        model_ordel.customer_address = prefs.getString('address');
        model_ordel.country_id = prefs.getString('country_id');

        getAddress();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    final _cart_model = Provider.of<Provider_Data>(context);

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          brightness: Brightness.light,
          elevation: 0,
          centerTitle: true,
          title: Text(
            getTransrlate(context, 'placeorder'),
            style: TextStyle(
                color: themeColor.getColor(), fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.chevron_left,
              color: themeColor.getColor(),
            ),
          ),
        ),
        backgroundColor: Color(0xFFFCFCFC),
        body: Container(
            padding: EdgeInsets.all(8),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "${getTransrlate(context, 'MethodShipping')}",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5D6A78)),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.2),
                            blurRadius: 6.0, // soften the shadow
                            spreadRadius: 0.0, //extend the shadow
                            offset: Offset(
                              0.0, // Move to right 10  horizontally
                              1.0, // Move to bottom 10 Vertically
                            ),
                          )
                        ]),
                    margin: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        shipping == null
                            ? Container(
                                height: 100,
                                child: Center(child: Text('تحميل . . ')))
                            : shipping.shippingData.isEmpty
                                ? Container(
                                    child:
                                        Center(child: Text('لا توجد طرق شحن')),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: shipping.shippingData.length,
                                    itemBuilder:
                                        (BuildContext context, int position) {
                                      return buildItemShipping(
                                          context,
                                          themeColor,
                                          shipping.shippingData[position],
                                          position);
                                    },
                                  ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 8.0),
                  //   child: Text(
                  //     "${getTransrlate(context, 'packingMethod')}",
                  //     style: TextStyle(
                  //         fontSize: 15,
                  //         fontWeight: FontWeight.w600,
                  //         color: Color(0xFF5D6A78)),
                  //   ),
                  // ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(10),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.grey.withOpacity(.2),
                  //           blurRadius: 6.0, // soften the shadow
                  //           spreadRadius: 0.0, //extend the shadow
                  //           offset: Offset(
                  //             0.0, // Move to right 10  horizontally
                  //             1.0, // Move to bottom 10 Vertically
                  //           ),
                  //         )
                  //       ]),
                  //   margin: EdgeInsets.all(8),
                  //   child: Column(
                  //     children: [
                  //       shipping == null
                  //           ? Container(
                  //               height: 100,
                  //               child: Center(child: Text('تحميل . . .')))
                  //           : shipping.packageData.isEmpty
                  //               ? Container(
                  //                   child: Center(
                  //                       child: Text('لا توجد طرق تغليف')),
                  //                 )
                  //               : ListView.builder(
                  //                   shrinkWrap: true,
                  //                   physics: NeverScrollableScrollPhysics(),
                  //                   itemCount: shipping.packageData.length,
                  //                   itemBuilder:
                  //                       (BuildContext context, int position) {
                  //                     return buildItemPacking(
                  //                         context,
                  //                         themeColor,
                  //                         shipping.packageData[position],
                  //                         position);
                  //                   },
                  //                 ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 8.0),
                  //   child: Text(
                  //     "${getTransrlate(context, 'paymentsMethod')}",
                  //     style: TextStyle(
                  //         fontSize: 15,
                  //         fontWeight: FontWeight.w600,
                  //         color: Color(0xFF5D6A78)),
                  //   ),
                  // ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(10),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.grey.withOpacity(.2),
                  //           blurRadius: 6.0, // soften the shadow
                  //           spreadRadius: 0.0, //extend the shadow
                  //           offset: Offset(
                  //             0.0, // Move to right 10  horizontally
                  //             1.0, // Move to bottom 10 Vertically
                  //           ),
                  //         )
                  //       ]),
                  //   margin: EdgeInsets.all(8),
                  //   child: Column(
                  //     children: [
                  //       buildItemPayment(context, themeColor,
                  //           "${getTransrlate(context, 'cod')}", 1),
                  //       buildItemPayment(context, themeColor,
                  //           "${getTransrlate(context, 'bacs')}", 2),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      getTransrlate(context, 'OrderShipping'),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Color(0xFF5D6A78)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.2),
                                  blurRadius: 6.0, // soften the shadow
                                  spreadRadius: 0.0, //extend the shadow
                                  offset: Offset(
                                    0.0, // Move to right 10  horizontally
                                    1.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ]),
                          child: model_ordel.customer_name == null
                              ? Container()
                              : Container(
                                  margin: EdgeInsets.all(8),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.topCenter,
                                          child: MyTextFormField(
                                            intialLabel:
                                                model_ordel.customer_name,
                                            labelText: getTransrlate(
                                                context, 'Firstname'),
                                            hintText: getTransrlate(
                                                context, 'Firstname'),
                                            validator: (String value) {
                                              if (value.isEmpty) {
                                                return getTransrlate(
                                                    context, 'Firstname');
                                              }
                                              return null;
                                            },
                                            onSaved: (String value) {
                                              model_ordel.shipping_name = value;
                                            },
                                          ),
                                        ),
                                        MyTextFormField(
                                          intialLabel:
                                              model_ordel.customer_email,

                                          labelText:
                                              getTransrlate(context, 'Email'),
                                          hintText:
                                              getTransrlate(context, 'Email'),
                                          isEmail: true,
                                          // validator: (String value) {
                                          //   if (!validator.isEmail(value)) {
                                          //     return getTransrlate(context, 'invalidemail');
                                          //   }
                                          //   return null;
                                          // },
                                          onSaved: (String value) {
                                            model_ordel.shipping_email = value;
                                          },
                                        ),
                                        Container(
                                          alignment: Alignment.topCenter,
                                          child: MyTextFormField(
                                            textAlign: TextAlign.left,
                                            intialLabel:
                                                model_ordel.customer_phone,
                                            textDirection: TextDirection.ltr,
                                            labelText:
                                                getTransrlate(context, 'phone'),
                                            hintText:
                                                getTransrlate(context, 'phone'),
                                            isPhone: true,
                                            keyboard_type: TextInputType.phone,
                                            // prefix: Container(
                                            //   width: ScreenUtil.getWidth(context) / 4,
                                            //   child: CountryCodePicker(
                                            //     textStyle: TextStyle(color: kPrimaryColor),
                                            //     onChanged: (v) {
                                            //       setState(() {
                                            //         this.CountryNo = v.toString();
                                            //         print(this.CountryNo);
                                            //       });
                                            //     },
                                            //     // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                            //     initialSelection: 'EG',
                                            //     favorite: ['SA', 'EG'],
                                            //     // optional. Shows only country name and flag
                                            //     showCountryOnly: true,
                                            //     // optional. Shows only country name and flag when popup is closed.
                                            //     showOnlyCountryWhenClosed: false,
                                            //     // optional. aligns the flag and the Text left
                                            //     alignLeft: true,
                                            //   ),
                                            // ),
                                            validator: (String value) {
                                              if (value.isEmpty) {
                                                return getTransrlate(
                                                    context, 'phone');
                                              } else if (value.length < 10) {
                                                return getTransrlate(
                                                    context, 'shorterphone');
                                              }
                                              return null;
                                            },
                                            onSaved: (String value) {
                                              model_ordel.shipping_phone =
                                                  value;
                                            },
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topCenter,
                                          child: MyTextFormField(
                                            intialLabel:
                                                model_ordel.customer_address,
                                            labelText: getTransrlate(
                                                context, 'Addres'),
                                            hintText: getTransrlate(
                                                context, 'Addres'),
                                            validator: (String value) {
                                              if (value.isEmpty) {
                                                return getTransrlate(
                                                    context, 'Addres');
                                              } else if (value.length < 3) {
                                                return getTransrlate(
                                                    context, 'Addres');
                                              }
                                              return null;
                                            },
                                            onSaved: (String value) {
                                              model_ordel.shipping_address =
                                                  value;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.2),
                                  blurRadius: 6.0, // soften the shadow
                                  spreadRadius: 0.0, //extend the shadow
                                  offset: Offset(
                                    0.0, // Move to right 10  horizontally
                                    1.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: 16, left: 16, top: 8, bottom: 8),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      code = value;
                                    },
                                    controller: _CoponController,
                                    enabled: !_isedit,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: themeColor.getColor()),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black26),
                                        ),
                                        labelStyle: new TextStyle(
                                            color: const Color(0xFF424242)),
                                        hintText: getTransrlate(
                                            context, 'couponcode'),
                                        hintStyle: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: FlatButton.icon(
                                    onPressed: () async {
                                      if (_isedit) {
                                        setState(() {
                                          _isedit = false;
                                          //  widget.total=totalbeforedesc;
                                          //    copon=0;
                                          //    countItem=0;
                                        });
                                      } else {
                                        _isedit = true;
                                        _coponButton =
                                            getTransrlate(context, 'edit');
                                        _loading = true;
                                        API(context).post('carts/coupon', {
                                          'coupon': _CoponController.text,
                                          "lang": "${themeColor.getlocal()}",
                                          "user_id": "${model_ordel.id}",
                                        }).then((value) {
                                          var coupon_data = value['data'];
                                          print(value);
                                          if (value['status_code'] == 200) {
                                            setState(() {
                                              _loading = false;
                                              coupon = double.parse(
                                                  coupon_data['price']
                                                      .toString());
                                              total = (Carttotal +
                                                      model_ordel
                                                          .shipping_cost +
                                                      model_ordel
                                                          .packing_cost) -
                                                  coupon;
                                            });
                                            model_ordel.coupon_code =
                                                "${coupon_data['code']}";
                                            model_ordel.coupon_discount =
                                                "${coupon_data['price']}";
                                            model_ordel.coupon_id =
                                                "${coupon_data['id']}";
                                            showDialog(
                                                context: context,
                                                builder: (_) => ResultOverlay(
                                                    '${value['message'] ?? ''}'));
                                          } else {
                                            setState(() {
                                              _loading = false;
                                            });
                                            setState(() {
                                              _loading = false;
                                              coupon = 0;
                                              total = (Carttotal +
                                                      model_ordel
                                                          .shipping_cost +
                                                      model_ordel
                                                          .packing_cost) -
                                                  coupon;
                                            });
                                            model_ordel.coupon_code = " ";
                                            model_ordel.coupon_discount = " ";
                                            model_ordel.coupon_id = " ";
                                            showDialog(
                                                context: context,
                                                builder: (_) => ResultOverlay(
                                                    '${value['message'] ?? ''}'));
                                          }
                                        });
                                      }
                                    },
                                    icon: Icon(
                                      Icons.local_offer,
                                      size: 15,
                                    ),
                                    label: Text(
                                      _isedit
                                          ? getTransrlate(context, 'edit')
                                          : getTransrlate(
                                              context, 'couponApplay'),
                                      style: TextStyle(fontSize: 15),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 16, bottom: 8),
                          child: Text(
                            getTransrlate(context, 'OrderNote'),
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF5D6A78)),
                          ),
                        ),
                        Form(
                          //key: _formKey,
                          child: Container(
                            margin:
                                EdgeInsets.only(bottom: 8, right: 8, left: 8),
                            child: ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(.2),
                                          blurRadius: 6.0,
                                          // soften the shadow
                                          spreadRadius: 0.0,
                                          //extend the shadow
                                          offset: Offset(
                                            0.0,
                                            // Move to right 10  horizontally
                                            1.0, // Move to bottom 10 Vertically
                                          ),
                                        )
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        themeColor.getColor()),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              labelStyle: new TextStyle(
                                                  color:
                                                      const Color(0xFF424242)),
                                              hintText: getTransrlate(
                                                  context, 'OrderHint'),
                                              hintStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600)),
                                          validator: (String value) {
                                            if (value.length < 10 &&
                                                value.length > 1) {
                                              return getTransrlate(
                                                      context, 'OrderHint') +
                                                  ' >  10';
                                            }
                                            return null;
                                          },
                                          onChanged: (String value) {
                                            model_ordel.customerNotes = value;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 16, bottom: 8),
                          child: Text(
                            getTransrlate(context, 'total_product'),
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF5D6A78)),
                          ),
                        ),
                        Form(
                          //key: _formKey,
                          child: Container(
                            margin: EdgeInsets.only(
                                bottom: 8, top: 8, right: 8, left: 8),
                            child: ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        '${getTransrlate(context, 'total_product')}'),
                                    Text('${_cart_model.total}'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        '${getTransrlate(context, 'totaldiscount')}'),
                                    Text('${coupon}'),
                                  ],
                                ),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text(
                                //         '${getTransrlate(context, 'packingCost')}'),
                                //     Text('${model_ordel.packing_cost}'),
                                //   ],
                                // ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        '${getTransrlate(context, 'totalShipping')}'),
                                    Text('${model_ordel.shipping_cost}'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        '${getTransrlate(context, 'total_order')}'),
                                    Text('${total}'),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        _loading
                            ? Center(
                                child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.black),
                                ),
                              ))
                            : Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8, top: 20, bottom: 20),
                                  child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                        width: ScreenUtil.getWidth(context) / 2,
                                        child: Center(
                                          child: Text(
                                            "${getTransrlate(context, 'ORDERCOMPLETE')}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      color: themeColor.getColor(),
                                      onPressed: () async {
                                        if (_formKey.currentState.validate()) {
                                          _formKey.currentState.save();
                                          _loading = false;
                                          model_ordel.pay_amount = '${total}';
                                          model_ordel.lang =
                                              '${themeColor.getlocal()}';

                                          print(model_ordel.toJson());
                                          API(context)
                                              .post('cashondelivery',
                                                  model_ordel.toJson())
                                              .then((value) {
                                            if (value != null) {
                                              if (value['status_code'] == 200) {
                                                Nav.routeReplacement(
                                                    context,
                                                    DetailScreen(
                                                      id: "${value['data']['order_id']}",
                                                    ));
                                              }
                                              showDialog(
                                                  context: context,
                                                  builder: (_) => ResultOverlay(
                                                      '${value['message'] ?? ''}'));
                                            }
                                          });
                                        }
                                      }),
                                ))
                      ],
                    ),
                  ),
                ]))));
  }

  // buildItemPacking(
  //     BuildContext context, themeColor, Package_data caption, int position) {
  //   return Container(
  //     padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 4),
  //     width: ScreenUtil.getWidth(context),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Row(
  //           children: <Widget>[
  //             Radio<int>(
  //               value: position,
  //              // groupValue: checkboxValuePacking,
  //               activeColor: themeColor.getColor(),
  //               focusColor: themeColor.getColor(),
  //               hoverColor: themeColor.getColor(),
  //               onChanged: (int value) {
  //                 setState(() {
  //               //    checkboxValuePacking = value;
  //                   model_ordel.vendor_packing_id = caption.id.toString();
  //                   model_ordel.packing_cost = caption.price.toDouble();
  //                   total = (Carttotal +
  //                           model_ordel.shipping_cost +
  //                           model_ordel.packing_cost) -
  //                       coupon;
  //                 });
  //               },
  //             ),
  //             Expanded(
  //                 child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   "${themeColor.getlocal() == 'ar' ? caption.title ?? caption.title_en : caption.title_en ?? caption.title}",
  //                   style: TextStyle(
  //                       fontSize: 12,
  //                       fontWeight: FontWeight.w600,
  //                       color: Color(0xFF5D6A78)),
  //                 ),
  //                 Text(
  //                   "${themeColor.getlocal() == 'ar' ? caption.subtitle ?? caption.subtitle_en : caption.subtitle_en ?? caption.subtitle}",
  //                   style: TextStyle(
  //                       fontSize: 10,
  //                       fontWeight: FontWeight.w600,
  //                       color: Color(0xFF5D6A78)),
  //                 ),
  //                 Text(
  //                   "${getTransrlate(context, 'price')} : ${caption.price}  ${themeColor.currency}",
  //                   style: TextStyle(
  //                       fontSize: 10,
  //                       fontWeight: FontWeight.w600,
  //                       color: themeColor.getColor()),
  //                 ),
  //               ],
  //             )),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // buildItemPayment(
  //     BuildContext context, themeColor, String caption, int position) {
  //   return Container(
  //     padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 4),
  //     width: ScreenUtil.getWidth(context),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Row(
  //           children: <Widget>[
  //             Radio<int>(
  //               value: position,
  //               groupValue: checkboxValuePayment,
  //               activeColor: themeColor.getColor(),
  //               focusColor: themeColor.getColor(),
  //               hoverColor: themeColor.getColor(),
  //               onChanged: (int value) {
  //                 setState(() {
  //                   checkboxValuePayment = value;
  //                 });
  //               },
  //             ),
  //             Expanded(
  //                 child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   caption,
  //                   style: TextStyle(
  //                       fontSize: 12,
  //                       fontWeight: FontWeight.w600,
  //                       color: Color(0xFF5D6A78)),
  //                 ),
  //               ],
  //             )),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  buildItemShipping(
      BuildContext context, themeColor, Shipping_data caption, int position) {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 4),
      width: ScreenUtil.getWidth(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Radio<int>(
                value: position,
                groupValue: checkboxValueShipping,
                activeColor: themeColor.getColor(),
                focusColor: themeColor.getColor(),
                hoverColor: themeColor.getColor(),
                onChanged: (int value) {
                  setState(() {
                    checkboxValueShipping = value;
                    model_ordel.vendor_shipping_id = caption.id.toString();
                    model_ordel.shipping_cost = caption.price.toDouble();
                    total = (Carttotal +
                            model_ordel.shipping_cost +
                            model_ordel.packing_cost) -
                        coupon;
                  });
                },
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${themeColor.getlocal() == 'ar' ? caption.title ?? caption.title_en : caption.title_en ?? caption.title}",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5D6A78)),
                  ),
                  Text(
                    "${themeColor.getlocal() == 'ar' ? caption.subtitle ?? caption.subtitle_en : caption.subtitle_en ?? caption.subtitle}",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5D6A78)),
                  ),
                  Text(
                    "${getTransrlate(context, 'price')} : ${caption.price}  ${themeColor.currency}",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: themeColor.getColor()),
                  ),
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    address == null;
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Shipping_Address()));
    Timer(Duration(seconds: 3), () => getAddress());
  }

  getAddress() {
    API(context).get('shipping?user_id=${model_ordel.id}').then((value) {
      setState(() {
        shipping = Shipping_model.fromJson(value).data;
        model_ordel.vendor_packing_id = shipping.packageData[0].id.toString();
        model_ordel.packing_cost = shipping.packageData[0].price.toDouble();
        model_ordel.vendor_shipping_id = shipping.shippingData[0].id.toString();
        model_ordel.shipping_cost = shipping.shippingData[0].price.toDouble();
        total =
            (Carttotal + model_ordel.shipping_cost + model_ordel.packing_cost) -
                coupon;
      });
    });
  }
}
