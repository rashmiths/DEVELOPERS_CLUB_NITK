import 'package:flutter/foundation.dart';

class News {
  final String title;
  final String date;
  final String imgUrl;
  final String description;
  final bool isLatest;

  News({
    @required this.title,
    @required this.date,
    @required this.imgUrl,
    @required this.description,
    @required this.isLatest,
  });
}
