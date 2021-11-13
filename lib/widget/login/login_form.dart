import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_pos/screens/account/Account.dart';
import 'package:flutter_pos/screens/account/lost_password.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:flutter_pos/widget/login/login_form_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ResultOverlay.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  Model_login model = Model_login();
  bool passwordVisible = false;
  bool PhoneStatue = false;
  String CountryNo = '';
  bool _isloading = false;
  String verificationId;
  String errorMessage = '';
  String smsOTP;
  TextEditingController otpCode = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isObsecure = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Container(
      padding: EdgeInsets.only(right: 20, left: 20),
      child: Form(
          key: _formKey,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MyTextFormField(
                    intialLabel: '',
                    keyboard_type: TextInputType.emailAddress,
                    labelText: getTransrlate(context, 'Email'),
                    hintText: getTransrlate(context, 'Email'),
                    textDirection: TextDirection.ltr,
                    suffixIcon: Icon(Icons.email),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return getTransrlate(context, 'requiredempty');
                      } else if (value.length < 8) {
                        return getTransrlate(context, 'requiredlength');
                      }
                      _formKey.currentState.save();
                      return null;
                    },
                    onSaved: (String value) {
                      model.email = "$value";
                    },
                  ),
                  MyTextFormField(
                    intialLabel: '',
                    keyboard_type: TextInputType.text,
                    labelText: getTransrlate(context, 'password'),
                    hintText: getTransrlate(context, 'password'),
                    textDirection: TextDirection.ltr,
                    isPassword: isObsecure,
                    suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            isObsecure = !isObsecure;
                          });
                        },
                        child: Icon(isObsecure ? Icons.lock : Icons.lock_open)),
                    isPhone: true,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return getTransrlate(context, 'requiredempty');
                      } else if (value.length < 5) {
                        return getTransrlate(context, 'requiredlength');
                      }
                      _formKey.currentState.save();
                      return null;
                    },
                    onSaved: (String value) {
                      model.password = "$value";
                    },
                  ),
                  _isloading
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.black),
                            ),
                          ),
                        )
                      : Container(
                          height: ScreenUtil.setHeight(context, .06),
                          width: ScreenUtil.getWidth(context),
                          margin: EdgeInsets.only(top: 25, bottom: 12),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(1.0),
                            ),
                            color: themeColor.getColor(),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                login(themeColor);
                              }
                            },
                            child: Text(
                              getTransrlate(context, 'login'),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        )
                ],
              ),
              // !isloading
              //     ? Container()
              //     : Container(
              //         color: Colors.white,
              //         height: ScreenUtil.getHeight(context) / 2,
              //         width: ScreenUtil.getWidth(context),
              //         child: Custom_Loading()),
            ],
          )),
    );
  }

  Future login(Provider_control themeColor) async {
    setState(() => _isloading = true);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    API(context, Check: false).post('login', {
      "lang": "${themeColor.getlocal()}",
      'email': model.email,
      'password': model.password
    }).then((value) {
      setState(() => _isloading = false);
      if (value != null) {
        if (value['status_code'] == 200) {
          var user = value['data'];
          prefs.setString("user_email", user['email']);
          prefs.setString("user_name", user['name']);
          prefs.setString("phone", user['phone']);

          prefs.setInt("user_id", user['id']);
          themeColor.setLogin(true);
          Phoenix.rebirth(context);
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => Account()), (r) => false);
        } else {
          showDialog(
              context: context,
              builder: (_) => ResultOverlay('${value['message']}'));
        }
      }
    });
    print(prefs.getInt("user_id"));
  }

  void showMessage(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(errorMessage),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () async {
                  Navigator.of(builderContext).pop();
                },
              )
            ],
          );
        }).then((value) {
      setState(() {
        // isLoading = false;
      });
    });
  }
}
