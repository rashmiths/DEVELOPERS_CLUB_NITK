import 'package:flutter/foundation.dart';

class Rank {
  final int ranking;
  final String board;
  final bool isLatest;
  final int year;


  Rank({
   @required this.ranking,
   @required this.board,
   @required this.isLatest,
   @required this.year,
  });
}
