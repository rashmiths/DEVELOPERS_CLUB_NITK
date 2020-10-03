
import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.white ,
        title: Text('MORE',style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
          body: Center(
        child: Container(
          child:Text('Under Construction',style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 25

          ),)
          
        ),
      ),
    );
  }
}