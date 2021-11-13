import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pos/model/user_info.dart';
import 'package:flutter_pos/screens/account/changePasswordPAge.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  String id, name, email;
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  bool _isLoading = false;
  USer userModal;
  String password;
  final _formKey = GlobalKey<FormState>();
  List<String> items = ["male", "female"];
  TextEditingController _tocontroller = TextEditingController();

  submitForm() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    _isLoading = true;
    try {
      setState(() => _isLoading = false);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/User Icon.svg",
                color: Colors.white,
                height: ScreenUtil.setHeight(context, .04),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                getTransrlate(context, 'ProfileSettings'),
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            _isLoading
                ? Container(
                    // height: double.infinity,
                    // width: double.infinity,
                    color: Colors.white,
                    child: Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                themeColor.getColor()))))
                : userModal == null
                    ? Container()
                    : Container(
                        color: Colors.white,
                        child: Container(
                          color: Colors.white,
                          child: Container(
                            color: Color(0xffFFFFFF),
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 15.0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Text(
                                        getTransrlate(context, 'name'),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: TextFormField(
                                          initialValue: userModal.name,
                                          decoration: const InputDecoration(
                                            hintText: "أدخل الاسم",
                                          ),
                                          enabled: !_status,
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return getTransrlate(
                                                  context, 'Firstname');
                                            }
                                            _formKey.currentState.save();
                                            return null;
                                          },
                                          autofocus: !_status,
                                          onSaved: (String val) =>
                                              userModal.name = val,
                                          onChanged: (String val) {
                                            userModal.name = val;
                                          },
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Text(
                                        getTransrlate(context, 'City'),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: TextFormField(
                                          initialValue: userModal.city,
                                          decoration: const InputDecoration(
                                            hintText: "أدخل الاسم",
                                          ),
                                          enabled: !_status,
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return getTransrlate(
                                                  context, 'City');
                                            }
                                            _formKey.currentState.save();
                                            return null;
                                          },
                                          autofocus: !_status,
                                          onSaved: (String val) =>
                                              userModal.city = val,
                                          onChanged: (String val) {
                                            userModal.city = val;
                                          },
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Text(
                                        "zip",
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: TextFormField(
                                          initialValue: userModal.zip,
                                          decoration: const InputDecoration(
                                            hintText: "zip",
                                          ),
                                          enabled: !_status,
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return "zip";
                                            }
                                            _formKey.currentState.save();
                                            return null;
                                          },
                                          autofocus: !_status,
                                          onSaved: (String val) =>
                                              userModal.zip = val,
                                          onChanged: (String val) {
                                            userModal.zip = val;
                                          },
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Text(
                                        getTransrlate(context, 'Address1'),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: TextFormField(
                                          initialValue: userModal.address,
                                          decoration: InputDecoration(
                                            hintText:
                                                "${getTransrlate(context, 'Address1')}",
                                          ),
                                          enabled: !_status,
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return getTransrlate(
                                                  context, 'Address1');
                                            }
                                            _formKey.currentState.save();
                                            return null;
                                          },
                                          autofocus: !_status,
                                          onSaved: (String val) =>
                                              userModal.address = val,
                                          onChanged: (String val) {
                                            userModal.address = val;
                                          },
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Text(
                                        getTransrlate(context, 'Address2'),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: TextFormField(
                                          initialValue: userModal.address2,
                                          decoration: const InputDecoration(
                                            hintText: "أدخل الاسم",
                                          ),
                                          enabled: !_status,
                                          autofocus: !_status,
                                          onSaved: (String val) =>
                                              userModal.address2 = val,
                                          onChanged: (String val) {
                                            userModal.address2 = val;
                                          },
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: Text(
                                          getTransrlate(context, 'mail'),
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: TextFormField(
                                          initialValue: userModal.email,
                                          decoration: const InputDecoration(),
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return getTransrlate(
                                                  context, 'mail');
                                            } else if (!RegExp(
                                                    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                                .hasMatch(value)) {
                                              return getTransrlate(
                                                  context, 'invalidemail');
                                            }
                                            _formKey.currentState.save();
                                            return null;
                                          },
                                          enabled: false,
                                          onSaved: (String val) =>
                                              userModal.email = val,
                                          onChanged: (String val) =>
                                              userModal.email = val,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: Text(
                                          getTransrlate(context, 'phone'),
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width:
                                                  ScreenUtil.getWidth(context) /
                                                      1.5,
                                              child: TextFormField(
                                                textAlign: TextAlign.left,
                                                textDirection:
                                                    TextDirection.ltr,
                                                inputFormatters: [
                                                  new LengthLimitingTextInputFormatter(
                                                      14),
                                                ],
                                                initialValue: userModal.phone,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(),
                                                validator: (String value) {
                                                  if (value.isEmpty) {
                                                    return getTransrlate(
                                                        context, 'phone');
                                                  } else if (value.length >
                                                      15) {
                                                    return "${getTransrlate(context, 'phone')} > 14";
                                                  } else if (value.length < 9) {
                                                    return "${getTransrlate(context, 'phone')} < 9";
                                                  }
                                                  _formKey.currentState.save();
                                                  return null;
                                                },
                                                enabled: true,
                                                onSaved: (String val) =>
                                                    userModal.phone = val,
                                                onChanged: (String val) =>
                                                    userModal.phone = val,
                                              ),
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    _status
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              //   password==null?Container():_getChangePassword(),
                                              _getEditIcon(),
                                            ],
                                          )
                                        : _getActionButtons(themeColor),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ))
          ]),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons(Provider_control themeColor) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: InkWell(
                  onTap: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      //  final SharedPreferences prefs = await SharedPreferences.getInstance();
                      //setState(() => _isLoading = true);
                      API(context).post('user/${id}/update', {
                        "name": userModal.name,
                        "email": userModal.email,
                        "lang": "${themeColor.getlocal()}",
                        "phone": userModal.phone,
                        "address": userModal.address,
                        "address2": userModal.address2,
                        "city": userModal.city,
                        "zip": userModal.zip,
                      }).then((value) {
                        if (value != null) {
                          if (value['status_code'] == 200) {
                            getUser();
                            showDialog(
                                context: context,
                                builder: (_) =>
                                    ResultOverlay("${value['message']}"));
                            setState(() {
                              _status = true;
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            });
                          } else {
                            showDialog(
                                context: context,
                                builder: (_) =>
                                    ResultOverlay(value['message']));
                          }
                        }
                      });
                    }
                  },
                  child: Container(
                      width: ScreenUtil.getWidth(context) / 2.5,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange)),
                      child: Center(
                        child: Text(
                          getTransrlate(context, 'save'),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                      )),
                ),
              ),
              flex: 2,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _status = true;
                      FocusScope.of(context).requestFocus(new FocusNode());
                    });
                  },
                  child: Container(
                      width: ScreenUtil.getWidth(context) / 2.5,
                      padding: const EdgeInsets.all(10.0),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Center(
                        child: Text(
                          getTransrlate(context, 'cancel'),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      )),
                ),
              ),
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getEditIcon() {
    return Center(
      child: GestureDetector(
        child: Container(
          width: ScreenUtil.getWidth(context) / 2.5,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
          child: Center(
            child: AutoSizeText(
              getTransrlate(context, 'edit'),
              overflow: TextOverflow.ellipsis,
              maxFontSize: 14,
              maxLines: 1,
              minFontSize: 10,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
            ),
          ),
        ),
        onTap: () {
          setState(() {
            _status = false;
          });
        },
      ),
    );
  }

  Widget _getChangePassword() {
    return Center(
      child: GestureDetector(
        child: Container(
          width: ScreenUtil.getWidth(context) / 2.5,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
          child: Center(
            child: AutoSizeText(
              getTransrlate(context, 'changePassword'),
              overflow: TextOverflow.ellipsis,
              maxFontSize: 14,
              maxLines: 1,
              minFontSize: 10,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
            ),
          ),
        ),
        onTap: () {
          Nav.route(context, changePassword());
        },
      ),
    );
  }

  void getUser() {
    SharedPreferences.getInstance().then((pref) => {
          setState(() {
            id = pref.getInt('user_id').toString();
            name = pref.getString('user_name');
            email = pref.getString('user_email');
            password = pref.getString('password');
          }),
          API(context)
              .get('user-profile/${pref.getInt('user_id')}')
              .then((value) {
            print(value);
            if (value != null) {
              if (value['status_code'] == 200) {
                var user = value['data'];
                pref.setString("user_email", user['email'] ?? ' ');
                pref.setString("phone", user['phone'] ?? '');
                pref.setString("user_name", user['name'] ?? ' ');
                pref.setString("address", user['address'] ?? '');

                setState(() {
                  userModal = USer.fromJson(value['data']);
                });
              } else {
                showDialog(
                    context: context,
                    builder: (_) => ResultOverlay("${value['message']}"));
              }
            }
          })
        });
  }
}
