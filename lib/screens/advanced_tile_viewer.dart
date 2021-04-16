import 'package:corona_virus_tracker/screens/custom_tile.dart';
import 'package:corona_virus_tracker/utils/constants.dart';
import 'package:corona_virus_tracker/utils/conveniences..dart';
import 'package:corona_virus_tracker/utils/drawer.dart';
import 'package:corona_virus_tracker/utils/getter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sliding_switch/sliding_switch.dart';

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
    // var _formatter = NumberFormat('#,##,000');
    Networker instance = Networker();

    bool selState = false;

    return Scaffold(
      backgroundColor: theme,
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
                      content: customDataFormatter(confirmed),
                      // content: _formatter.format(confirmed).toString(),
                      backgroundColor: Colors.orangeAccent,
                    ),
                    CustomTile(
                      title: 'Active',
                      content: customDataFormatter(active),
                      backgroundColor: Colors.purpleAccent,
                    ),
                    CustomTile(
                      title: 'Deaths',
                      content: customDataFormatter(deaths),
                      backgroundColor: Colors.red,
                    ),
                    CustomTile(
                      title: 'Death Diff.',
                      content: customDataFormatter(deathDiff),
                      backgroundColor: Colors.indigoAccent,
                    ),
                    CustomTile(
                      title: 'Recovered',
                      content: customDataFormatter(recovered),
                      backgroundColor: Colors.lightBlueAccent[400],
                    ),
                    CustomTile(
                      title: 'Recov. Diff',
                      content: customDataFormatter(recovDiff),
                      backgroundColor: Colors.teal,
                    ),
                    CustomTile(
                      title: 'Death Rate',
                      content: fatalityRate.toString(),
                      backgroundColor: Colors.redAccent,
                    ),
                    CustomTile(
                      title: 'Active Diff.',
                      content: customDataFormatter(activeDiff),
                      backgroundColor: Colors.pinkAccent,
                    ),
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
