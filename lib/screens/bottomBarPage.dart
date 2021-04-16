import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:corona_virus_tracker/screens/fine_search.dart';
import 'package:corona_virus_tracker/screens/home.dart';
import 'package:corona_virus_tracker/utils/constants.dart';
import 'package:flutter/material.dart';
// import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomBarPage extends StatefulWidget {
  @override
  _BottomBarPageState createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  int _currentIndex = 0;
  final _tabs = [
    Center(
      child: HomePage(),
    ),
    Center(
      child: FineTunedSearch(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavyBar(
        mainAxisAlignment: MainAxisAlignment.center,
        backgroundColor: theme,
        // itemPadding: EdgeInsets.all(10),
        selectedIndex: _currentIndex,
        onItemSelected: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            activeColor: theme == dark ? Colors.white : Colors.indigo[900],
          ),

          /// Search
          BottomNavyBarItem(
            icon: Icon(Icons.search),
            title: Text("Search"),
            activeColor: theme == dark ? Colors.white : Colors.indigo[900],
          ),
        ],
      ),
    );
  }
}