import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppSettings with ChangeNotifier {
  bool lazyMode = false;
  bool darkMode = false;
  bool displayMode = false;

  Color light = Colors.white;
  Color dark = Colors.grey[800];
  Color textColorMode;

  Color theme;

  setDarkMode(bool value) {
    darkMode = value;
    darkMode ? theme = dark : theme = light;
    darkMode ? textColorMode = light : textColorMode = dark;
    notifyListeners();
  }

  setDisplayMode(bool value) {
    displayMode = value;
    notifyListeners();
  }

  setLazyMode(bool value) {
    lazyMode = value;
    notifyListeners();
  }

  toggleDarkMode() {
    darkMode = !darkMode;
    darkMode ? theme = dark : theme = light;
    darkMode ? textColorMode = light : textColorMode = dark;
    notifyListeners();
  }

  toggleLazyMode() {
    lazyMode = !lazyMode;
    notifyListeners();
  }

  toggleDisplayMode() {
    displayMode = !displayMode;
    notifyListeners();
  }

  customDataFormatter(int value) {
    var _formatter = NumberFormat('#,##,000');

    if (lazyMode && value >= 10000000) {
      var tempInt = value / 10000000;
      String tempString = tempInt.toStringAsFixed(2);
      return '$tempString cr';
    } else if (lazyMode && value >= 1000000) {
      var tempInt = value / 100000;
      String tempString = tempInt.toStringAsFixed(2);
      return '$tempString lacs';
    } else if (lazyMode && value >= 1000) {
      var tempInt = value / 1000;
      String tempString = tempInt.toStringAsFixed(2);
      return '$tempString k';
    } else {
      return _formatter.format(value).toString();
    }
  }
}
