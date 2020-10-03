import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_nitk/providers/hostel.dart';
import 'package:pocket_nitk/providers/hostels.dart';
import 'package:pocket_nitk/providers/lecture_hall.dart';
import 'package:pocket_nitk/providers/lecture_halls.dart';
import 'package:pocket_nitk/screens/bottom_tabs.dart';
import 'package:pocket_nitk/screens/hostel_page.dart';
import 'package:pocket_nitk/screens/lhc_page.dart';
import 'package:pocket_nitk/widgets/building_item.dart';
import 'package:provider/provider.dart';

class BuildingsPage extends StatefulWidget {
  @override
  _BuildingsPageState createState() => _BuildingsPageState();
}

class _BuildingsPageState extends State<BuildingsPage> {
  var _error = false;
  var _message;
  var _load = true;
  var _isInit = false;
  @override
  void initState() {
    _isInit = true;
    super.initState();
  }

//LoadingData
  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Hostels>(context)
          .fetchAndSetHostels()
          .then((result) {})
          .catchError((error) {
        print(error);

        setState(() {
          _message = error;
          _error = true;
        });
      });
      Provider.of<LectureHalls>(context)
          .fetchAndSetLectureHalls()
          .then((result) {})
          .catchError((error) {
        print(error);

        setState(() {
          _message = error;
          _error = true;
        });
      });

      _isInit = false;

      super.didChangeDependencies();
    }
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    final hostel = Provider.of<Hostels>(context, listen: false);
    final hostelList = hostel.hostels;
    final lectureHall = Provider.of<LectureHalls>(context, listen: false);
    final lectureHallList = lectureHall.lectureHalls;
    return RefreshIndicator(
        onRefresh: () async {
          try {
            await Provider.of<Hostels>(context, listen: false)
                .fetchAndSetHostels();
          } catch (e) {
            setState(() {
              _error = true;
            });
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 6.0, left: 6, right: 6, bottom: 15),
                        child: Stack(children: [
                          ClipPath(
                            clipper: MyClipper(),
                            child: Container(
                              height: 130,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30)),
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Colors.lightBlue[900],
                                    Colors.lightBlue[300]
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 25.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Text("BUILDINGS",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                      //CONTENT
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              'Hostels',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.45,
                            child: GridView.builder(
                              //physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.all(10),
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 300,
                                childAspectRatio: 3 / 2,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0,
                              ),
                              itemBuilder: (ctxt, index) {
                                return BuildingItem(
                                    hostelList[index].title,
                                    hostelList[index].imgUrl,
                                    HostelPage(hostel: hostelList[index]));
                              },
                              itemCount: hostelList.length,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              'Lecture Halls',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 250,
                            child: GridView.builder(
                              //physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.all(10),
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 300,
                                childAspectRatio: 3 / 2,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0,
                              ),
                              itemBuilder: (ctxt, index) {
                                return BuildingItem(
                                    lectureHallList[index].title,
                                    lectureHallList[index].imgUrl,
                                    LHCPage());
                              },
                              itemCount: lectureHallList.length,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (_error)
                  Container(
                    color: Colors.black54,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.white70,
                              ),
                              Positioned(
                                left: 20,
                                top: 20,
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.green[300],
                                ),
                              ),
                              Positioned(
                                left: 52,
                                top: 52,
                                child: CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Text(
                              'OOPS!',
                              style: TextStyle(
                                  color: Colors.green[300],
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            '\t\t\t\t\tSlow or no internet connection\nPlease check your internet connection',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              //fontWeight: FontWeight.bold
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: GestureDetector(
                              onTap: () async {
                                try {
                                  final result = await InternetAddress.lookup(
                                      'google.com');
                                  if (result.isNotEmpty &&
                                      result[0].rawAddress.isNotEmpty) {
                                    setState(() {
                                      _error = false;
                                    });
                                  }
                                } on SocketException catch (_) {
                                  setState(() {
                                    _error = true;
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Text(
                                  'Retry',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    //fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ));
  }
}
