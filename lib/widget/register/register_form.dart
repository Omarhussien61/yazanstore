import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_pos/screens/account/Account.dart';
import 'package:flutter_pos/screens/homepage.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:flutter_pos/widget/register/register_form_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  Model model = Model();
  bool PhoneStatue = false;
  bool Statue = false;
  bool passwordVisible = false;
  bool _isLoading = false;
  String CountryNo = '+20';
  String verificationId;
  String errorMessage = '';
  String smsOTP;
  int checkboxValueA = 1;
  List<String> country = [];
  TextEditingController otpCode = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    return Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(right: 36, left: 48),
            child: Form(
              key: _formKey,
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
                      model.Name = value;
                    },
                  ),
                  MyTextFormField(
                    labelText: getTransrlate(context, 'Email'),
                    hintText: getTransrlate(context, 'Email'),
                    isEmail: true,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return getTransrlate(context, 'requiredempty');
                      } else if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                          .hasMatch(value)) {
                        return getTransrlate(context, 'invalidemail');
                      }
                      _formKey.currentState.save();
                      return null;
                    },
                    onSaved: (String value) {
                      model.email = value;
                    },
                  ),
                  MyTextFormField(
                    labelText: getTransrlate(context, 'password'),
                    hintText: getTransrlate(context, 'password'),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black26,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                    isPassword: passwordVisible,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return getTransrlate(context, 'requiredempty');
                      } else if (value.length < 8) {
                        return getTransrlate(context, 'PasswordShorter');
                      }
                      // else if (!value.contains(new RegExp(
                      //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'))) {
                      //   return "${getTransrlate(context, 'invalidpass')}";
                      // }
                      _formKey.currentState.save();

                      return null;
                    },
                    onSaved: (String value) {
                      model.password = value;
                    },
                  ),
                  MyTextFormField(
                    labelText: getTransrlate(context, 'ConfirmPassword'),
                    hintText: getTransrlate(context, 'ConfirmPassword'),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black26,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                    isPassword: passwordVisible,
                    validator: (String value) {
                      if (value != model.password) {
                        return getTransrlate(context, 'Passwordmatch');
                      }
                      _formKey.currentState.save();

                      return null;
                    },
                    onSaved: (String value) {
                      model.password_confirmation = value;
                    },
                  ),
                  MyTextFormField(
                    intialLabel: '',
                    keyboard_type: TextInputType.phone,
                    labelText: getTransrlate(context, 'phone'),
                    hintText: getTransrlate(context, 'phone'),
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
                      model.phone = "$value";
                    },
                  ),
                  _isLoading
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.black),
                            ),
                          ),
                        )
                      : Container(
                          height: 40,
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
                                await register(themeColor);
                                // register(themeColor);
                              }
                            },
                            child: Text(
                              getTransrlate(context, 'RegisterNew'),
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
            )),
      ],
    );
  }

  register(Provider_control themeColor) async {
    model.gender = checkboxValueA.toString();
    setState(() => _isLoading = true);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    API(context).post('register', {
      'name': model.Name,
      'email': model.email.trim(),
      "lang": "${themeColor.getlocal()}",
      'password': model.password,
      "password_confirmation": model.password_confirmation,
      "phone": model.phone,
    }).then((value) {
      if (value['status_code'] == 200) {
        setState(() => _isLoading = false);
        var user = value['data'];
        prefs.setString("user_email", user['email']);
        prefs.setString("user_name", user['name']);
        prefs.setString("phone", user['phone']);
        prefs.setInt("user_id", user['id']);
        themeColor.setLogin(true);
        Phoenix.rebirth(context);
      } else {
        showDialog(
            context: context,
            builder: (_) => ResultOverlay('${value['message']}'));
        setState(() => _isLoading = false);
        setState(() => PhoneStatue = false);
      }
    });
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    print("verification completed ${authCredential.smsCode}");
    User user = FirebaseAuth.instance.currentUser;
    setState(() {
      this.otpCode.text = authCredential.smsCode;
    });
    if (authCredential.smsCode != null) {
      try {
        UserCredential credential =
            await user.linkWithCredential(authCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'provider-already-linked') {
          await _auth.signInWithCredential(authCredential);
        }
      }
      setState(() {
        // isLoading = false;
      });
      // Navigator.pushNamedAndRemoveUntil(
      //     context, Constants.homeNavigate, (route) => false);
    }
  }

  _onVerificationFailed(FirebaseAuthException exception) {
    if (exception.code == 'invalid-phone-number') {
      showMessage("The phone number entered is invalid!");
    }
  }

  _onCodeSent(String verificationId, int forceResendingToken) {
    this.verificationId = verificationId;
    print(forceResendingToken);
    setState(() {
      PhoneStatue = true;
    });
    //Nav.route(context, Login_Phone(model: model,));
  }

  _onCodeTimeout(String timeout) {
    return null;
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

  signIn(Provider_control themeColor) async {
    setState(() => _isLoading = false);

    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final User user = (await _auth.signInWithCredential(credential)).user;
      final User currentUser = await FirebaseAuth.instance.currentUser;
      assert(user.uid == currentUser.uid);
      setState(() {
        Statue = true;
      });
    } catch (e) {
      showMessage("$e");
    }
  }
}
