import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pocket_nitk/constants/colors.dart';
import 'package:pocket_nitk/providers/hostel.dart';

class HostelPage extends StatefulWidget {
  final Hostel hostel;

  const HostelPage({Key key,@required this.hostel}) : super(key: key);

  @override
  _HostelPageState createState() => _HostelPageState();
}

class _HostelPageState extends State<HostelPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    int variable = 0;
    List<String> splittingTitle(List<String> list) {
      return list.where((element) {
        if (variable % 2 == 0) {
          variable++;
          return true;
        } else {
          variable++;
          return false;
        }
      }).toList();
    }

    List<String> splittingImages(List<String> list) {
      return list.where((element) {
        if (variable % 2 == 0) {
          variable++;
          return false;
        } else {
          variable++;
          return true;
        }
      }).toList();
    }

    //FRAMING TIMETABLE
    final List<String> mondayMenuTitles =
        splittingTitle(widget.hostel.monday.split(","));
    final List<String> mondayMenuImages =
        splittingImages(widget.hostel.monday.split(","));
    final List<String> tuesdayMenuTitles =
        splittingTitle(widget.hostel.tuesday.split(","));
    final List<String> tuesdayMenuImages =
        splittingImages(widget.hostel.tuesday.split(","));
    final List<String> wednesdayMenuTitles =
        splittingTitle(widget.hostel.wednesday.split(","));
    final List<String> wednesdayMenuImages =
        splittingImages(widget.hostel.wednesday.split(","));
    final List<String> thursdayMenuTitles =
        splittingTitle(widget.hostel.thursday.split(","));
    final List<String> thursdayMenuImages =
        splittingImages(widget.hostel.thursday.split(","));
    final List<String> fridayMenuTitles =
        splittingTitle(widget.hostel.friday.split(","));
    final List<String> fridayMenuImages =
        splittingImages(widget.hostel.friday.split(","));
    final List<String> saturdayMenuTitles =
        splittingTitle(widget.hostel.saturday.split(","));
    final List<String> saturdayMenuImages =
        splittingImages(widget.hostel.saturday.split(","));
    final List<String> sundayMenuTitles =
        splittingTitle(widget.hostel.sunday.split(","));
    final List<String> sundayMenuImages =
        splittingImages(widget.hostel.sunday.split(","));
    final List<List<String>> check = [
      widget.hostel.monday.split(","),
      widget.hostel.tuesday.split(","),
      widget.hostel.wednesday.split(","),
      widget.hostel.thursday.split(","),
      widget.hostel.friday.split(","),
      widget.hostel.saturday.split(","),
      widget.hostel.sunday.split(","),
    ];

    //FINDING TODAYS FOOD
    List<String> todayMenu = check[(today.weekday) - 1];
    List<String> todayMenutitles = splittingTitle(todayMenu);
    List<String> todayMenuImages = splittingImages(todayMenu);

    final TabController _tabController =
        TabController(length: check.length, vsync: this);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  child: Image.network(
                    widget.hostel.imgUrl,
                    height: MediaQuery.of(context).size.height *0.37,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height:  MediaQuery.of(context).size.height *0.37,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: kBlack26,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: kWhite,
                      ),
                      onPressed: () => Navigator.of(context).pop()),
                  Text(
                    'Hostel Details',
                    style: TextStyle(
                        color: kWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100.0, left: 0),
              child: Align(
                alignment: Alignment.center,
                              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Block Name',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: kWhite),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.hostel.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: kWhite),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top:  MediaQuery.of(context).size.height *0.27, left: 10, right: 10),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: kWhite,
                ),
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 20.0, bottom: 10),
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            rowIcon(
                              widget.hostel.strength.toString(),
                              'Hostel Strength',
                              Icons.person,
                            ),
                            rowIcon(
                              widget.hostel.rooms.toString(),
                              'Total Rooms',
                              Icons.account_balance,
                            ),
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 20.0, bottom: 10),
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            rowIcon(
                              widget.hostel.hostelName,
                              'Hostel Name',
                              Icons.title,
                            ),
                            rowIcon(
                              widget.hostel.wardenName,
                              'Warden Name',
                              Icons.account_circle,
                            ),
                          ],
                        )),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: Text(
                          'Mess',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 28),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
                      child: Text(
                        'Flavour of the Day',
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 23),
                      ),
                    ),
                    slidingCards(todayMenuImages, todayMenutitles),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0,left: 15),
                      child: Text(
                        'This Week',
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 23),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: SafeArea(
                        child: TabBar(
                          controller: _tabController,
                          unselectedLabelColor: kGrey,
                          labelColor: kBlue800,
                          labelPadding: EdgeInsets.only(bottom: 4),
                          indicatorColor: kBlue800,
                          indicatorPadding:
                              EdgeInsets.symmetric(horizontal: 10),
                          tabs: [
                            Text('Mon'),
                            Text('Tue'),
                            Text('Wed'),
                            Text('Thu'),
                            Text('Fri'),
                            Text('Sat'),
                            Text('Sun')
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height*0.6,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          weekList(mondayMenuImages, mondayMenuTitles),
                          weekList(tuesdayMenuImages, tuesdayMenuTitles),
                          weekList(wednesdayMenuImages, wednesdayMenuTitles),
                          weekList(thursdayMenuImages, thursdayMenuTitles),
                          weekList(fridayMenuImages, fridayMenuTitles),
                          weekList(saturdayMenuImages, saturdayMenuTitles),
                          weekList(sundayMenuImages, sundayMenuTitles),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget weekList(List<String> image, List<String> title) {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return Column(
        children: [
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              child: Image.network(
                image[index],
                height: 200,
                width: 70,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              title[index],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: index == 0
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Card(
                            //elevation: 2,
                            color: kGreen50,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'BREAKFAST',
                                style: TextStyle(
                                    color: kGreen700,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ],
                    ),
                  )
                : index == 1
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Card(
                                //elevation: 2,
                                color: kAmber50,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    'LUNCH',
                                    style: TextStyle(
                                        color: kAmber700,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ],
                        ),
                      )
                    : index == 2
                        ? Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Card(
                                    //elevation: 2,
                                    color: kBlue50,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(
                                        'EVENING',
                                        style: TextStyle(
                                            color: kBlue700,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              ],
                            ),
                        )
                        : Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Card(
                                  //elevation: 2,
                                  color: kRed50,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text(
                                      'DINNER',
                                      style: TextStyle(
                                          color: kRed700,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ),
          ),
          Divider()
        ],
      );
    },
    itemCount: 4,
  );
}

Widget slidingCards(
    List<String> todayMenuImages, List<String> todayMenutitles) {
  return CarouselSlider.builder(
    itemCount: todayMenuImages.length,
    options: CarouselOptions(
      height: 150,
      initialPage: DateTime.now().hour < 9
          ? 0
          : DateTime.now().hour < 14 ? 1 : DateTime.now().hour < 19 ? 2 : 3,
      //enableInfiniteScroll: false,
      viewportFraction: 0.5,
      autoPlayInterval: Duration(seconds: 6),
      //aspectRatio: 1.5,
      enlargeCenterPage: true,
      autoPlay: false,
    ),
    itemBuilder: (ctx, index) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //       builder: (_) => EventDetail(
            //           event: latestEventsList[index])))
          },
          child: Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Stack(
                    children: [
                      Image.network(
                        todayMenuImages[index],
                        width: double.infinity,
                        fit: BoxFit.fill,
                        height: double.infinity,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                            color: kBlack26),
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Card(
                                color: kLightBlue700,
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    index == 0
                                        ? 'Morning'
                                        : index == 1
                                            ? 'Aftenoon'
                                            : index == 2 ? 'Evening' : 'Night',
                                    style: TextStyle(
                                        color: kWhite,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )))
                    ],
                  )),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    todayMenutitles[index],
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: kWhite),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

Widget rowIcon(String title, String subtitle, IconData icon) {
  return Wrap(
    //crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CircleAvatar(
        radius: 27,
        backgroundColor: kBlue50,
        child: Icon(
          icon,
          color: kBlue800,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                subtitle,
                style: TextStyle(fontSize: 15, color: kGrey),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

