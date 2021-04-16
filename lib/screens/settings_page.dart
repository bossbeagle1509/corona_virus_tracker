import 'package:corona_virus_tracker/utils/constants.dart';
import 'package:corona_virus_tracker/utils/conveniences..dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  static String id = 'settings_page';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme,
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
                      color: textColorMode,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
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
                  value: lazyMode,
                  onToggle: (value) async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('lazyMode', value);
                    print('Entry made');
                    setState(() {
                      lazyMode = value;
                    });

                    showSnack(
                      context,
                      lazyMode == true ? 'Lazy mode on' : 'Lazy mode off',
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween, // swapped in favor of Spacer()
              children: [
                GestureDetector(
                  onTap: () => infoDialog(
                      context, 'Switches between tile UI and card UI.', 'Info'),
                  child: Text(
                    'Card Mode',
                    style: TextStyle(
                      color: textColorMode,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
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
                  value: tileMode,
                  onToggle: (value) async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('tileMode', value);
                    print('Entry made');
                    setState(() {
                      tileMode = value;
                    });

                    showSnack(
                      context,
                      tileMode == true
                          ? 'Restart app to see tile UI'
                          : 'Restart app to see card UI',
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: FlutterSwitch(
                width: 100.0,
                height: 55.0,
                toggleSize: 45.0,
                value: darkMode,
                borderRadius: 30.0,
                padding: 2.0,
                // activeToggleColor: Color(0xFF0082C8),
                inactiveToggleColor: Colors.indigo[900],
                // inactiveToggleColor: Color(0xFF01579B),
                activeSwitchBorder: Border.all(
                  color: Colors.greenAccent[400],
                  // color: Color(0xFF00D2B8),
                  width: 6.0,
                ),
                inactiveSwitchBorder: Border.all(
                  color: Colors.indigo[900],
                  // color: Color(0xFF29B6F6),
                  width: 6.0,
                ),
                // activeColor: Color(0xFF55DDCA),
                activeColor: Colors.greenAccent,
                inactiveColor: Color(0xFF54C5F8),
                activeIcon: Icon(Icons.nightlight_round),
                inactiveIcon: Icon(
                  Icons.wb_sunny,
                  color: Color(0xFFFFDF5D),
                ),
                onToggle: (val) async {
                  final prefs = await SharedPreferences.getInstance();
                  setState(() {
                    theme == light ? theme = dark : theme = light;
                    theme == light
                        ? textColorMode = Colors.black
                        : textColorMode = Colors.white;
                    darkMode = val;
                  });
                  await prefs.setString('mode', theme.toString());
                  print('Entry made');
                  showSnack(
                    context,
                    darkMode == true ? 'Dark mode on' : 'Dark mode off',
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
                  color: theme == dark ? light : dark,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
