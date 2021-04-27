import 'package:corona_virus_tracker/providers/appSettings.dart';
import 'package:corona_virus_tracker/providers/dataStore.dart';
import 'package:corona_virus_tracker/providers/dateStuff.dart';
import 'package:corona_virus_tracker/screens/advanced_card_viewer.dart';
import 'package:corona_virus_tracker/screens/advanced_tile_viewer.dart';
import 'package:corona_virus_tracker/screens/fine_search.dart';
import 'package:corona_virus_tracker/screens/uiBuilder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import 'conveniences.dart';

class Networker {
  Future<void> getData(BuildContext context, bool mode) async {
    final _dateStore = Provider.of<DateStuff>(context, listen: false);
    final _dataStore = Provider.of<DataStore>(context, listen: false);
    try {
      http.Response data = await http.get(
          mode == false ? _dateStore.yesterdayUrl : _dateStore.dayBeforeUrl);

      // print(jsonDecode(data.body)['data'].toString() == '[]');

      if (jsonDecode(data.body)['data'].toString() == '[]') {
        print('Not been updated yet,switching dates.');

        /// data was null, possibly because the api was not updated
        /// so change yesterday to day before and then continue

        _dateStore.setYesterdayInProvider(2);
        _dateStore.setDayBeforeInProvider(3);

        print('Just updated yesterday: ${_dateStore.yesterday}');
      } else {
        /// data was not null, proceed as normal
        print('Dates seem ok.');
        print(
            'Requesting for: ${mode == false ? _dateStore.yesterdayUrl : _dateStore.dayBeforeUrl}');

        if (data.statusCode == 200) {
          String precious = data.body;
          _dataStore.updateData(
            datePassedIn: jsonDecode(precious)['data']['date'],
            deathsPassedIn: jsonDecode(precious)['data']['deaths'],
            lastUpdatePassedIn: jsonDecode(precious)['data']['last_update'],
            recoveredPassedIn: jsonDecode(precious)['data']['recovered'],
            activePassedIn: jsonDecode(precious)['data']['active'],
            fatalityRatePassedIn: jsonDecode(precious)['data']['fatality_rate'],
            confirmedPassedIn: jsonDecode(precious)['data']['confirmed'],
            deathDiffPassedIn: jsonDecode(precious)['data']['deaths_diff'],
            recovDiffPassedIn: jsonDecode(precious)['data']['recovered_diff'],
            confirmedDiffPassedIn: jsonDecode(precious)['data']
                ['confirmed_diff'],
            activeDiffPassedIn: jsonDecode(precious)['data']['active_diff'],
          );
        } else {
          print(data.statusCode);
        }
      }
    } on Exception catch (_) {
      print('Caught an error with the restful api');
    }
  }

  Future<void> testModule(BuildContext context, bool mode) async {
    final _dateStore = Provider.of<DateStuff>(context, listen: false);
    try {
      http.Response data = await http.get(
          mode == false ? _dateStore.yesterdayUrl : _dateStore.dayBeforeUrl);

      if (jsonDecode(data.body)['data'].toString() == '[]') {
        /// data was null, possibly because the api was not updated
        /// so change yesterday to day before and then continue

        print('Not been updated yet,switching dates.');
        _dateStore.toggleFancySchistDoneToDates();
        _dateStore.setYesterdayInProvider(2);
        _dateStore.setDayBeforeInProvider(3);
        print('Just updated yesterday to ${_dateStore.yesterday}');
      } else {
        /// dates are ok just continue
      }

      await getData(context, mode);
    } on Exception catch (e) {
      print('Caught an error with the restful api');
      print(e.toString());
    }
  }

  void handler({BuildContext context, bool mode}) async {
    await testModule(context, mode);

    Navigator.pushNamed(context, UIBuilder.id);
  }

  void handlerWithoutPush({BuildContext context, bool mode}) async {
    await testModule(context, mode);
  }

  // Future<void> refresh({BuildContext context, bool mode}) async {
  //   await getData(context, mode);
  // }

  Future<void> fineTunedUrlSearch(
      BuildContext context, String dateToGet, String state) async {
    final _appSettings = Provider.of<AppSettings>(context, listen: false);
    final _dataStore = Provider.of<DataStore>(context, listen: false);

    String finalUrl =
        'https://covid-api.com/api/reports?date=$dateToGet&q=India&iso=IND&region_province=$state';

    print('Requesting for url: $finalUrl');

    http.Response data = await http.get(finalUrl);

    if (data.statusCode == 200) {
      String precious = data.body;

      _dataStore.updateData(
        datePassedIn: jsonDecode(precious)['data'][0]['date'],
        deathsPassedIn: jsonDecode(precious)['data'][0]['deaths'],
        lastUpdatePassedIn: jsonDecode(precious)['data'][0]['last_update'],
        recoveredPassedIn: jsonDecode(precious)['data'][0]['recovered'],
        activePassedIn: jsonDecode(precious)['data'][0]['active'],
        confirmedDiffPassedIn: jsonDecode(precious)['data'][0]
            ['confirmed_diff'],
        fatalityRatePassedIn: jsonDecode(precious)['data'][0]['fatality_rate'],
        confirmedPassedIn: jsonDecode(precious)['data'][0]['confirmed'],
        deathDiffPassedIn: jsonDecode(precious)['data'][0]['deaths_diff'],
        recovDiffPassedIn: jsonDecode(precious)['data'][0]['recovered_diff'],
        activeDiffPassedIn: jsonDecode(precious)['data'][0]['active_diff'],
      );

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
