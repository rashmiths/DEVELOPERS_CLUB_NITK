import 'package:flutter/material.dart';
import 'package:pocket_nitk/providers/event.dart';
import 'package:pocket_nitk/screens/events_details_page.dart';

class EventsPage extends StatefulWidget {
  final List<Event> events;

  const EventsPage({Key key, @required this.events}) : super(key: key);

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    int day1;
    int month1;
    int year1;
    int day2;
    int month2;
    int year2;
    final TabController _tabController = TabController(length: 4, vsync: this);
    //generating date from the string
    List<DateTime> dateGenerate(Event element) {
      day1 = int.parse(element.date.substring(0, 2));
      month1 = int.parse(element.date.substring(3, 5));
      year1 = int.parse(element.date.substring(6, 10));
      day2 = int.parse(element.date.substring(11, 13));
      month2 = int.parse(element.date.substring(14, 16));
      year2 = int.parse(element.date.substring(17, 21));

      DateTime startingdate = DateTime(year1, month1, day1);
      DateTime endingdate = DateTime(year2, month2, day2);
      return [startingdate, endingdate];
    }

    final List<Event> _completedEvents = widget.events.where((element) {
      List<DateTime> dates = dateGenerate(element);
      return dates[1].isBefore(DateTime.now());
    }).toList();
    final List<Event> _upcomingEvents = widget.events.where((element) {
      List<DateTime> dates = dateGenerate(element);
      return dates[0].isAfter(DateTime.now());
    }).toList();
    final List<Event> _ongoingEvents = widget.events.where((element) {
      List<DateTime> dates = dateGenerate(element);
      return dates[0].isBefore(DateTime.now()) &&
          dates[1].isAfter(DateTime.now());
    }).toList();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Events',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: SafeArea(
                child: TabBar(
                  controller: _tabController,
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.blue[800],
                  labelPadding: EdgeInsets.only(bottom: 4),
                  indicatorColor: Colors.blue[800],
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
                  tabs: [
                    Text('All'),
                    Text('Ongoing'),
                    Text('Upcoming'),
                    Text('Completed'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (ctx) => EventDetail(
                                        event: widget.events[index],
                                      )
                                  // EventsDetailPage(
                                  //     news: widget.events[index]),
                                  ),
                            ),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              child: Image.network(
                                widget.events[index].imgUrl,
                                height: 200,
                                width: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              widget.events[index].title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Wrap(
                              // mainAxisSize: MainAxisSize.min,
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              alignment: WrapAlignment.spaceBetween,
                              direction: Axis.horizontal,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(widget.events[index].date),
                                ),
                                _completedEvents.contains(widget.events[index])
                                    ? Card(
                                        //elevation: 2,
                                        color: Colors.green[50],
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'COMPLETED',
                                            style: TextStyle(
                                                color: Colors.green[700],
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ))
                                    : _upcomingEvents
                                            .contains(widget.events[index])
                                        ? Card(
                                            //elevation: 2,
                                            color: Colors.amber[50],
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Text(
                                                'UPCOMING',
                                                style: TextStyle(
                                                    color: Colors.amber,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ))
                                        : Card(
                                            //elevation: 2,
                                            color: Colors.blue[50],
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Text(
                                                'ONGOING',
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ))
                              ],
                            ),
                          ),
                          Divider()
                        ],
                      );
                    },
                    itemCount: widget.events.length,
                  ),
                  tabs(_ongoingEvents, 'Ongoing'),
                  tabs(_upcomingEvents, 'Upcoming'),
                  tabs(_completedEvents, 'Completed'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget tabs(List<Event> events, String title) {
  return events.isEmpty
      ? Center(
          child: Text('No $title Events'),
        )
      : ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (ctx) => EventDetail(
                              event: events[index],
                            )
                        // EventsDetailPage(
                        //     news: widget.events[index]),
                        ),
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: Image.network(
                      events[index].imgUrl,
                      height: 200,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    events[index].title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(events[index].date),
                      ),
                    ],
                  ),
                ),
                Divider()
              ],
            );
          },
          itemCount: events.length,
        );
}
