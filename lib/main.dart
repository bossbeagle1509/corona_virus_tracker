import 'package:corona_virus_tracker/screens/advanced_search_viewer.dart';
import 'package:corona_virus_tracker/screens/fine_tuned_search_page.dart';
import 'package:corona_virus_tracker/utils/constants.dart';
import 'package:corona_virus_tracker/screens/waiting.dart';
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
        AdvancedSearchViewer.id: (context) => AdvancedSearchViewer(),
      },
      title: 'COVID 19 Tracker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
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
    // setState(() {
    yesterday =
        DateTime.now().subtract(Duration(days: 1)).toString().substring(0, 10);

    dayBefore =
        DateTime.now().subtract(Duration(days: 2)).toString().substring(0, 10);
    // });
    print('Just updated today: $yesterday');
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        print('The height in inches is ${MediaQuery.of(context).size.height}'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen();
  }
}
