import 'package:flutter/material.dart';
import 'package:pocket_nitk/constants/colors.dart';
import 'package:pocket_nitk/providers/rank.dart';

class RankingsPage extends StatelessWidget {
  final List<Rank> rankingsList;

  const RankingsPage({Key key, @required this.rankingsList}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    //LIST OF RANKS
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
                ),
                child: Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Awards',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
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
                          leading: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            child: Wrap(
                              //mainAxisSize: MainAxisSize.min,

                              crossAxisAlignment: WrapCrossAlignment.center,
                              direction: Axis.vertical,
                              children: [
                                Text(
                                  rankingsList[index].ranking == null
                                      ? '#'
                                      : rankingsList[index].ranking.toString(),
                                  style: TextStyle(
                                    color: kGreen400,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                                if (rankingsList[index].ranking != null)
                                  Text(
                                    'RANK',
                                    style: TextStyle(
                                      color: kIndigo900,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          title: Text(
                            rankingsList[index].board,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 15,
                                color: kGrey,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Text(rankingsList[index].year.toString()),
                              ),
                            ],
                          ),
                        ),
                        Divider()
                      ],
                    );
                  },
                  itemCount: rankingsList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
