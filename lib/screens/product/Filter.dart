import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:provider/provider.dart';

import '../../model/cart_category.dart';
import '../../model/manufacturers.dart';
import '../../model/origins.dart';
import '../../service/api.dart';
import '../../utils/screen_size.dart';

class Filterdialog extends StatefulWidget {
  const Filterdialog({Key key}) : super(key: key);

  @override
  _FilterdialogState createState() => _FilterdialogState();
}

class _FilterdialogState extends State<Filterdialog> {

  RangeValues _currentRangeValues;
  double min=0 ,max=90000;
  @override
  void initState() {
    _currentRangeValues =  RangeValues(min, max);
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Material(
      color: Colors.transparent,

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 4),
            height: 72,
            decoration: BoxDecoration(
              border: Border.all(color: themeColor.getColor()),
              color: themeColor.getColor(),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
                top: 8,
                left: 24,
                right: 24,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${getTransrlate(context, 'filter')}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  IconButton(
                      icon: Icon(Icons.close,
                          size: 35, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(
                          context,""
                        );
                      })
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: ScreenUtil.getWidth(context) * 0.10,
                          child: Text(
                              _currentRangeValues.start.round().toString())),
                      Container(
                        width: ScreenUtil.getWidth(context) / 1.5,
                        child: RangeSlider(
                          activeColor: themeColor.getColor(),
                          inactiveColor: Colors.black26,
                          values: _currentRangeValues,
                          min: min,
                          max: max,
                          divisions: 10000,
                          labels: RangeLabels(
                            _currentRangeValues.start.round().toString(),
                            _currentRangeValues.end.round().toString(),
                          ),
                          onChanged: (RangeValues values) {
                            setState(() {
                              _currentRangeValues = values;
                            });
                          },
                        ),
                      ),
                      Container(
                          width: ScreenUtil.getWidth(context) * 0.10,
                          child:
                          Text(_currentRangeValues.end.round().toString())),
                    ],
                  ),
                  // Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Container(
                  //         width: ScreenUtil.getWidth(context) * 0.10,
                  //         child:
                  //         Text("${getTransrlate(context, 'from')}")),
                  //     Container(
                  //       width: ScreenUtil.getWidth(context)/3,
                  //       child: MyTextFormField(enabled:false,
                  //         intialLabel:min.toString(),
                  //         onChange: (v){
                  //           setState(() {
                  //             _currentRangeValues =  RangeValues(double.parse(v),max);
                  //             min=double.parse(v);
                  //           });
                  //         },),
                  //     ),
                  //     Container(
                  //         width: ScreenUtil.getWidth(context) * 0.10,
                  //         child:
                  //         Text("${getTransrlate(context, 'to')}")),
                  //     Container(
                  //       width: ScreenUtil.getWidth(context)/3,
                  //
                  //       child: MyTextFormField(intialLabel: max.toString(),
                  //         onChange: (v){
                  //           setState(() {
                  //             _currentRangeValues =  RangeValues(min, double.parse(v));
                  //             max=double.parse(v);
                  //           });
                  //         },),
                  //     )
                  //
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context,
                              "${_currentRangeValues.start.round().toString().isEmpty?'':"&min=${_currentRangeValues.start.round().toString()}"}"
                              "${_currentRangeValues.end.round().toString().isEmpty?'':"&max=${_currentRangeValues.end.round().toString()}"}"
                              );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      width: ScreenUtil.getWidth(context) / 2.5,
                      decoration: BoxDecoration(
                          border: Border.all(color:  themeColor.getColor())),
                      child: Center(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle_outline_sharp,
                            color:  themeColor.getColor(),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'تطبيق',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:  themeColor.getColor()),
                          ),
                        ],
                      )),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}
