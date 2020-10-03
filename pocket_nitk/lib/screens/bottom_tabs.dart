import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pocket_nitk/screens/buildings_page.dart';
import 'package:pocket_nitk/screens/home_page.dart';
import 'package:pocket_nitk/screens/map_page.dart';
import 'package:pocket_nitk/screens/more_page.dart';

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
      MyHomePage(),
      BuildingsPage(),
      MapSample(),
      MorePage(),
    ];
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            color: Colors.white,
            backgroundColor: Colors.lightBlue[700],
            key: _bottomNavigationKey,
            items: <Widget>[
              Icon(Icons.home),
              Icon(Icons.location_city),
              Icon(Icons.location_on),
              Icon(Icons.details),
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

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
