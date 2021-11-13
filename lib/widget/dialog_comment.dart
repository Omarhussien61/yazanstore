
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/product_details.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';


class MyDialog extends StatefulWidget {
  List<Ratings> _ratings;
  MyDialog(this._ratings);
  @override
  _MyDialogState createState() => new _MyDialogState();
}
class _MyDialogState extends State<MyDialog> {
  _MyDialogState();
  final formKey = GlobalKey<FormState>();
  double rateing=5;
  TextEditingController comment;
  bool isloading=false;
  double deviceHeight,deviceWidth;
  @override
  void initState() {
  comment=  TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor=Provider.of<Provider_control>(context);
    deviceHeight=MediaQuery.of(context).size.height;
    deviceWidth=MediaQuery.of(context).size.width;
    return  Stack(
      children: <Widget>[
        AlertDialog(
          content:Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  widget._ratings == null ?Container():  Container(
                    width: deviceWidth,
                    height: deviceHeight/3,
                    child: widget._ratings.isEmpty?Center(child: Text("${getTransrlate(context, 'EmptyRate')}"),):ListView.builder(
                        itemCount:   widget._ratings.length,
                        itemBuilder: (BuildContext context, int position) {
                          return ListTile(
                            title: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "#${widget._ratings[position].userId}",
                                  style: TextStyle(
                                  ),
                                ),
                                RatingBar.builder(
                                  initialRating: double.parse(widget._ratings[position].rating.toString()),
                                  itemSize: 14.0,
                                  minRating: 1,
                                  direction:
                                  Axis.horizontal,
                                  allowHalfRating: true,
                                  tapOnlyMode: false,

                                  itemCount: 5,
                                  itemBuilder:
                                      (context, _) =>
                                      Container(
                                        height: 12,
                                        child: SvgPicture.asset(
                                          "assets/icons/ic_star.svg",
                                          color: themeColor
                                              .getColor(),
                                          width: 9,
                                        ),
                                      ),
                                  onRatingUpdate: print,
                                ),

                              ],
                            ),
                            subtitle: Text(
                               "${widget._ratings[position].review??' '}",
                              style: TextStyle(
                                fontFamily: 'El_Messiri',
                              ),
                            ),
                            dense: true,
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            // Center(
            //   child: DialogButton(
            //     width: deviceWidth/4,
            //     color: themeColor.getColor(),
            //     onPressed: () async {
            //       final form = formKey.currentState;
            //       if (form.validate()) {
            //         setState(() {
            //           isloading=true;
            //         });
            //         form.save();
            //         API(context).post('add_rate', {
            //           "product_id": widget.product.id,
            //           "rate": rateing,
            //           "description": comment.text
            //         }).then((value) => {
            //           if (value['status'] != 'error')
            //             {
            //               Scaffold.of(this.context).showSnackBar(SnackBar(
            //                   backgroundColor: themeColor.getColor(),
            //                   content: Text(value['message'])))
            //             }
            //           else
            //             {
            //               Navigator.pop(context),
            //               Scaffold.of(this.context).showSnackBar(SnackBar(
            //                   backgroundColor: themeColor.getColor(),
            //                   content: Text(value['message'])))
            //             }
            //         });
            //         isloading=false;
            //       }
            //     },
            //     child: Text(
            //       getTransrlate(context, 'Comment'),
            //       style: TextStyle(color: Colors.white, fontSize: 20),
            //     ),
            //   ),
            // )
          ],
        ),
        isloading?Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black45,
            child: Center(child:  CircularProgressIndicator(
                valueColor:  AlwaysStoppedAnimation<Color>(themeColor.color)))):Container()
      ],
    );
  }
}