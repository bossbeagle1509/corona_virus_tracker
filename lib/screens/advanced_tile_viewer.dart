import 'package:corona_virus_tracker/providers/appSettings.dart';
import 'package:corona_virus_tracker/providers/dataStore.dart';
import 'package:corona_virus_tracker/screens/custom_tile.dart';
import 'package:corona_virus_tracker/utils/getter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AdvancedTileViewer extends StatefulWidget {
  static String id = 'advancedTileView';

  String resultState;
  String resultDate;

  AdvancedTileViewer({
    this.resultState,
    this.resultDate,
  });

  @override
  _AdvancedTileViewerState createState() => _AdvancedTileViewerState();
}

class _AdvancedTileViewerState extends State<AdvancedTileViewer> {
  @override
  Widget build(BuildContext context) {
    final _appSettings = Provider.of<AppSettings>(context);
    final _dataStore = Provider.of<DataStore>(context, listen: false);

    return Scaffold(
      backgroundColor: _appSettings.theme,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.greenAccent[400],
        title: Text(
          '${widget.resultState} on ${widget.resultDate}',
          style: TextStyle(color: Colors.indigo[900]),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                      backgroundColor: Colors.orangeAccent,
                    ),
                    CustomTile(
                      title: 'Confirm. Diff',
                      content: _appSettings
                          .customDataFormatter(_dataStore.confirmedDiff),
                      backgroundColor: Colors.orangeAccent,
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
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
