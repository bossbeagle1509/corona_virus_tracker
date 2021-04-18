import 'package:corona_virus_tracker/providers/appSettings.dart';
import 'package:corona_virus_tracker/screens/custom_tile.dart';
import 'package:corona_virus_tracker/utils/constants.dart';
import 'package:corona_virus_tracker/utils/conveniences..dart';
import 'package:corona_virus_tracker/utils/drawer.dart';
import 'package:corona_virus_tracker/utils/getter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    // var _formatter = NumberFormat('#,##,000');
    Networker instance = Networker();

    bool selState = false;

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
                'The values, \'Active Diff.\', \'Recov. Diff.\' and \'Death Diff.\' are the number of new active, recovered and death cases respectively, compared to the values on $dayBefore. ',
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
                        content: lastUpdate,
                        textSize: 18,
                        backgroundColor: Colors.blueGrey,
                      ),
                      CustomTile(
                        title: 'Date',
                        content: date,
                        backgroundColor: Colors.greenAccent[400],
                      ),
                      CustomTile(
                        title: 'Confirmed',
                        content: _appSettings.customDataFormatter(confirmed),
                        // content: _formatter.format(confirmed).toString(),
                        backgroundColor: Colors.orangeAccent,
                      ),
                      CustomTile(
                        title: 'Active',
                        content: _appSettings.customDataFormatter(active),
                        backgroundColor: Colors.purpleAccent,
                      ),
                      CustomTile(
                        title: 'Deaths',
                        content: _appSettings.customDataFormatter(deaths),
                        backgroundColor: Colors.red,
                      ),
                      CustomTile(
                        title: 'Death Diff.',
                        content: _appSettings.customDataFormatter(deathDiff),
                        backgroundColor: Colors.indigoAccent,
                      ),
                      CustomTile(
                        title: 'Recovered',
                        content: _appSettings.customDataFormatter(recovered),
                        backgroundColor: Colors.lightBlueAccent[400],
                      ),
                      CustomTile(
                        title: 'Recov. Diff',
                        content: _appSettings.customDataFormatter(recovDiff),
                        backgroundColor: Colors.teal,
                      ),
                      CustomTile(
                        title: 'Death Rate',
                        content: fatalityRate.toString(),
                        backgroundColor: Colors.redAccent,
                      ),
                      CustomTile(
                        title: 'Active Diff.',
                        content: _appSettings.customDataFormatter(activeDiff),
                        backgroundColor: Colors.pinkAccent,
                      ),
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
