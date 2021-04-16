import 'package:corona_virus_tracker/screens/fine_search.dart';
import 'package:corona_virus_tracker/screens/settings_page.dart';
import 'package:corona_virus_tracker/screens/tile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';
import 'conveniences..dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  TextEditingController editNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          // padding: EdgeInsets.only(top: 50),
          children: <Widget>[
            DrawerHeader(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Covid 19 Tracker',
                      style: controlledDrawerStyle(fontSize: 25),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft + Alignment(0, .5),
                    child: Text(
                      'Data from: covid-api.com/api',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        // color: theme == dark ? Colors.grey[600] : Colors.white70,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.indigo[900],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.search,
                color: dark,
                size: 35,
              ),
              title: Text(
                'Advanced Search',
                style: controlledDrawerStyle(textColor: dark, fontSize: 19),
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  FineTunedSearch.id,
                );
              },
            ),
            // ListTile(
            //   leading: Icon(
            //     Icons.fiber_new,
            //     color: dark,
            //     size: 35,
            //   ),
            //   title: Text(
            //     'Experimental View',
            //     style: controlledDrawerStyle(textColor: dark, fontSize: 19),
            //   ),
            //   onTap: () {
            //     Navigator.pushNamed(context, TileView.id);
            //   },
            // ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: dark,
                // color: theme == dark ? Colors.white60 : Colors.grey[600],
                size: 35,
              ),
              title: Text(
                'Settings',
                style: controlledDrawerStyle(textColor: dark, fontSize: 19),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, SettingsPage.id);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.info_outline,
                color: dark,
                size: 35,
              ),
              title: Text(
                'About',
                style: controlledDrawerStyle(textColor: dark, fontSize: 19),
              ),
              onTap: () {
                infoDialog(
                  context,
                  'This app was developed by Pranav Manoj and utilises the covid-api REST API, to provide real-time covid data.',
                  'Info',
                );
              },
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.github,
                    size: 35,
                  ),
                  onPressed: () => launchURL(
                      'https://github.com/bossbeagle1509/corona_virus_tracker'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
