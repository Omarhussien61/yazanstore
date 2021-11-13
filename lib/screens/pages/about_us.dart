import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:provider/provider.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((v) {
      var prov = Provider.of<Provider_control>(context, listen: false);
      API(context).get('about').then((value) {
        if (value != null) {
          if (value['status_code'] == 200) {
            prov.setAboutUs(prov.local == 'ar'
                ? value['data']['details_ar']
                : value['data']['details']);
          }
        }
      });
      ;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Provider_control>(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
            width: ScreenUtil.getWidth(context) / 2,
            child: AutoSizeText(
              '${getTransrlate(context, 'About')}',
              minFontSize: 10,
              maxFontSize: 16,
              maxLines: 1,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: provider.aboutUs != null
                    ? Html(
                        data: provider.aboutUs,
                        customTextAlign: (c) => TextAlign.justify,
                      )
                    : CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
