import 'package:flutter/material.dart';

class DateStuff with ChangeNotifier {
  String yesterday;
  String dayBefore;

  String actualYesterday;

  bool fancySchistDoneToDates = false;

  setYesterdayInProvider(int toSubtract) {
    yesterday = DateTime.now()
        .subtract(Duration(days: toSubtract))
        .toString()
        .substring(0, 10);
    notifyListeners();
  }

  getActualYesterday() {
    actualYesterday =
        DateTime.now().subtract(Duration(days: 1)).toString().substring(0, 10);
    notifyListeners();
  }

  toggleFancySchistDoneToDates() {
    fancySchistDoneToDates = !fancySchistDoneToDates;
    notifyListeners();
  }

  setDayBeforeInProvider(int toSubtract) {
    dayBefore = DateTime.now()
        .subtract(Duration(days: toSubtract))
        .toString()
        .substring(0, 10);
    notifyListeners();
  }

  Uri get yesterdayUrl {
    return Uri.parse('https://covid-api.com/api/reports/total?date=$yesterday');
  }

  Uri get dayBeforeUrl {
    return Uri.parse('https://covid-api.com/api/reports/total?date=$dayBefore');
  }
}
