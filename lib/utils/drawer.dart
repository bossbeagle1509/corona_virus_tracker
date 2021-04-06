import 'package:corona_virus_tracker/screens/fine_tuned_search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  TextEditingController editNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.only(top: 50),
        children: <Widget>[
          DrawerHeader(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Covid 19 Tracker',
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft + Alignment(0, .5),
                  child: Text(
                    'Data from: covid-api.com/api',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
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
              color: Colors.white60,
              size: 35,
            ),
            title: Text(
              'Advanced Search',
              style: kDrawerStyle,
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                FineTunedSearch.id,
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info_outline,
              color: Colors.white60,
              size: 35,
            ),
            title: Text(
              'About',
              style: kDrawerStyle,
            ),
            onTap: () {
              infoDialog(
                context,
                'This app was developed by Pranav Manoj and utilises the covid-api REST API, to provide real-time covid data.',
                'Info',
              );
            },
          ),
        ],
      ),
    );
  }
}
