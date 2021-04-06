import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:corona_virus_tracker/utils/getter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_switch/sliding_switch.dart';
import '../utils/constants.dart';

// ignore: must_be_immutable
class AdvancedSearchViewer extends StatefulWidget {
  static String id = 'advanced_viewer';

  String resultState;
  String resultDate;

  AdvancedSearchViewer({
    this.resultState,
    this.resultDate,
  });

  @override
  _AdvancedSearchViewerState createState() => _AdvancedSearchViewerState();
}

class _AdvancedSearchViewerState extends State<AdvancedSearchViewer> {
  Networker instance = Networker();

  Color standardBlue = Colors.indigo[900];

  var _formatter = NumberFormat('#,##,000');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: Text(
          '${widget.resultState} on ${widget.resultDate}',
          style: TextStyle(
            color: Colors.indigo[900],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent[400],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Updated: ',
                                  style: kTitle,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
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
                              height: MediaQuery.of(context).size.height * 0.05,
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
                          data: _formatter.format(confirmed).toString(),
                        ),
                        Element(
                          title: 'Active',
                          data: _formatter.format(active).toString(),
                        ),
                        Element(
                          title: 'Deaths',
                          data: _formatter.format(deaths).toString(),
                        ),
                        Element(
                          title: 'Recovered',
                          data: _formatter.format(recovered).toString(),
                        ),
                        Element(
                          title: 'Fatality Rate',
                          data: fatalityRate.toString(),
                        ),
                        Element(
                          title: 'Active Diff',
                          data: _formatter.format(activeDiff).toString(),
                        ),
                        Element(
                          title: 'Death Diff',
                          data: _formatter.format(deathDiff).toString(),
                        ),
                        Element(
                          title: 'Recov. Diff ',
                          data: _formatter.format(recovDiff).toString(),
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
