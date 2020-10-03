import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_nitk/constants/colors.dart';
import 'package:pocket_nitk/providers/event.dart';
import 'package:pocket_nitk/providers/events.dart';
import 'package:pocket_nitk/providers/home_photos.dart';
import 'package:pocket_nitk/providers/news.dart';
import 'package:pocket_nitk/providers/news_list.dart';
import 'package:pocket_nitk/providers/ranks.dart';
import 'package:pocket_nitk/screens/events.page.dart';
import 'package:pocket_nitk/screens/events_details_page.dart';
import 'package:pocket_nitk/screens/news_detail_page.dart';
import 'package:pocket_nitk/screens/news_page.dart';
import 'package:pocket_nitk/screens/rankings_page.dart';
import 'package:pocket_nitk/widgets/blue_backgroung_image.dart';
import 'package:provider/provider.dart';

final seeAll = Padding(
  padding: const EdgeInsets.only(right: 10.0),
  child: Row(
    children: [
      Text(
        "See All",
        style: TextStyle(fontSize: 16, color: kGrey),
      ),
      Icon(Icons.keyboard_arrow_right)
    ],
  ),
);
//Upcoming card
final upcome = Align(
    alignment: Alignment.topLeft,
    child: Padding(
        padding: EdgeInsets.only(left: 5),
        child: Card(
          color: kLightBlue700,
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Upcoming',
              style:
                  TextStyle(color: kWhite, fontWeight: FontWeight.bold),
            ),
          ),
        )));

