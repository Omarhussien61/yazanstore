import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:provider/provider.dart';

class Contact extends StatelessWidget {
  Contact({Key key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  String name, email, phone, massage;
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Scaffold(
      appBar: AppBar(
        title: Container(
            width: ScreenUtil.getWidth(context) / 2,
            child: AutoSizeText(
              '${getTransrlate(context, 'contact')}',
              minFontSize: 10,
              maxFontSize: 16,
              style: TextStyle(color: Colors.white),
              maxLines: 1,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: ScreenUtil.setHeight(context, .2),
              ),
              Text(
                '${getTransrlate(context, 'suggestions')}',
                style: TextStyle(
                  fontSize: ScreenUtil.getTxtSz(context, 18),
                  color: themeColor.getColor(),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                '${getTransrlate(context, 'Help')}',
                style: TextStyle(
                  fontSize: ScreenUtil.getTxtSz(context, 18),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                '${getTransrlate(context, 'SendAmessage')}',
                style: TextStyle(
                  fontSize: ScreenUtil.getTxtSz(context, 18),
                  fontWeight: FontWeight.w500,
                ),
              ),
              // SizedBox(
              //   height: 15,
              // ),
              // Text(
              //   '${getTransrlate(context, 'contact')}',
              //   style: TextStyle(
              //     fontSize: 25,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              SizedBox(
                height: 15,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      // Set border width
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0)), // Set rounded corner radius
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            color: Colors.black12,
                            offset: Offset(1, 3))
                      ] // Make rounded corner of border
                      ),
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: <Widget>[
                          MyTextFormField(
                            labelText: getTransrlate(context, 'name'),
                            hintText: getTransrlate(context, 'name'),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return getTransrlate(context, 'requiredempty');
                              } else if (RegExp(r"^[+-]?([0-9]*[.])?[0-9]+")
                                  .hasMatch(value)) {
                                return getTransrlate(context, 'invalidname');
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              name = value;
                            },
                          ),
                          MyTextFormField(
                            labelText: getTransrlate(context, 'Email'),
                            hintText: getTransrlate(context, 'Email'),
                            isEmail: true,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return getTransrlate(context, 'requiredempty');
                              }
                              _formKey.currentState.save();
                              return null;
                            },
                            onSaved: (String value) {
                              email = value;
                            },
                          ),
                          MyTextFormField(
                            labelText: getTransrlate(context, 'phone'),
                            hintText: getTransrlate(context, 'phone'),
                            isEmail: true,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return getTransrlate(context, 'requiredempty');
                              }
                              _formKey.currentState.save();
                              return null;
                            },
                            onSaved: (String value) {
                              phone = value;
                            },
                          ),
                          MyTextFormField(
                            labelText: getTransrlate(context, 'massage'),
                            hintText: getTransrlate(context, 'massage'),
                            isEmail: true,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return getTransrlate(context, 'requiredempty');
                              }
                              _formKey.currentState.save();
                              return null;
                            },
                            onSaved: (String value) {
                              massage = value;
                            },
                          ),
                          Container(
                            height: ScreenUtil.setHeight(context, .1),
                            width: ScreenUtil.getWidth(context),
                            margin: EdgeInsets.only(top: 12, bottom: 0),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(1.0),
                              ),
                              color: themeColor.getColor(),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  API(context).post('contact', {
                                    "name": "$name",
                                    "email": "$email",
                                    "lang": "${themeColor.getlocal()}",
                                    "phone": phone,
                                    "message": massage
                                  }).then((value) {
                                    print(value);
                                    if (value['status_code'] == 200) {
                                      // Navigator.pop(context);
                                    }
                                    showDialog(
                                        context: context,
                                        builder: (_) => ResultOverlay(
                                            '${value['message']}'));
                                  });
                                }
                              },
                              child: Text(
                                getTransrlate(context, 'Submit'),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
