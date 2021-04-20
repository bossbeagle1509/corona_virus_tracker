import 'package:corona_virus_tracker/providers/appSettings.dart';
import 'package:corona_virus_tracker/utils/conveniences.dart';
import 'package:corona_virus_tracker/utils/getter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FineTunedSearch extends StatefulWidget {
  static String id = 'fine_tuned_page';
  @override
  _FineTunedSearchState createState() => _FineTunedSearchState();
}

class _FineTunedSearchState extends State<FineTunedSearch> {
  String dropdownValue = 'One';

  DateTime _selectedDate;
  String buttonText = 'Pick a date';
  String _state = 'Karnataka';

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(Duration(days: 1)),
      firstDate: DateTime(2020, 3),
      lastDate: DateTime.now().subtract(Duration(days: 1)),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(
          () {
            _selectedDate = pickedDate;
            String _tempDate = _selectedDate.toString();
            String _finalDateText = convertDateTimeDisplay(_tempDate);
            buttonText = _finalDateText;
          },
        );
        print('DateTime fixed.');
      },
    );
    print('Something\'s not right with the DateTime picker.');
  }

  Networker getter = Networker();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: Text('COVID 19 Tracker'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.indigo[900],
                  border: Border.all(
                    color: Colors.indigo[900],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Construct a search query !',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              minWidth: MediaQuery.of(context).size.width * 0.4,
              color: Colors.indigo[900],
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: () => _presentDatePicker(),
            ),
            SizedBox(
              height: 25,
            ),
            DropdownSearch<String>(
              mode: Mode.MENU,
              showSelectedItem: true,
              items: [
                'Andhra Pradesh',
                'Arunachal Pradesh',
                'Assam',
                'Bihar',
                'Chhattisgarh',
                'Goa',
                'Gujarat',
                'Haryana',
                'Himachal Pradesh',
                'Jharkhand',
                'Karnataka',
                'Kerala',
                'Madhya Pradesh',
                'Maharashtra',
                'Manipur',
                'Meghalaya',
                'Mizoram',
                'Nagaland',
                'Odisha',
                'Punjab',
                'Rajasthan',
                'Sikkim',
                'Tamil Nadu',
                'Telangana',
                'Tripura',
                'Uttarakhand',
                'Uttar Pradesh',
                'West Bengal'
              ],
              label: "State",
              hint: "Type to search",
              onChanged: (value) {
                setState(() {
                  _state = value;
                });
              },
              selectedItem: "Karnataka",
            ),
            SizedBox(
              height: 25,
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              minWidth: MediaQuery.of(context).size.width * 0.6,
              color: Colors.indigo[900],
              onPressed: () {
                if (buttonText == 'Pick a date') {
                  showSnack(context, 'Pick a date first');
                } else {
                  showSnack(context, 'Hold on...');
                  try {
                    getter.fineTunedUrlSearch(
                      context,
                      buttonText,
                      _state,
                    );
                  } on Exception catch (_) {
                    infoDialog(
                        context,
                        'Something went wrong :( Try another date, maybe there\'s no data for that particular date.',
                        'Whoops !');
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  'Get Data',
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
