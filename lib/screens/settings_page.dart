import 'package:corona_virus_tracker/providers/appSettings.dart';
import 'package:corona_virus_tracker/providers/dateStuff.dart';
import 'package:corona_virus_tracker/utils/conveniences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  static String id = 'settings_page';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    double _textSize = 30;
    final _appSettings = Provider.of<AppSettings>(context);
    final _dateStuff = Provider.of<DateStuff>(context);

    return Scaffold(
      backgroundColor: _appSettings.theme,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent[400],
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => infoDialog(
                      context,
                      'Converts stats to crores, lakhs and thousands, instead of comma separated values.',
                      'Info'),
                  child: Text(
                    'Lazy Mode',
                    style: TextStyle(
                      color: _appSettings.textColorMode,
                      fontWeight: FontWeight.bold,
                      fontSize: _textSize,
                    ),
                  ),
                ),
                Spacer(),
                FlutterSwitch(
                  width: 100.0,
                  height: 55.0,
                  toggleSize: 45.0,
                  borderRadius: 30.0,
                  padding: 2.0,
                  inactiveToggleColor: Colors.indigo[900],
                  activeSwitchBorder: Border.all(
                    color: Colors.greenAccent[400],
                    width: 6.0,
                  ),
                  inactiveSwitchBorder: Border.all(
                    color: Colors.indigo[900],
                    width: 6.0,
                  ),
                  activeColor: Colors.greenAccent,
                  inactiveColor: Color(0xFF54C5F8),
                  value: _appSettings.lazyMode,
                  onToggle: (value) async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('lazyMode', value);
                    print('Entry made');

                    _appSettings.toggleLazyMode();

                    showSnack(
                      context,
                      _appSettings.lazyMode == true
                          ? 'Lazy mode on'
                          : 'Lazy mode off',
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () => infoDialog(
                      context, 'Switches between tile UI and card UI.', 'Info'),
                  child: Text(
                    'Display Mode',
                    style: TextStyle(
                      color: _appSettings.textColorMode,
                      fontWeight: FontWeight.bold,
                      fontSize: _textSize,
                    ),
                  ),
                ),
                Spacer(),
                FlutterSwitch(
                  width: 100.0,
                  height: 55.0,
                  toggleSize: 45.0,
                  borderRadius: 30.0,
                  padding: 2.0,
                  inactiveToggleColor: Colors.indigo[900],
                  activeSwitchBorder: Border.all(
                    color: Colors.greenAccent[400],
                    width: 6.0,
                  ),
                  inactiveSwitchBorder: Border.all(
                    color: Colors.indigo[900],
                    width: 6.0,
                  ),
                  activeColor: Colors.greenAccent,
                  inactiveColor: Color(0xFF54C5F8),
                  value: _appSettings.displayMode,
                  onToggle: (value) async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('tileMode', value);
                    print('Entry made');

                    _appSettings.toggleDisplayMode();
                    showSnack(
                        context,
                        _appSettings.displayMode
                            ? 'Switched to tile UI'
                            : 'Switched to card UI');
                  },
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () => infoDialog(
                      context,
                      'Toggles between showing global stats and indian stats on the homepage.',
                      'Info'),
                  child: Text(
                    'Stats Zone',
                    style: TextStyle(
                      color: _appSettings.textColorMode,
                      fontWeight: FontWeight.bold,
                      fontSize: _textSize,
                    ),
                  ),
                ),
                Spacer(),
                FlutterSwitch(
                  width: 100.0,
                  height: 55.0,
                  toggleSize: 45.0,
                  borderRadius: 30.0,
                  padding: 2.0,
                  inactiveToggleColor: Colors.indigo[900],
                  activeSwitchBorder: Border.all(
                    color: Colors.greenAccent[400],
                    width: 6.0,
                  ),
                  inactiveSwitchBorder: Border.all(
                    color: Colors.indigo[900],
                    width: 6.0,
                  ),
                  activeColor: Colors.greenAccent,
                  inactiveColor: Color(0xFF54C5F8),
                  value: _dateStuff.statsZone,
                  onToggle: (value) async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('statsZone', value);
                    print('Entry made');

                    _dateStuff.toggleStatsZone(context);
                    showSnack(
                        context,
                        _dateStuff.statsZone
                            ? 'Switched to global stats'
                            : 'Switched to indian stats');
                  },
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            // slider for dark mode
            Center(
              child: FlutterSwitch(
                width: 100.0,
                height: 55.0,
                toggleSize: 45.0,
                value: _appSettings.darkMode,
                borderRadius: 30.0,
                padding: 2.0,
                inactiveToggleColor: Colors.indigo[900],
                activeSwitchBorder: Border.all(
                  color: Colors.greenAccent[400],
                  width: 6.0,
                ),
                inactiveSwitchBorder: Border.all(
                  color: Colors.indigo[900],
                  width: 6.0,
                ),
                activeColor: Colors.greenAccent,
                inactiveColor: Color(0xFF54C5F8),
                activeIcon: Icon(Icons.nightlight_round),
                inactiveIcon: Icon(
                  Icons.wb_sunny,
                  color: Color(0xFFFFDF5D),
                ),
                onToggle: (val) async {
                  final prefs = await SharedPreferences.getInstance();
                  _appSettings.toggleDarkMode();
                  print('saving theme as ${_appSettings.theme.toString()}');
                  await prefs.setString('mode', _appSettings.theme.toString());
                  print('Entry made');
                  showSnack(
                    context,
                    _appSettings.darkMode == true
                        ? 'Dark mode on'
                        : 'Dark mode off',
                  );
                },
              ),
            ),
            Spacer(),
            Center(
              child: Text(
                'Tap on a switch title for more info',
                style: TextStyle(
                  fontSize: 15,
                  color: _appSettings.textColorMode,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
