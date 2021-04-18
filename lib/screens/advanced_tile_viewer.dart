import 'package:corona_virus_tracker/providers/appSettings.dart';
import 'package:corona_virus_tracker/screens/custom_tile.dart';
import 'package:corona_virus_tracker/utils/constants.dart';
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
    // var _formatter = NumberFormat('#,##,000');
    Networker instance = Networker();

    bool selState = false;

    final _appSettings = Provider.of<AppSettings>(context);

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
