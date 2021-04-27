import 'package:corona_virus_tracker/utils/getter.dart';
import 'package:flutter/material.dart';

class DateStuff with ChangeNotifier {
  String yesterday;
  String dayBefore;

  /// true is global and false is indian
  bool statsZone = false;
  bool sliderVal = false;

  String actualYesterday;

  bool fancySchistDoneToDates = false;

  void toggleSliderVal() {
    sliderVal = !sliderVal;
    notifyListeners();
  }

  void setYesterdayInProvider(int toSubtract) {
    yesterday = DateTime.now()
        .subtract(Duration(days: toSubtract))
        .toString()
        .substring(0, 10);
    notifyListeners();
  }

  void getActualYesterday() {
    actualYesterday =
        DateTime.now().subtract(Duration(days: 1)).toString().substring(0, 10);
    notifyListeners();
  }

  void toggleFancySchistDoneToDates() {
    fancySchistDoneToDates = !fancySchistDoneToDates;
    notifyListeners();
  }

  void setDayBeforeInProvider(int toSubtract) {
    dayBefore = DateTime.now()
        .subtract(Duration(days: toSubtract))
        .toString()
        .substring(0, 10);
    notifyListeners();
  }

  void setStatsZone(bool temp) {
    statsZone = temp;
    notifyListeners();
  }

  void toggleStatsZone(BuildContext context) {
    Networker networker = Networker();
    networker.handlerWithoutPush(context: context, mode: false);

    statsZone = !statsZone;
    notifyListeners();
  }

  Uri get yesterdayUrl {
    if (statsZone) {
      /// global
      return Uri.parse(
          'https://covid-api.com/api/reports/total?date=$yesterday');
    } else {
      /// indian
      return Uri.parse(
          'https://covid-api.com/api/reports/total?date=$yesterday&iso=IND');
    }
  }

  Uri get dayBeforeUrl {
    if (statsZone) {
      /// global
      return Uri.parse(
          'https://covid-api.com/api/reports/total?date=$dayBefore');
    } else {
      /// indian
      return Uri.parse(
          'https://covid-api.com/api/reports/total?date=$dayBefore&iso=IND');
    }
  }
}
