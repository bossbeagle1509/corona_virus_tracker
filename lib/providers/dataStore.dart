import 'package:flutter/material.dart';

class DataStore with ChangeNotifier {
  String lastUpdate;
  int deaths;
  // String precious;
  int recovered;
  int active;
  double fatalityRate;
  int confirmed;
  int confirmedDiff;
  int deathDiff;
  int activeDiff;
  int recovDiff;
  String date;

  void updateData({
    String lastUpdatePassedIn,
    int deathsPassedIn,
    // String preciousPassedIn,
    int recoveredPassedIn,
    int activePassedIn,
    double fatalityRatePassedIn,
    int confirmedPassedIn,
    int deathDiffPassedIn,
    int activeDiffPassedIn,
    int recovDiffPassedIn,
    int confirmedDiffPassedIn,
    String datePassedIn,
  }) {
    lastUpdate = lastUpdatePassedIn;
    deaths = deathsPassedIn;
    // precious = preciousPassedIn;
    recovered = recoveredPassedIn;
    active = activePassedIn;
    fatalityRate = fatalityRatePassedIn;
    confirmed = confirmedPassedIn;
    deathDiff = deathDiffPassedIn;
    activeDiff = activeDiffPassedIn;
    recovDiff = recovDiffPassedIn;
    confirmedDiff = confirmedDiffPassedIn;
    date = datePassedIn;

    notifyListeners();
  }
}
