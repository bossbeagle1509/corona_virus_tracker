import 'package:corona_virus_tracker/providers/appSettings.dart';
import 'package:corona_virus_tracker/providers/dateStuff.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

TextStyle controlledDrawerStyle({Color textColor, double fontSize}) {
  return TextStyle(color: textColor ?? Colors.white, fontSize: fontSize ?? 19);
}

void showSnack(BuildContext context, String text) {
  final _appSettings = Provider.of<AppSettings>(context, listen: false);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: _appSettings.textColorMode,
      content: Text(
        text,
        style: TextStyle(
          fontSize: 19,
          color: _appSettings.theme,
        ),
      ),
      duration: Duration(seconds: 1),
    ),
  );
}

Future<void> getColorMode(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final _appSettings = Provider.of<AppSettings>(context, listen: false);

  String inBetween = prefs.getString('mode');

  if (inBetween == null || inBetween.isEmpty) {
    print('No mode found, reverting to light');
    _appSettings.setDarkMode(false);
  }

  inBetween == 'Color(0xff424242)'
      ? _appSettings.setDarkMode(true)
      : _appSettings.setDarkMode(false);
}

Future<void> getLazyMode(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final _appSettings = Provider.of<AppSettings>(context, listen: false);
  bool inBetween = prefs.getBool('lazyMode');

  if (inBetween == null) {
    print('No mode found, reverting to false');
    inBetween = false;
  }

  // ignore: unnecessary_statements
  inBetween ? _appSettings.setLazyMode(true) : null;
}

Future<void> getTileMode(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final _appSettings = Provider.of<AppSettings>(context, listen: false);

  bool inBetween = prefs.getBool('tileMode');

  if (inBetween == null) {
    print('No mode found, reverting to false');
    inBetween = false;
  }

  // ignore: unnecessary_statements
  inBetween ? _appSettings.setDisplayMode(true) : null;
}

Future<void> getDates(BuildContext context) async {
  final _dateStore = Provider.of<DateStuff>(context, listen: false);

  _dateStore.getActualYesterday();

  _dateStore.setYesterdayInProvider(1);
  _dateStore.setDayBeforeInProvider(2);
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
