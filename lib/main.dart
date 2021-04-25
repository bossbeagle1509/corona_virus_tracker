import 'package:corona_virus_tracker/providers/appSettings.dart';
import 'package:corona_virus_tracker/providers/dateStuff.dart';
import 'package:corona_virus_tracker/screens/advanced_card_viewer.dart';
import 'package:corona_virus_tracker/screens/uiBuilder.dart';
import 'package:corona_virus_tracker/screens/fine_search.dart';
import 'package:corona_virus_tracker/screens/settings_page.dart';
import 'package:corona_virus_tracker/screens/tile_view.dart';
import 'package:corona_virus_tracker/screens/waiting.dart';
import 'package:corona_virus_tracker/utils/conveniences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/card_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AppSettings(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => DateStuff(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          InitPage.id: (context) => InitPage(),
          FineTunedSearch.id: (context) => FineTunedSearch(),
          CardView.id: (context) => CardView(),
          AdvancedCardViewer.id: (context) => AdvancedCardViewer(),
          TileView.id: (context) => TileView(),
          SettingsPage.id: (context) => SettingsPage(),
          UIBuilder.id: (context) => UIBuilder(),
        },
        title: 'COVID 19 Tracker',
        theme: ThemeData(
          primaryColor: Colors.indigo[900],
          accentColor: Colors.greenAccent[400],
        ),
        home: InitPage(),
      ),
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
    getColorMode(context);
    getLazyMode(context);
    getTileMode(context);
    getDates(context);

    WidgetsBinding.instance
        .addPostFrameCallback((_) => print('Post-frame callback is here !'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen();
  }
}
