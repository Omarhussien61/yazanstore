import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';

class MyCounterDownTimer extends StatefulWidget {
  final DateTime date;
  const MyCounterDownTimer({Key key, this.date}) : super(key: key);

  @override
  _MyCounterDownTimerState createState() => _MyCounterDownTimerState();
}

class _MyCounterDownTimerState extends State<MyCounterDownTimer> {
  Timer timer;
  Duration duration = Duration();

  @override
  void initState() {
    if (widget.date != null && widget.date.isAfter(DateTime.now())) {
      duration = widget.date.difference(DateTime.now());
      print(duration.inDays);
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (duration.inSeconds.isNegative) {
          timer.cancel();
        } else {
          countDown();
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    if (timer != null) {
      timer.cancel();
    }

    super.dispose();
  }

  countDown() {
    setState(() {
      duration = Duration(seconds: duration.inSeconds - 1);
    });
  }

  Widget _formattedtDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigithours = twoDigits(duration.inHours.remainder(24));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DigitText(
            context: context,
            text: twoDigits(duration.inDays),
            label: 'day',
          ),
          DigitText(
            context: context,
            text: twoDigithours,
            label: 'hr',
          ),
          DigitText(
            context: context,
            text: twoDigitMinutes,
            label: 'min',
          ),
          DigitText(
            context: context,
            text: twoDigitSeconds,
            label: 'sec',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _formattedtDuration(duration);
  }
}

class DigitText extends StatelessWidget {
  const DigitText({Key key, @required this.context, this.text, this.label})
      : super(key: key);

  final BuildContext context;
  final String text;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          text,
          style: TextStyle(
              fontSize: ScreenUtil.getTxtSz(context, 16),
              fontWeight: FontWeight.w700,
              color: Provider_control('').getColor()),
        ),
        Text(
          getTransrlate(context, label),
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ],
    );
  }
}
