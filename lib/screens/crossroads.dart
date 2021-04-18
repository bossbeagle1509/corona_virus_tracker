import 'package:corona_virus_tracker/providers/appSettings.dart';
import 'package:corona_virus_tracker/screens/card_view.dart';
import 'package:corona_virus_tracker/screens/tile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CrossRoads extends StatefulWidget {
  static String id = 'cross_roads';

  @override
  _CrossRoadsState createState() => _CrossRoadsState();
}

class _CrossRoadsState extends State<CrossRoads> {
  @override
  Widget build(BuildContext context) {
    final _appSettings = Provider.of<AppSettings>(context);

    return _appSettings.displayMode ? TileView() : CardView();
  }
}
