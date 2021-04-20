import 'package:corona_virus_tracker/providers/appSettings.dart';
import 'package:corona_virus_tracker/utils/conveniences.dart';
import 'package:corona_virus_tracker/utils/drawer.dart';
import 'package:corona_virus_tracker/utils/getter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_switch/sliding_switch.dart';
import '../utils/constants.dart';

class CardView extends StatefulWidget {
  static String id = 'home';
  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  Networker instance = Networker();

  Color standardBlue = Colors.indigo[900];
  bool selState = false;

  @override
  Widget build(BuildContext context) {
    final _appSettings = Provider.of<AppSettings>(context);
    return Scaffold(
      backgroundColor: _appSettings.theme,
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: _appSettings.theme,
        ),
        child: NavDrawer(),
      ),
      appBar: AppBar(
        title: Text(
          'COVID 19 Tracker',
          style: TextStyle(
            color: Colors.indigo[900],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent[400],
        actions: [
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: Colors.indigo[900],
              size: 30,
            ),
            onPressed: () {
              infoDialog(
                context,
                'The values, \'Active Diff.\', \'Recov. Diff.\' and \'Death Diff.\' are the number of new active, recovered and death cases respectively, compared to the values on $dayBefore. ',
                'Important',
              );
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
                    });
                    print('The boolean is now $selState');
                    instance.refresh(context: context, mode: selState);
                    print('Loading new page with $selState mode');
                    setState(() {});
                  },
                  onSwipe: (bool value) async {
                    setState(() {
                      selState = value;
                    });
                    print('The boolean is now $selState');
                    await instance.refresh(context: context, mode: selState);
                    print('Loading new page with $selState mode');
                    setState(() {});
                  },
                  textOff: "Yesterday",
                  textOn: "Day Before",
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
                          Element(
                            title: 'Date ',
                            data: date.toString(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Confirmed: ',
                                style: kTitle.copyWith(fontSize: 19),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    _appSettings.customDataFormatter(confirmed),
                                    style: kData.copyWith(fontSize: 19),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Element(
                            title: 'Active',
                            data: _appSettings.customDataFormatter(active),
                          ),
                          Element(
                            title: 'Deaths',
                            data: _appSettings.customDataFormatter(deaths),
                          ),
                          Element(
                            title: 'Recovered',
                            data: _appSettings.customDataFormatter(recovered),
                          ),
                          Element(
                            title: 'Fatality Rate',
                            data: fatalityRate.toString(),
                          ),
                          Element(
                            title: 'Active Diff',
                            data: _appSettings.customDataFormatter(activeDiff),
                          ),
                          Element(
                            title: 'Death Diff',
                            data: _appSettings.customDataFormatter(deathDiff),
                          ),
                          Element(
                            title: 'Recov. Diff ',
                            data: _appSettings.customDataFormatter(recovDiff),
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
