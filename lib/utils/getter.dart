import 'package:corona_virus_tracker/screens/advanced_search_viewer.dart';
import 'package:corona_virus_tracker/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'constants.dart';

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

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HomePage(
              // carryForward: mode,
              // date: date,
              // active: active,
              // deaths: deaths,
              // fatalityRate: fatalityRate,
              // lastUpdate: lastUpdate,
              // recovered: recovered,
              // confirmed: confirmed,
              // activeDff: activeDiff,
              // recovDiff: recovDiff,
              // deathDiff: deathDiff,
              );
        },
      ),
    );
  }

  Future<void> refresh({BuildContext context, bool mode}) async {
    await getData(mode);
  }

  Future<void> fineTunedUrlSearch(
      BuildContext context, String dateToGet, String state) async {
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

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => AdvancedSearchViewer(
            resultDate: dateToGet,
            resultState: state,
          ),
        ),
      );

      // Navigator.pushNamed(
      //   context,
      //   AdvancedSearchViewer.id,
      //   arguments: {state, dateToGet},
      // );
    } else {
      print('There was an error, the code was ${data.statusCode}');
      infoDialog(
          context,
          'Something went wrong :( Try another date, maybe there\'s no data for that particular date.',
          'Whoops !');
    }
  }
}
