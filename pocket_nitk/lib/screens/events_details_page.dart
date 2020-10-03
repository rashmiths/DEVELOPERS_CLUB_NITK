import 'package:flutter/material.dart';
import 'package:pocket_nitk/constants/colors.dart';
import 'package:pocket_nitk/providers/event.dart';

class EventDetail extends StatelessWidget {
    final Event event;

    const EventDetail({Key key,@required this.event}) : super(key: key);
    @override
    Widget build(BuildContext context) {
     
      //GENERATING THE DATE 
      int day1 = int.parse(event.date.substring(0, 2));      
      int month1 = int.parse(event.date.substring(3, 5));     
      int  year1 = int.parse(event.date.substring(6, 10));
        //TO ASSIGN THE BADGE i.e COMPLETED,UPCOMING,ONGOING
      final DateTime dateTime=DateTime(year1,month1,day1);
      final String title=dateTime.isBefore(DateTime.now())?'COMPLETED':dateTime.isAfter(DateTime.now())?'UPCOMING':'ONGOING';   
      final colourLight = title == 'COMPLETED'
          ? kGreen50
          : title == 'UPCOMING' ? kAmber50: kBlue50;
      final colourDark = title == 'COMPLETED'
          ? kGreen700
          : title == 'UPCOMING' ? kAmber700 : kBlue700;

      return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              //TITLE OF THE PAGE
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Image.network(
                      event.imgUrl,
                      height: 270,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: MediaQuery.of(context).size.height *0.370,
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
                      'Event Details',
                      style: TextStyle(
                          color: kWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:MediaQuery.of(context).size.height *0.370, left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: kWhite),
                    ),
                    SizedBox(height: 10),
                    Text(
                      event.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: kWhite),
                    ),
                  ],
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
                          padding: const EdgeInsets.only(left:10.0,right: 10.0,top: 20.0,bottom: 10),
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              Wrap(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: colourLight,
                                    child: Icon(
                                      Icons.calendar_today,
                                      color: colourDark,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          event.date.substring(0, 10),
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:8.0),
                                          child: Text(
                                            'Start Date',
                                            style: TextStyle(
                                              fontSize: 16,                                            
                                              color: kGrey
                                              
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              //ICON WITH DESCRIPTION
                              Wrap(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: colourLight,
                                    child: Icon(
                                      Icons.calendar_today,
                                      color: colourDark,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          event.date.substring(11),
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:8.0),
                                          child: Text(
                                            'End Date',
                                            style: TextStyle(
                                              fontSize: 16,                                            
                                              color: kGrey
                                              
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Description',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '     ${event.description}',
                          style: TextStyle(color: kGrey, fontSize: 18),
                        ),
                      )
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