Widget rankingsRow(int rank1, String board1, int year1) {
  print(rank1);
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Text(
          rank1.toString(),
          style: TextStyle(
            color: kGreen400,
            fontWeight: FontWeight.bold,
            fontSize: 36,
          ),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            board1,
            style: TextStyle(
              //color: Colors.green[400],
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            year1.toString(),
            style: TextStyle(
              color:kGreen400,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget subHeading(String title, Widget newsListings, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, bottom: 10),
    child: GestureDetector(
      onTap: () {
        return Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => newsListings));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          seeAll
        ],
      ),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ValueNotifier<bool> _isLoading = ValueNotifier(false);
  //var _isLoading = false;
  var _error = false;
  var _message;
  var _load = true;
  var _isInit = false;
  String emptyImage =
      'https://www.capwholesalers.com/shop/images/p.68628.1-thumbs-up.png';

  //to avoid memory leak
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    _isInit = true;
    super.initState();
  }

  //LoadingData
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isLoading.value = true;

      Provider.of<HomePhotos>(context).fetchAndSetHomePhotos().then((result) {
        print('1st done');
      }).catchError((error) {
        print(error);
        _isLoading.value = false;
        setState(() {
          _message = error;
          _error = true;
        });
      });
      Provider.of<Events>(context).fetchAndSetEvents().then((result) {
        print('2nd done');
      }).catchError((error) {
        print(error);
        _isLoading.value = false;
        setState(() {
          _message = error;
          _error = true;
          _load = false;
        });
      });
      Provider.of<Ranks>(context).fetchAndSetRanks().then((result) {
        print('3rd done');
      }).catchError((error) {
        print(error);
        _isLoading.value = false;
        setState(() {
          _message = error;
          _error = true;
          _load = false;
        });
      });
      Provider.of<NewsList>(context).fetchAndSetNews().then((result) {
        print('3rd done');

        _isLoading.value = false;
      }).catchError((error) {
        print(error);
        _isLoading.value = false;
        setState(() {
          _message = error;
          _error = true;
          _load = false;
        });
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  final Event dummyEvent = Event(
      title: '',
      imgUrl:
          'https://www.capwholesalers.com/shop/images/p.68628.1-thumbs-up.png',
      isLatest: false,
      isUpcoming: false,
      date: '',
      description: '');
  // final Rank dummyRank =
  //     Rank(ranking: -1, board: '', isLatest: false, year: -1);
  final News dummyNews = News(
    title: '',
    date: '',
    imgUrl:
        'https://www.capwholesalers.com/shop/images/p.68628.1-thumbs-up.png',
    description: '',
    isLatest: false,
  );
  @override
  Widget build(BuildContext context) {
    print(_error);
    //HOMEPHOTOS
    final homePhotos = Provider.of<HomePhotos>(context, listen: false);
    final List<String> imgList =
        homePhotos.homephotos.length == 0 || homePhotos.homephotos.isEmpty
            ? [emptyImage]
            : homePhotos.homephotos;
    //EVENTS
    final events = Provider.of<Events>(context, listen: false);
    final eventsList = events.events == null || events.events.isEmpty
        ? [dummyEvent]
        : events.events;
    final List<Event> latestEventsList =
        events.latestevents.isEmpty ? [dummyEvent] : events.latestevents;
    //RANKINGS
    final rankings = Provider.of<Ranks>(context, listen: false);
    final ranksList = rankings.ranks;
    final latestRanks = rankings.latestRanks;
    //NEWS
    final news = Provider.of<NewsList>(context, listen: false);
    final newsList =
        news.news.length == 0 || news.news.isEmpty ? [dummyNews] : news.news;
    final latestNews = news.latestnews.length == 0 || news.latestnews.isEmpty
        ? [dummyNews]
        : news.latestnews;
    final eventsCarousel = CarouselSlider.builder(
      itemCount: latestEventsList.length,
      options: CarouselOptions(
        height: 150,
        // initialPage: (latestEventsList.length~/2),
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
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => EventDetail(
                      event: latestEventsList[index],
                    ))),
            child: Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Stack(
                      children: [
                        Image.network(
                          latestEventsList[index].imgUrl,
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
                        // Align(
                        //   alignment: Alignment.topRight,
                        //   child: Text(latestEventsList[index].date,style: TextStyle(
                        //     color:kWhite
                        //   ),),
                        // )
                        if (latestEventsList[index].isUpcoming) upcome,
                      ],
                    )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    latestEventsList[index].title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: kWhite),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
    return RefreshIndicator(
      onRefresh: () async {
        try {
          await Provider.of<HomePhotos>(context, listen: false)
              .fetchAndSetHomePhotos();
        } catch (e) {
          setState(() {
            _error = true;
          });
        }
        try {
          await Provider.of<Events>(context, listen: false).fetchAndSetEvents();
        } catch (e) {
          setState(() {
            _error = true;
          });
        }
        try {
          await Provider.of<NewsList>(context, listen: false).fetchAndSetNews();
        } catch (e) {
          setState(() {
            _error = true;
          });
        }
        try {
          await Provider.of<Ranks>(context, listen: false).fetchAndSetRanks();
        } catch (e) {
          setState(() {
            _error = true;
          });
        }
      },
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                carouselWithBlue(imgList),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      subHeading(
                          'Trending Events',
                          EventsPage(
                            events: eventsList,
                          ),
                          context),
                      eventsCarousel,
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      subHeading(
                          'Latest News',
                          NewsListings(
                            newsList: newsList,
                          ),
                          context),
                      //LATEST NEWS LIST
                      Container(
                        height: 140,
                        child: ListView.builder(
                          itemBuilder: (ctx, index) {
                            return ListTile(
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => NewsDetailPage(
                                            news: latestNews[index],
                                          ))),
                              leading: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: kWhite,
                                  backgroundImage:
                                      NetworkImage(latestNews[index].imgUrl)),
                              title: Text(latestNews[index].title),
                              subtitle: Text(latestNews[index].date),
                            );
                          },
                          itemCount: latestNews.length,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      subHeading(
                          'Rankings',
                          RankingsPage(
                            rankingsList: ranksList,
                          ),
                          context),
                      SizedBox(
                        height: 20,
                      ),
                      for (int i = 0; i < latestRanks.length; i = i + 2)
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                //alignment: WrapAlignment.spaceBetween,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:8.0),
                                    child: rankingsRow(
                                      latestRanks[i].ranking,
                                      latestRanks[i].board,
                                      latestRanks[i].year,
                                    ),
                                  ),
                                  if (i + 1 < latestRanks.length)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:8.0),
                                      child: rankingsRow(
                                        latestRanks[i + 1].ranking,
                                        latestRanks[i + 1].board,
                                        latestRanks[i + 1].year,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        )
                    ],
                  ),
                ))
              ],
            ),
          ),
          if (_error)
            Container(
              color: kBlack54,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: kWhite70,
                        ),
                        Positioned(
                          left: 20,
                          top: 20,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: kGreen300,
                          ),
                        ),
                        Positioned(
                          left: 52,
                          top: 52,
                          child: CircleAvatar(
                            radius: 8,
                            backgroundColor: kWhite70,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        'OOPS!',
                        style: TextStyle(
                            color: kGreen300,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      '\t\t\t\t\tSlow or no internet connection\nPlease check your internet connection',
                      style: TextStyle(
                        color: kWhite,
                        fontSize: 12,
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: GestureDetector(
                        onTap: () async {
                          try {
                            final result =
                                await InternetAddress.lookup('google.com');
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                              border: Border.all(color: kWhite),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Text(
                            'Retry',
                            style: TextStyle(
                              color: kWhite,
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
    );
  }
}


