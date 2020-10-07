import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:red_button/widgets/fade_animation.dart';
import 'package:red_button/screens/first_page.dart';
import 'package:red_button/providers/emergency_contacts.dart';

import 'package:flutter_sms/flutter_sms.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final contacts = Provider.of<Emergency>(context);

    ///trusted contacts list
    final trustedContacts = Padding(
      padding: const EdgeInsets.only(top: 400.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, bottom: 10.0, left: 10),
                child: Text(
                  'TRUSTED CONTACTS',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              contacts.emergencyContacts.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Text(' Emergency contacts list is empty'),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemBuilder: (ctx, i) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.red[800],
                                    child: Text(
                                        (contacts.emergencyContacts.values
                                                .toList()[i]
                                                .displayName[0] +
                                            contacts.emergencyContacts.values
                                                .toList()[i]
                                                .displayName[1]
                                                .toUpperCase()),
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  title: Center(
                                      child: Text(contacts
                                              .emergencyContacts.values
                                              .toList()[i]
                                              .displayName ??
                                          "")),
                                  subtitle: Center(
                                    child: Text(contacts
                                        .emergencyContacts.values
                                        .toList()[i]
                                        .value),
                                  ),
                                  trailing: IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        contacts.removeEmergencyContact(contacts
                                            .emergencyContacts.values
                                            .toList()[i]
                                            .value);
                                      }),
                                ),
                                Divider()
                              ],
                            ),
                          );
                        },
                        itemCount: contacts.emergencyContacts.length,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );

    ///the body
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height,
          child: Stack(
            children: [
              Container(
                color: Colors.red[50],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.group_add, size: 40),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => FirstPage()));
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: GestureDetector(
                    onTap: () {
                      Location location = Location();

                      location.getLocation().then((value) {
                        List<String> tem2 = [];
                        int j;
                        for (j = 0;
                            j <
                                contacts.emergencyContacts.values
                                    .toList()
                                    .length;
                            j++) {
                          tem2.add(contacts.emergencyContacts.values
                              .toList()[j]
                              .value);
                        }

                        _sendSMS(
                            'Contact me immedietly any my coordinates is (${value.latitude},${value.longitude})' +
                                'click the link https://www.google.com/maps/search/${value.latitude},+${value.longitude}/@{$value.latitude},${value.longitude},17z',
                            tem2);
                      });
                    },
                    child: Stack(
                      children: [
                        FadeAnimation(
                          3.6,
                          Container(
                            height: 300,
                            width: 300,
                            decoration: BoxDecoration(
                              color: Colors.red[800],
                              shape: BoxShape.circle,
                              // border: Border.all(
                              //   //color: Colors.grey,
                              // )
                            ),
                          ),
                        ),
                        //circular animation
                        Positioned(
                          left: 25,
                          top: 25,
                          child: FadeAnimation(
                            2.8,
                            Container(
                              height: 250,
                              width: 250,
                              decoration: BoxDecoration(
                                color: Colors.red[600],
                                shape: BoxShape.circle,
                                // border: Border.all(
                                //     //color: Colors.grey,
                                //     )
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 50,
                          top: 50,
                          child: FadeAnimation(
                            1.5,
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.red[400],
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 70,
                          top: 70,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.red[100],
                            backgroundImage: AssetImage(
                              'assets/emergency2.png',
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'TAP',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    'ON',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    'EMERGENCY',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              trustedContacts,
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Icon(
                  Icons.phone,
                  size: 30,
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}

void _sendSMS(String message, List<String> recipents) async {
  await FlutterSms.sendSMS(message: message, recipients: recipents);
//setState(() => _message = _result);
}
