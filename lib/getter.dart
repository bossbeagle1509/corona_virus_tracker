import 'package:corona_virus_tracker/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'constants.dart';

class Networker {
  String yesterdayUrl =
      'https://covid-api.com/api/reports/total?date=$yesterday';
  String dayBeforeUrl =
      'https://covid-api.com/api/reports/total?date=$dayBefore';
  // String epicURL =
  //     'https://covid-api.com/api/reports?date=$today&iso=IND&region_province=$state';

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
}
