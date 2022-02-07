import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/order_model.dart';
import 'package:flutter_pos/model/ticket.dart';
import 'package:flutter_pos/screens/order/CreateTickits.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Orderdetails extends StatefulWidget {
  Orderdetails({Key key, this.order}) : super(key: key);
  Order order;

  @override
  _OrderdetailsState createState() => _OrderdetailsState();
}

class _OrderdetailsState extends State<Orderdetails> {
  List<Ticket> _listTicket;

  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.local_shipping_outlined,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Container(
                width: ScreenUtil.getWidth(context) / 2,
                child: AutoSizeText(
                  getTransrlate(context, 'Myorders'),
                  minFontSize: 10,
                  maxFontSize: 16,
                  maxLines: 1,
                )),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenUtil.getWidth(context) / 15),
        width: ScreenUtil.getWidth(context),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${getTransrlate(context, 'OrderDitails')} ',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 1,
                color: Colors.black12,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    '${getTransrlate(context, 'OrderNO')} : ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${widget.order.orderNumber}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    '${getTransrlate(context, 'OrderDate')} : ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.order.createdAt))}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    '${getTransrlate(context, 'paymentMethod')} : ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${getTransrlate(context, 'addressShipping')} : ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),

                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    '${getTransrlate(context, 'OrderPref')} : ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        '${getTransrlate(context, 'total_product')} :',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 15,
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        '${getTransrlate(context, 'fees_ship')} :',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 15,
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        '${getTransrlate(context, 'total_order')} : ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 15,
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${getTransrlate(context, 'OrderState')} : ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          width: ScreenUtil.getWidth(context) / 2,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: Center(
                            child: Text(
                              '${widget.order.orderNote}',
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 1,
                color: Colors.black12,
              ),
              SizedBox(
                height: 15,
              ),
              // SizedBox(
              //   height: 5,
              // ),
              // Text(
              //   '${getTransrlate(context, 'Shipping')}  1',
              //   style: TextStyle(fontWeight: FontWeight.bold),
              // ),
              SizedBox(
                height: 5,
              ),

              SizedBox(
                height: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${getTransrlate(context, 'total_product')} : ${widget.order.totalQty ?? '0'} ${themeColor.currency} ',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),


                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 1,
                    color: Colors.black12,
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              _listTicket == null
                  ? Custom_Loading()
                  : ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _listTicket.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'نوع الشكوى',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                      '${_listTicket[index].categoryName}'),
                                ),
                                Text(
                                  'عنوان الشكوى',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text('${_listTicket[index].title}'),
                                ),
                                Text(
                                  'تاريخ الشكوى',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child:
                                      Text('${_listTicket[index].createdAt}'),
                                ),
                                Text(
                                  'نص الشكوى',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('${_listTicket[index].message}'),
                                ),
                                _listTicket[index].attachment==null?Container():
                                Text(
                                  'ملف الشكوى',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline),
                                ),
                                _listTicket[index].attachment==null?Container(): Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: InkWell(
                                    onTap: () {
                                      _launchURL(_listTicket[index].attachment.image);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(border: Border.all(
                                        width: 1,color: Colors.orange
                                      )),
                                        child: Container(
                                          width: ScreenUtil.getWidth(
                                              context) /
                                              2.5,
                                          child: Text(
                                            "${_listTicket[index].attachment.image}",style: TextStyle(color: Colors.orange),
                                            maxLines: 1,
                                          ),
                                        )),
                                  ),
                                ),
                                _listTicket[index].Case=='solved'?Container(): Center(
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      _listTicket[index].Case=='to admin'?Container(): InkWell(
                                        onTap: () {
                                          API(context).post('to/admin/ticket', {
                                            "id": _listTicket[index].id,
                                          }).then((value) {
                                            if (value != null) {
                                              if (value['status_code'] == 200) {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                        ResultOverlay(
                                                            value['message']));
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                        ResultOverlay(
                                                            value['errors']));
                                              }
                                            }
                                          });
                                        },
                                        child: Container(
                                          width: ScreenUtil.getWidth(context) /
                                              1.5,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey,
                                                  width: 1)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Center(
                                              child: Text(
                                                'لم يتم حل المشكلة',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(height: 1,color: Colors.black26,),

                              ],
                            ),
                          ),
                        );
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }


  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
