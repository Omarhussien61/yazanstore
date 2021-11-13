import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_pos/screens/account/signUP_page.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/login/login_form.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as JSON;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name, email, facebook_id;
  Provider_control themeColor;

  @override
  Widget build(BuildContext context) {
    themeColor = Provider.of<Provider_control>(context);

    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25,
            ),
            Container(
                child: Image.asset(
              'assets/images/logo.png',
              height: ScreenUtil.getHeight(context) / 5,
              width: ScreenUtil.getWidth(context),
              fit: BoxFit.contain,
              //color: themeColor.getColor(),
            )),
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 1,
                      width: ScreenUtil.getWidth(context) / 4,
                      color: Colors.black12,
                    ),
                    Text(
                      getTransrlate(context, 'login'),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 1,
                      width: ScreenUtil.getWidth(context) / 4,
                      color: Colors.black12,
                    )
                  ],
                ),
              ),
            ),
            LoginForm(),
            routeLoginWidget(themeColor, context),
          ],
        ),
      ),
    ));
  }

  Widget routeLoginWidget(Provider_control themeColor, BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: ScreenUtil.getWidth(context) / 4,
                    color: Colors.black12,
                  ),
                  Text(
                    getTransrlate(context, 'or'),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 1,
                    width: ScreenUtil.getWidth(context) / 4,
                    color: Colors.black12,
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton(
                minWidth: ScreenUtil.getWidth(context) / 2.5,
                height: ScreenUtil.setHeight(context, .05),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1.0),
                    side: BorderSide(color: Colors.black26)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/facebook_2_.svg',
                        height: ScreenUtil.setHeight(context, .05),
                        width: ScreenUtil.setWidth(context, .2),
                        color: Color(0xff3D2FA4),
                      ),
                      SizedBox(width: 5),
                      Text(
                        " ${getTransrlate(context, 'facebook')}",
                        style: TextStyle(
                          fontSize: ScreenUtil.getTxtSz(context, 16),
                          color: Color(0xff3D2FA4),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  loginWithFB(context);
                },
              ),
              FlatButton(
                minWidth: ScreenUtil.getWidth(context) / 2.5,
                height: ScreenUtil.setHeight(context, .05),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1.0),
                    side: BorderSide(color: Colors.black26)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset('assets/icons/google-icon.svg',
                          height: ScreenUtil.setHeight(context, .05),
                          width: ScreenUtil.setWidth(context, .2)),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${getTransrlate(context, 'google')}",
                      style: TextStyle(
                        fontSize: ScreenUtil.getTxtSz(context, 16),
                        color: themeColor.getColor(),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  login(context).then((e) {
                    if (e != null) {
                      register(themeColor);
                    }
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: ScreenUtil.getWidth(context) / 4,
                    color: Colors.black12,
                  ),
                  Container(
                      child: Text(
                    getTransrlate(context, 'RegisterNew'),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Container(
                    height: 1,
                    width: ScreenUtil.getWidth(context) / 4,
                    color: Colors.black12,
                  )
                ],
              ),
            ),
          ),
          FlatButton(
            minWidth: ScreenUtil.getWidth(context),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1.0),
                side: BorderSide(color: Colors.black26)),
            child: Text(
              getTransrlate(context, 'AreadyAccount'),
              style: TextStyle(
                fontSize: ScreenUtil.getTxtSz(context, 16),
                color: themeColor.getColor(),
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () {
              Nav.routeReplacement(context, SignUpPage());
            },
          )
        ],
      ),
    );
  }

  Future<UserCredential> login(BuildContext context) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      email = googleUser.email;
      name = googleUser.displayName;
      facebook_id = googleUser.id;
      print(googleAuth.accessToken);
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      register(themeColor);
    } catch (e) {
      print(e);
    }

    // Once signed in, return the UserCredential
  }

  loginWithFB(BuildContext context) async {
    final facebookLogin = FacebookLogin();
    facebookLogin.logOut();
    final result = await facebookLogin.logIn(["public_profile", "email"]);
    print(result.accessToken.permissions);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final full_url = Uri.parse(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
        final graphResponse = await http.get(full_url);
        final profil = JSON.jsonDecode(graphResponse.body);
        print(graphResponse.body);
        email = profil['email'];
        name = profil['name'];
        facebook_id = "${profil['id']}";

        await register(themeColor);
        break;

      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        break;
    }
  }

  Map ss = {
    "name": "Ahmed Mosaad",
    "picture": {
      "data": {
        "height": 50,
        "is_silhouette": false,
        "url":
            "https:\/\/platform-lookaside.fbsbx.com\/platform\/profilepic\/?asid=598080701606571&height=50&width=50&ext=1637589471&hash=AeTC9PgAiLpPdM5VOEA",
        "width": 50
      }
    },
    "id": "598080701606571"
  };

  register(Provider_control themeColor) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    API(context).post('social_register', {
      "name": "$name",
      "email": "$email",
      "provider_id": "$facebook_id",
      "lang": "${themeColor.getlocal()}",
      "provider": "Facebook"
    }).then((value) {
      print(value);
      if (value['status_code'] == 200) {
        var user = value['data'];
        prefs.setString("user_email", user['email']);
        prefs.setString("user_name", user['name']);
        prefs.setString("phone", user['phone'] ?? '');
        prefs.setString("address", user['address'] ?? '');

        prefs.setInt("user_id", user['id']);
        themeColor.setLogin(true);
        Phoenix.rebirth(context);
      } else {
        showDialog(
            context: context,
            builder: (_) => ResultOverlay('${value['message']}}'));
      }
    });
  }
}
