import 'package:flutter/material.dart';
import 'package:pocket_nitk/providers/lecture_hall.dart';


class LHCPage extends StatelessWidget {
  final LectureHall lhc;

  const LHCPage({Key key, @required this.lhc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lhc.title),
        centerTitle: true,
      ),
      body: SafeArea(child: Center(
        child: Text('Under Construction',style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 25

          ),),
      )),
    );
  }
}