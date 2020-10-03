import 'package:flutter/material.dart';

class InfoDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 130, top: 10),
              child: Text('INFO',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 10, right: 10),
              child: Text(
                  ' * Its deliberately made to show your location only when ur in NITK premises',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10, right: 10),
              child: Text(' * Some important locations are already marked',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text('* To mark a New Location Long Press on the Location',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.only(left: 80),
              child: Text('* How to Navigate?',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.only(left: 60.0, top: 10),
              child: Text(
                  '# \tTap on the Marker \n # \ttwo option will popup in the bottom \n # \tclick enter icon to see direction \n # \tmap icon to locate'),
            )
          ],
        ),
      ),
    );
  }
}
