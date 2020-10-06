import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:red_button/first_page.dart';
import 'package:red_button/homepage.dart';
import 'package:red_button/map_page.dart';
import 'package:red_button/settings.dart';

class BottomTabs extends StatefulWidget {
  BottomTabs({Key key}) : super(key: key);

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _page;
  @override
  void initState() {
    _page = 0;

    super.initState();
  }

  GlobalKey _bottomNavigationKey = GlobalKey();

  Widget build(BuildContext context) {
    //LIST OF TABS
    List<Widget> _children = [
      HomePage(),
      MapSample(),
      SettingsPage(),
    ];
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            color: Colors.white,
            backgroundColor: Colors.red[800],
            key: _bottomNavigationKey,
            items: <Widget>[
              Icon(Icons.home),
              Icon(Icons.location_on),
              Icon(Icons.settings),
            ],
            onTap: (index) {
              setState(() {
                _page = index;
              });
            },
          ),
          body: _children[_page]),
    );
  }
}
