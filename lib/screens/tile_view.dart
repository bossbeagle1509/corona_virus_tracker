import 'package:corona_virus_tracker/providers/appSettings.dart';
import 'package:corona_virus_tracker/providers/dataStore.dart';
import 'package:corona_virus_tracker/providers/dateStuff.dart';
import 'package:corona_virus_tracker/screens/custom_tile.dart';
import 'package:corona_virus_tracker/utils/constants.dart';
import 'package:corona_virus_tracker/utils/conveniences.dart';
import 'package:corona_virus_tracker/utils/drawer.dart';
import 'package:corona_virus_tracker/utils/getter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_switch/sliding_switch.dart';

class TileView extends StatefulWidget {
  static String id = 'tileView';

  @override
  _TileViewState createState() => _TileViewState();
}

class _TileViewState extends State<TileView> {
  @override
  Widget build(BuildContext context) {
    Networker instance = Networker();

    final _appSettings = Provider.of<AppSettings>(context);
    final _dateStuff = Provider.of<DateStuff>(context);
    final _dataStore = Provider.of<DataStore>(context);

    return Scaffold(
      backgroundColor: _appSettings.theme,
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: _appSettings.theme,
        ),
        child: NavDrawer(),
      ),
      appBar: AppBar(
        centerTitle: true,
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
                _dateStuff.fancySchistDoneToDates
                    ? 'The values, \'Active Diff.\', \'Recov. Diff.\' and \'Death Diff.\' are the number of new active, recovered and death cases respectively, compared to the values on ${_dateStuff.dayBefore}. \n\n Why am I seeing data for ${_dateStuff.yesterday} and not ${_dateStuff.actualYesterday}?\n\nThe API provider updates data for the previous day post 11.30 AM IST, and so, until then data for the day before will be displayed.'
                    : 'The values, \'Active Diff.\', \'Recov. Diff.\' and \'Death Diff.\' are the number of new active, recovered and death cases respectively, compared to the values on ${_dateStuff.dayBefore}. ',
                'Important',
              );
            },
          ),
        ],
        backgroundColor: Colors.greenAccent[400],
        title: Text(
          'Covid 19 Tracker',
          style: TextStyle(color: Colors.indigo[900]),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height + 120,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: SlidingSwitch(
                    value: _dateStuff.sliderVal,
                    width: 250,
                    onChanged: (bool value) async {
                      _dateStuff.toggleSliderVal();
                      instance.handlerWithoutPush(
                          context: context, mode: _dateStuff.sliderVal);
                      // setState(() {});
                    },
                    height: 55,
                    animationDuration: const Duration(milliseconds: 400),
                    onTap: (bool value) {
                      _dateStuff.toggleSliderVal();
                      instance.handlerWithoutPush(
                          context: context, mode: _dateStuff.sliderVal);
                      // setState(() {});
                    },
                    onSwipe: (bool value) async {
                      _dateStuff.toggleSliderVal();
                      instance.handlerWithoutPush(
                          context: context, mode: _dateStuff.sliderVal);
                      // setState(() {});
                    },
                    textOff: "Yesterday",
                    textOn: "Day Before",
                    colorOn: Colors.indigo[900],
                    colorOff: Colors.indigo[900],
                    background: const Color(0xffe4e5eb),
                    buttonColor: const Color(0xfff7f5f7),
                    inactiveColor: const Color(0xff636f7b),
                  ),
                ),
                Expanded(
                  child: GridView(
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(10.0),
                    children: [
                      CustomTile(
                        title: 'Updated',
                        content: _dataStore.lastUpdate,
                        textSize: 18,
                        backgroundColor: Colors.blueGrey,
                      ),
                      CustomTile(
                        title: 'Date',
                        content: _dataStore.date,
                        backgroundColor: Colors.greenAccent[400],
                      ),
                      CustomTile(
                        title: 'Confirmed',
                        content: _appSettings
                            .customDataFormatter(_dataStore.confirmed),
                        // content: _formatter.format(confirmed).toString(),
                        backgroundColor: Colors.orangeAccent,
                      ),
                      CustomTile(
                        title: 'Confi. Diff',
                        content: _appSettings
                            .customDataFormatter(_dataStore.confirmedDiff),
                        // content: _formatter.format(confirmed).toString(),
                        backgroundColor: Colors.redAccent,
                      ),
                      CustomTile(
                        title: 'Active',
                        content:
                            _appSettings.customDataFormatter(_dataStore.active),
                        backgroundColor: Colors.purpleAccent,
                      ),
                      CustomTile(
                        title: 'Active Diff.',
                        content: _appSettings
                            .customDataFormatter(_dataStore.activeDiff),
                        backgroundColor: Colors.pinkAccent,
                      ),
                      CustomTile(
                        title: 'Recovered',
                        content: _appSettings
                            .customDataFormatter(_dataStore.recovered),
                        backgroundColor: Colors.lightBlueAccent[400],
                      ),
                      CustomTile(
                        title: 'Recov. Diff',
                        content: _appSettings
                            .customDataFormatter(_dataStore.recovDiff),
                        backgroundColor: Colors.teal,
                      ),
                      CustomTile(
                        title: 'Deaths',
                        content:
                            _appSettings.customDataFormatter(_dataStore.deaths),
                        backgroundColor: Colors.red,
                      ),
                      CustomTile(
                        title: 'Death Diff.',
                        content: _appSettings
                            .customDataFormatter(_dataStore.deathDiff),
                        backgroundColor: Colors.indigoAccent,
                      ),

                      // CustomTile(
                      //   title: 'Death Rate',
                      //   content: _dataStore.fatalityRate.toString(),
                      //   backgroundColor: Colors.redAccent,
                      // ),
                    ],
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
