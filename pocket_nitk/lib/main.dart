import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocket_nitk/providers/events.dart';
import 'package:pocket_nitk/providers/home_photos.dart';
import 'package:pocket_nitk/providers/news_list.dart';
import 'package:pocket_nitk/providers/ranks.dart';
import 'package:pocket_nitk/screens/bottom_tabs.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomePhotos([])),
        ChangeNotifierProvider(create: (_) => Events([])),
        ChangeNotifierProvider(create: (_) => Ranks([])),
        ChangeNotifierProvider(create: (_) => NewsList([])),
        
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pocket Nitk',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BottomTabs(),
      ),
    );
  }
}
