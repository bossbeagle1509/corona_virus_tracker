import 'package:corona_virus_tracker/providers/appSettings.dart';
import 'package:corona_virus_tracker/screens/card_view.dart';
import 'package:corona_virus_tracker/screens/tile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UIBuilder extends StatefulWidget {
  static String id = 'cross_roads';

  @override
  _UIBuilderState createState() => _UIBuilderState();
}

class _UIBuilderState extends State<UIBuilder> {
  @override
  Widget build(BuildContext context) {
    final _appSettings = Provider.of<AppSettings>(context);

    return _appSettings.displayMode ? TileView() : CardView();
  }
}
