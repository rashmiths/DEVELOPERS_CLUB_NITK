import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_nitk/providers/news.dart';
import 'package:pocket_nitk/screens/news_detail_page.dart';


class NewsListings extends StatelessWidget {
  final List<News> newsList;

  const NewsListings({Key key, @required this.newsList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                  // gradient: LinearGradient(
                  //   begin: Alignment.topRight,
                  //   end: Alignment.bottomLeft,
                  //   colors: [Colors.lightBlue, Colors.lightBlueAccent],
                  // ),
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
                        'News',
                        style:
                            TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) =>
                                  NewsDetailPage(),
                            ),
                          ),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            child: Image.network(
                              newsList[index].imgUrl,
                              height: 80,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            newsList[index].title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 15,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(newsList[index].date),
                              ),
                            ],
                          ),
                        ),
                        Divider()
                      ],
                    );
                  },
                  itemCount: newsList.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
