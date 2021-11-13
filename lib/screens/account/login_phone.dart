import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:flutter_pos/widget/register/register_form_model.dart';

class Login_Phone extends StatefulWidget {
   Login_Phone({Key key,this.model}) : super(key: key);
  Model model;
  @override
  _Login_PhoneState createState() => _Login_PhoneState();
}

class _Login_PhoneState extends State<Login_Phone> {
  final _formKey = GlobalKey<FormState>();

  String Phone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Image.asset(
        "assets/images/logo.png",
        width: ScreenUtil.getWidth(context) / 4,
      )),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(ScreenUtil.getWidth(context) / 10),
            child: Column(
              children: [
                MyTextFormField(
                  intialLabel: '',
                  keyboard_type: TextInputType.emailAddress,
                  labelText: getTransrlate(context, 'phone'),
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(6),
                  ],
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'phone');
                    }else if (value.length<10) {
                      return getTransrlate(context, 'shorterphone');
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    Phone = value;
                  },
                ),
                SizedBox(height: 25),
                Center(
                  child: GestureDetector(
                    child: Container(
                      width: ScreenUtil.getWidth(context) / 3,
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange)),
                      child: Center(
                        child: AutoSizeText(
                          getTransrlate(context, 'save'),
                          overflow: TextOverflow.ellipsis,
                          maxFontSize: 14,
                          maxLines: 1,
                          minFontSize: 10,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                      ),
                    ),
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        API(context).post('forgot',
                            {"email": Phone}).then((value) {
                          if (value != null) {
                            if (value['status_code'] == 200) {
                              showDialog(
                                  context: context,
                                  builder: (_) =>
                                      ResultOverlay("${value['message']}"));
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (_) =>
                                      ResultOverlay("${value['message']}"));
                            }
                          }
                        });
                      }
                    },
                  ),
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
