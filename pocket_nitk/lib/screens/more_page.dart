
import 'package:flutter/material.dart';
import 'package:pocket_nitk/constants/colors.dart';

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:kWhite ,
        title: Text('MORE',style: TextStyle(color: kBlack),),
        centerTitle: true,
      ),
          body: Center(
        child: Container(
          child:Text('Under Construction',style: TextStyle(
            color: kRed,
            fontWeight: FontWeight.bold,
            fontSize: 25

          ),)
          
        ),
      ),
    );
  }
}