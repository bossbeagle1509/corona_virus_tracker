import 'package:corona_virus_tracker/providers/appSettings.dart';
import 'package:corona_virus_tracker/screens/advanced_card_viewer.dart';
import 'package:corona_virus_tracker/screens/advanced_tile_viewer.dart';
import 'package:corona_virus_tracker/screens/bottomBarPage.dart';
import 'package:corona_virus_tracker/screens/card_view.dart';
import 'package:corona_virus_tracker/screens/crossroads.dart';
import 'package:corona_virus_tracker/screens/tile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import 'constants.dart';
import 'conveniences..dart';

class Networker {
  String yesterdayUrl =
      'https://covid-api.com/api/reports/total?date=$yesterday';
  String dayBeforeUrl =
      'https://covid-api.com/api/reports/total?date=$dayBefore';

  Future<void> getData(bool mode) async {
    http.Response data =
        await http.get(mode == false ? yesterdayUrl : dayBeforeUrl);

    print('Requesting for: ${mode == false ? yesterdayUrl : dayBeforeUrl}');

    if (data.statusCode == 200) {
      precious = data.body;

      date = jsonDecode(precious)['data']['date'];
      deaths = jsonDecode(precious)['data']['deaths'];
      lastUpdate = jsonDecode(precious)['data']['last_update'];
      recovered = jsonDecode(precious)['data']['recovered'];
      active = jsonDecode(precious)['data']['active'];
      fatalityRate = jsonDecode(precious)['data']['fatality_rate'];
      confirmed = jsonDecode(precious)['data']['confirmed'];
      deathDiff = jsonDecode(precious)['data']['deaths_diff'];
      recovDiff = jsonDecode(precious)['data']['recovered_diff'];
      activeDiff = jsonDecode(precious)['data']['active_diff'];
    } else {
      print(data.statusCode);
    }
  }

  void handler({BuildContext context, bool mode}) async {
    print('Requesting for: ${mode == false ? yesterdayUrl : dayBeforeUrl}');

    await getData(mode);

    Navigator.pushNamed(context, CrossRoads.id);

    // _appSettings.displayMode
    //     ? Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) {
    //             return
    //                 TileView();
    //           },
    //         ),
    //       )
    //     : Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) {
    //             return
    //                 CardView();
    //           },
    //         ),
    //       );
  }

  Future<void> refresh({BuildContext context, bool mode}) async {
    await getData(mode);
  }

  Future<void> fineTunedUrlSearch(
      BuildContext context, String dateToGet, String state) async {
    final _appSettings = Provider.of<AppSettings>(context, listen: false);

    String finalUrl =
        'https://covid-api.com/api/reports?date=$dateToGet&q=India&iso=IND&region_province=$state';

    print('Requesting for url: $finalUrl');

    http.Response data = await http.get(finalUrl);

    if (data.statusCode == 200) {
      precious = data.body;

      date = jsonDecode(precious)['data'][0]['date'];
      deaths = jsonDecode(precious)['data'][0]['deaths'];
      lastUpdate = jsonDecode(precious)['data'][0]['last_update'];
      recovered = jsonDecode(precious)['data'][0]['recovered'];
      active = jsonDecode(precious)['data'][0]['active'];
      fatalityRate = jsonDecode(precious)['data'][0]['fatality_rate'];
      confirmed = jsonDecode(precious)['data'][0]['confirmed'];
      deathDiff = jsonDecode(precious)['data'][0]['deaths_diff'];
      recovDiff = jsonDecode(precious)['data'][0]['recovered_diff'];
      activeDiff = jsonDecode(precious)['data'][0]['active_diff'];

      print('$state on $dateToGet');

      _appSettings.displayMode
          ? Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => AdvancedTileViewer(
                  resultDate: dateToGet,
                  resultState: state,
                ),
              ),
            )
          : Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => AdvancedCardViewer(
                  resultDate: dateToGet,
                  resultState: state,
                ),
              ),
            );
    } else {
      print('There was an error, the code was ${data.statusCode}');
      infoDialog(
          context,
          'Something went wrong :( Try another date, maybe there\'s no data for that particular date.',
          'Whoops !');
    }
  }
}
