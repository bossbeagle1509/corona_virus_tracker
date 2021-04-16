import 'package:corona_virus_tracker/screens/advanced_card_viewer.dart';
import 'package:corona_virus_tracker/screens/fine_search.dart';
import 'package:corona_virus_tracker/screens/settings_page.dart';
import 'package:corona_virus_tracker/screens/tile_view.dart';
import 'package:corona_virus_tracker/utils/constants.dart';
import 'package:corona_virus_tracker/screens/waiting.dart';
import 'package:corona_virus_tracker/utils/conveniences..dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        InitPage.id: (context) => InitPage(),
        FineTunedSearch.id: (context) => FineTunedSearch(),
        HomePage.id: (context) => HomePage(),
        AdvancedCardViewer.id: (context) => AdvancedCardViewer(),
        TileView.id: (context) => TileView(),
        SettingsPage.id: (context) => SettingsPage(),
      },
      title: 'COVID 19 Tracker',
      theme: ThemeData(
        primaryColor: Colors.indigo[900],
        accentColor: Colors.white,
      ),
      home: InitPage(),
    );
  }
}

class InitPage extends StatefulWidget {
  static String id = 'init_page';
  @override
  _InitPageState createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  void initState() {
    yesterday =
        DateTime.now().subtract(Duration(days: 1)).toString().substring(0, 10);

    dayBefore =
        DateTime.now().subtract(Duration(days: 2)).toString().substring(0, 10);
    print('Just updated today: $yesterday');

    getColorMode(context);
    getLazyMode(context);
    getTileMode(context);

    WidgetsBinding.instance
        .addPostFrameCallback((_) => print('Post-frame callback is here !'));
    // .addPostFrameCallback((_) => print(
    // 'The height is ${MediaQuery.of(context).size.height}'));
    //

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen();
  }
}
