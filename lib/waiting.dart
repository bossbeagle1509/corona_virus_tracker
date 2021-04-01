import 'package:corona_virus_tracker/getter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Networker networker = Networker();
    networker.handler(context: context, mode: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.indigo[900],
          size: 100,
          duration: Duration(milliseconds: 800),
        ),
      ),
    );
  }
}
