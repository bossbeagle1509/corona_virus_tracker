import 'dart:ui';

import 'package:corona_virus_tracker/constants.dart';
import 'package:corona_virus_tracker/waiting.dart';
import 'package:flutter/material.dart';
import 'getter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => HomePage(),
        // '/second': (context) => SecondScreen(),
      },
      title: 'COVID 19 Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // setState(() {
    yesterday =
        DateTime.now().subtract(Duration(days: 1)).toString().substring(0, 10);

    dayBefore =
        DateTime.now().subtract(Duration(days: 2)).toString().substring(0, 10);
    // });
    print('Just updated today: $yesterday');
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        print('The height in inches is ${MediaQuery.of(context).size.height}'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen();
  }
}
