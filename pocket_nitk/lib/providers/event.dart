import 'package:flutter/foundation.dart';

class Event {
  final String imgUrl;
  final String title;
  final bool isUpcoming;
  final bool isLatest;
  final String description;
  final String date;

  Event({
    @required this.imgUrl,
    @required this.title,
    @required this.isUpcoming,
     @required this.isLatest,
     @required this.description,
    @required this.date,
  });
}
