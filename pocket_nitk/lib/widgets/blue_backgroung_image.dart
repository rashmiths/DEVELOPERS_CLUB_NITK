import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_nitk/screens/bottom_tabs.dart';

Widget carouselWithBlue(List<String> imgList){
  return Padding(
                padding: const EdgeInsets.only(top: 6.0, left: 6, right: 6,bottom: 15),
                child: Stack(children: [
                  ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      height: 270,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(  
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [Colors.lightBlue[900], Colors.lightBlue[300]],
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text("Pocket N I T K",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 90, left: 30, right: 30),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: CarouselSlider.builder(
                          itemCount: imgList.length,
                          options: CarouselOptions(
                            viewportFraction: 1.0,
                            autoPlayInterval: Duration(seconds: 4),
                            aspectRatio: 1.5,
                            //enlargeCenterPage: true,
                            autoPlay: true,
                          ),
                          itemBuilder: (ctx, index) {
                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Container(
                                      child: Image.network(
                                    imgList[index],
                                    width: double.infinity,
                                    height: double.infinity,

                                    fit: BoxFit.fill,
                                  )),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    //crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      for (int i = 0; i < imgList.length; i++)
                                        i == index
                                            ? Icon(
                                                Icons.radio_button_checked,
                                                size: 8,
                                                color: Colors.white,
                                              )
                                            : Icon(
                                                Icons.radio_button_unchecked,
                                                size: 8,
                                                color: Colors.white,
                                              ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      )),
                ]),
              );

}