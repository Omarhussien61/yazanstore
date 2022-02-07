import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_pos/model/order_final.dart';
import 'package:flutter_pos/screens/account/OrderHistory.dart';
import 'package:flutter_pos/screens/homepage.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/app_bar_custom.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key key, this.id}) : super(key: key);
  String id;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  orderFinal _finalorder;
  @override
  void initState() {
    API(context).get('order/${widget.id}').then((value) {
      if (value != null) {
        if (value['status_code'] == 200) {
          setState(() {
            _finalorder = orderFinal.fromJson(value['data']);
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    final data = Provider.of<Provider_Data>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order # ${widget.id}',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          InkWell(
              onTap: () => Phoenix.rebirth(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ))
        ],
        leading: Container(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _finalorder == null
                ? Center(child: Custom_Loading())
                : Container(
                    height: ScreenUtil.getHeight(context),
                    child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: 101,
                                height: 101,
                                decoration: BoxDecoration(
                                  color: themeColor.getColor(),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.5)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 31,
                                      child: Icon(
                                        Icons.check,
                                        size:
                                            ScreenUtil.getHeight(context) / 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil.getHeight(context) * .03,
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                getTransrlate(context, 'OrderDone'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: themeColor.getColor(),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil.getHeight(context) * .03,
                            ),
                            Column(
                              children: <Widget>[
                                // Padding(
                                //   padding: const EdgeInsets.only(right: 15,left: 15),
                                //   child: Container(
                                //     child: ListView.builder(
                                //       physics: new NeverScrollableScrollPhysics(),
                                //       shrinkWrap: true,
                                //       itemCount: _finalorder.,
                                //       itemBuilder: (BuildContext context, int index) {
                                //         return Table(
                                //           border: TableBorder.all(color: Colors.grey),
                                //           children: [
                                //             TableRow(children: [
                                //               Padding(
                                //                 padding: const EdgeInsets.all(8.0),
                                //                 child: Container(
                                //                   height: 25,
                                //                   child: Row(
                                //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //                     children: <Widget>[
                                //                       Container(
                                //                         width: deviceWidth/2,
                                //                         child: Text(
                                //                           confirmOrder.products[index].product.title.toString(),
                                //                           style:TextStyle(
                                //                               color:themeColor.getColor(),
                                //                               fontWeight: FontWeight.bold,
                                //                               fontSize: 15),
                                //                         ),
                                //                       ),
                                //                       Container(
                                //                         width: deviceWidth/4,
                                //                         child: Text(confirmOrder.products[index].quantity.toString()+' × '+confirmOrder.products[index].total.toString(),
                                //                           style:TextStyle(color: Colors.black, fontSize: 15),
                                //                         ),
                                //                       ),
                                //                     ],
                                //                   ),
                                //                 ),
                                //               ),
                                //             ]),
                                //           ],
                                //         );
                                //       },
                                //     ),
                                //   ),
                                // ),
                                _finalorder.couponDiscount == null
                                    ? Container()
                                    : ListTile(
                                        leading: Icon(
                                          Icons.remove_circle,
                                          color: themeColor.getColor(),
                                          size: ScreenUtil.getHeight(context) /
                                              20,
                                        ),
                                        title: Text(
                                          getTransrlate(
                                              context, 'totaldiscount'),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0),
                                        ),
                                        trailing: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            _finalorder.couponDiscount
                                                    .toString() +
                                                " ${themeColor.currency}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                      ),
                                ListTile(
                                  leading: Icon(
                                    Icons.swap_vert_circle_sharp,
                                    color: themeColor.getColor(),
                                    size: ScreenUtil.getHeight(context) / 20,
                                  ),
                                  title: Text(
                                    getTransrlate(context, 'total_product'),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      "${data.total}" +
                                          '  ' +
                                          "${themeColor.currency}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.add_circle,
                                    color: themeColor.getColor(),
                                    size: ScreenUtil.getHeight(context) / 20,
                                  ),
                                  title: Text(
                                    getTransrlate(context, 'totalShipping'),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      _finalorder.shippingCost.toString() +
                                          '  ' +
                                          "${themeColor.currency}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.remove_circle_outlined,
                                    color: themeColor.getColor(),
                                    size: ScreenUtil.getHeight(context) / 20,
                                  ),
                                  title: Text(
                                    getTransrlate(context, 'totaldiscount'),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      '${_finalorder.couponDiscount ?? 0}' +
                                          "${themeColor.currency}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.add_circle,
                                    color: themeColor.getColor(),
                                    size: ScreenUtil.getHeight(context) / 20,
                                  ),
                                  title: Text(
                                    "${getTransrlate(context, 'packingCost')}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      _finalorder.packingCost.toString() +
                                          '  ' +
                                          "${themeColor.currency}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.add_circle,
                                    color: themeColor.getColor(),
                                    size: ScreenUtil.getHeight(context) / 20,
                                  ),
                                  title: Text(
                                    getTransrlate(context, 'total_tax'),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      _finalorder.tax.toString() +
                                          '${themeColor.currency}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.check_circle,
                                    color: themeColor.getColor(),
                                    size: ScreenUtil.getHeight(context) / 20,
                                  ),
                                  title: Text(
                                    getTransrlate(context, 'total'),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      _finalorder.payAmount.toString() +
                                          '  ' +
                                          "${themeColor.currency}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                ),
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  onPressed: () {
                                    Nav.route(context, OrderHistory());
                                  },
                                  child: Text(
                                    getTransrlate(context, 'OrderDetails'),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: themeColor.getColor(),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
