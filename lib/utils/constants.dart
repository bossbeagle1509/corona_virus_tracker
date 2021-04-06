import 'package:flutter/material.dart';

String yesterday;
String dayBefore;
// String state = 'Karnataka';

const kTitle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  color: Colors.white,
);

const kData = TextStyle(
  fontSize: 20,
  color: Colors.white,
);

const kDrawerStyle = TextStyle(color: Colors.white, fontSize: 19);

const kHeading = TextStyle(fontSize: 18, color: Colors.white);

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

/// original variables

String date;
String lastUpdate;
int deaths;
String precious;
int recovered;
int active;
double fatalityRate;
int confirmed;
int deathDiff;
int activeDiff;
int recovDiff;

/// new variables

// var date;
// var lastUpdate;
// var deaths;
// var precious;
// var recovered;
// var active;
// var fatalityRate;
// var confirmed;
// var deathDiff;
// var activeDiff;
// var recovDiff;
