import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';

TextStyle controlledDrawerStyle({Color textColor, double fontSize}) {
  return TextStyle(color: textColor ?? Colors.white, fontSize: fontSize ?? 19);
}

void showSnack(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: Duration(seconds: 1),
    ),
  );
}

Future<void> getColorMode(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  String inBetween = prefs.getString('mode');

  // print('value of String inBetween is $inBetween');

  if (inBetween == null || inBetween.isEmpty) {
    print('No mode found, reverting to default');
    theme = light;
    darkMode = false;
    textColorMode = Colors.black;
  }

  inBetween == 'Color(0xff424242)' ? theme = dark : theme = light;
  inBetween == 'Color(0xff424242)' ? darkMode = true : darkMode = false;
  inBetween == 'Color(0xff424242)'
      ? textColorMode = Colors.white
      : textColorMode = Colors.black;

  // print('So finally processor function spat out $theme');
}

Future<void> getLazyMode(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  bool inBetween = prefs.getBool('lazyMode');

  // print('value of String inBetween is $inBetween');

  if (inBetween == null) {
    print('No mode found, reverting to default');
    lazyMode = false;
  }

  inBetween == true ? lazyMode = true : lazyMode = false;

  // print('So finally processor function spat out $theme');
}

Future<void> getTileMode(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  bool inBetween = prefs.getBool('tileMode');

  // print('value of String inBetween is $inBetween');

  if (inBetween == null) {
    print('No mode found, reverting to default');
    tileMode = false;
  }

  inBetween == true ? tileMode = true : tileMode = false;

  // print('So finally processor function spat out $theme');
}

var _formatter = NumberFormat('#,##,000');

customDataFormatter(int value) {
  if (lazyMode && value >= 10000000) {
    var tempInt = value / 10000000;
    String tempString = tempInt.toStringAsFixed(2);
    return '$tempString cr';
  } else if (lazyMode && value >= 1000000) {
    var tempInt = value / 100000;
    String tempString = tempInt.toStringAsFixed(2);
    return '$tempString lacs';
  } else if (lazyMode && value >= 1000) {
    var tempInt = value / 1000;
    String tempString = tempInt.toStringAsFixed(2);
    return '$tempString k';
  } else {
    return _formatter.format(value).toString();
  }
}

String commaFormatter(int value) {
  return _formatter.format(value).toString();
}

Future<void> infoDialog(BuildContext context, String text, String title) {
  return showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
          backgroundColor: Colors.cyan,
          title: Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.greenAccent[400],
                border: Border.all(
                  color: Colors.greenAccent[400],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 30),
                  FlatButton(
                    color: Colors.indigo[900],
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: Colors.indigo[900],
                        width: 3,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 45,
                      ),
                      child: Text(
                        'Ok',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ]);
    },
  );
}

void launchURL(String url) async =>
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
