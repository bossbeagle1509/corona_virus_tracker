import 'dart:ui';

import 'package:corona_virus_tracker/getter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'constants.dart';

class HomePage extends StatefulWidget {
  // final bool carryForward;
  // final String date;
  // final String lastUpdate;
  // final int deaths;
  // final int recovered;
  // final int active;
  // final double fatalityRate;
  // final int confirmed;
  // final int recovDiff;
  // final int deathDiff;
  // final int activeDff;
  //
  // HomePage({
  //   this.carryForward,
  //   this.date,
  //   this.deaths,
  //   this.recovered,
  //   this.active,
  //   this.fatalityRate,
  //   this.lastUpdate,
  //   this.confirmed,
  //   this.recovDiff,
  //   this.activeDff,
  //   this.deathDiff,
  // });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Networker instance = Networker();

  Color standardBlue = Colors.indigo[900];
  bool selState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: Text('COVID 19 Tracker'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent[400],
        leading: Container(),
        actions: [
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: Colors.indigo[900],
              size: 30,
            ),
            onPressed: () {
              infoDialog(context,
                  'The values, \'Active Diff.\', \'Recov. Diff.\' and \'Death Diff.\' are the number of new active, recovered and death cases respectively, compared to the values on $dayBefore. ');
            },
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SlidingSwitch(
                  value: selState,
                  width: 250,
                  onChanged: (bool value) async {
                    setState(() {
                      selState = value;
                      // urlMode = value;
                    });
                    print('The boolean is now $selState');
                    await instance.refresh(context: context, mode: selState);
                    print('Loading new page with $selState mode');
                    setState(() {});
                  },
                  height: 55,
                  animationDuration: const Duration(milliseconds: 400),
                  onTap: (bool value) {
                    setState(() {
                      selState = value;
                      // urlMode = value;
                    });
                    print('The boolean is now $selState');
                    instance.refresh(context: context, mode: selState);
                    print('Loading new page with $selState mode');
                    setState(() {});
                  },
                  onSwipe: (bool value) async {
                    setState(() {
                      selState = value;
                      // urlMode = value;
                    });
                    print('The boolean is now $selState');
                    await instance.refresh(context: context, mode: selState);
                    print('Loading new page with $selState mode');
                    setState(() {});
                  },
                  // onTap: (value) {
                  //   setState(() {
                  //     selState = value;
                  //   });
                  // },
                  // onSwipe: (value) {},
                  textOff: "Yesterday",
                  textOn: "Day Before",
                  // colorOn: Colors.greenAccent[400],
                  // colorOff: Colors.greenAccent[400],
                  colorOn: Colors.indigo[900],
                  colorOff: Colors.indigo[900],
                  background: const Color(0xffe4e5eb),
                  buttonColor: const Color(0xfff7f5f7),
                  inactiveColor: const Color(0xff636f7b),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Container(
                  child: Card(
                    color: standardBlue,
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 20.0,
                        left: 20.0,
                        top: 20,
                      ),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Updated: ',
                                    style: kTitle,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        lastUpdate,
                                        style: kData.copyWith(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                            ],
                          ),
                          // Element(
                          //   title: 'Updated ',
                          //   data: widget.lastUpdate,
                          // ),
                          Element(
                            title: 'Date ',
                            data: date.toString(),
                          ),
                          Element(
                            title: 'Confirmed ',
                            data: confirmed.toString(),
                          ),
                          Element(
                            title: 'Active',
                            data: active.toString(),
                          ),
                          Element(
                            title: 'Deaths',
                            data: deaths.toString(),
                          ),
                          Element(
                            title: 'Recovered',
                            data: recovered.toString(),
                          ),
                          Element(
                            title: 'Fatality Rate',
                            data: fatalityRate.toString(),
                          ),
                          Element(
                            title: 'Active Diff',
                            data: activeDiff.toString(),
                          ),
                          Element(
                            title: 'Death Diff',
                            data: deathDiff.toString(),
                          ),
                          Element(
                            title: 'Recov. Diff ',
                            data: recovDiff.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Element extends StatelessWidget {
  final String title;
  final String data;

  Element({this.title, this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$title: ',
              style: kTitle,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  data,
                  style: kData,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.05,
        ),
      ],
    );
  }
}
