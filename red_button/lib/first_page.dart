import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:red_button/bottom_tabs.dart';
import 'package:red_button/homepage.dart';
import 'package:red_button/providers/authorization.dart';
import 'package:red_button/providers/emergency_contacts.dart';

class FirstPage extends StatefulWidget {
  FirstPage({Key key, this.title}) : super(key: key);

  final String title;
  final String reloadLabel = 'Confirm';
  final String fireLabel = 'Trust Them';
  final Color floatingButtonColor = Colors.red[800];
  final IconData reloadIcon = Icons.refresh;
  //final IconData fireIcon = Icons.conf;

  @override
  _FirstPageState createState() => _FirstPageState(
        floatingButtonLabel: this.fireLabel,
        //icon: this.fireIcon,
        floatingButtonColor: this.floatingButtonColor,
      );
}

class _FirstPageState extends State<FirstPage> {
  List<Contact> _contacts = new List<Contact>();
  List<CustomContact> _uiCustomContacts = List<CustomContact>();
  List<CustomContact> _allContacts = List<CustomContact>();
  List<Contact> _selectedContacts = [];
  bool _isLoading = false;
  bool _isSelectedContactsView = false;
  String floatingButtonLabel;
  Color floatingButtonColor;
  IconData icon;

  _FirstPageState({
    this.floatingButtonLabel,
    this.icon,
    this.floatingButtonColor,
  });
  PermissionStatus permissionStatus;

  @override
  void initState() {
    super.initState();
    getContactsPermission().then((granted) {
      if (permissionStatus == PermissionStatus.granted) {
        refreshContacts();
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Oops!'),
            content: const Text(
                'Looks like permission to read contacts is not granted.'),
            actions: <Widget>[
              FlatButton(
                child: const Text('OK'),
                onPressed: () async {
                  Navigator.pop(context);
                  getContactsPermission();
                },
              ),
            ],
          ),
        );
      }
    });
  }
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: new Text(
          'Select Contacts',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: !_isLoading
          ? Container(
              child: ListView.builder(
                itemCount: _uiCustomContacts?.length,
                itemBuilder: (BuildContext context, int index) {
                  CustomContact _contact = _uiCustomContacts[index];
                  var _phonesList = _contact.contact.phones.toList();

                  return Column(
                    children: [
                      _buildListTile(_contact, _phonesList),
                      Divider(
                        thickness: 1,
                      )
                    ],
                  );
                },
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: new FloatingActionButton.extended(
        backgroundColor: floatingButtonColor,
        onPressed: _onSubmit,
        //icon: Icon(icon),
        label: Text(floatingButtonLabel),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _onSubmit() {
    setState(() {
      if (!_isSelectedContactsView) {
        _uiCustomContacts =
            _allContacts.where((contact) => contact.isChecked == true).toList();
        _isSelectedContactsView = true;
        _restateFloatingButton(
          widget.reloadLabel,
          Icons.refresh,
          Colors.green,
        );
      } else {
        // _uiCustomContacts = _allContacts;
        // _isSelectedContactsView = false;
        // _restateFloatingButton(
        //   widget.fireLabel,
        //   Icons.filter_center_focus,
        //   Colors.red,
        // );
        

        Provider.of<Emergency>(context, listen: false)
            .addEmergencyContacts(_selectedContacts);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
          return BottomTabs();
        }));
      }
    });
  }

  ListTile _buildListTile(CustomContact c, List<Item> list) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.red[800],
        child: Text(
            (c.contact.displayName[0] + c.contact.displayName[0].toUpperCase()),
            style: TextStyle(color: Colors.white)),
      ),
      title: Center(child: Text(c.contact.displayName ?? "")),
      subtitle: list.length >= 1 && list[0]?.value != null
          ? Center(child: Text(list[0].value))
          : Text(''),
      trailing: Checkbox(
          activeColor: Colors.green,
          value: c.isChecked,
          onChanged: (bool value) {
            if (value == true) {
              _selectedContacts.add(c.contact);
            } else if (value == false) {
              _selectedContacts.remove(c.contact);
            }
            setState(() {
              c.isChecked = value;
            });
          }),
    );
  }

  void _restateFloatingButton(String label, IconData icon, Color color) {
    floatingButtonLabel = label;
    icon = icon;
    floatingButtonColor = color;
  }

  refreshContacts() async {
    setState(() {
      _isLoading = true;
    });
    var contacts = await ContactsService.getContacts();
    _populateContacts(contacts);
  }

  void _populateContacts(Iterable<Contact> contacts) {
    _contacts = contacts.where((item) => item.displayName != null).toList();
    _contacts.sort((a, b) => a.displayName.compareTo(b.displayName));
    _allContacts =
        _contacts.map((contact) => CustomContact(contact: contact)).toList();
    setState(() {
      _uiCustomContacts = _allContacts;
      _isLoading = false;
    });
  }

  Future<PermissionStatus> getContactsPermission() async {
    try {
      await Permission.contacts.request();
      permissionStatus = PermissionStatus.granted;
    } catch (e) {
      print(e);
    }
  }
}

class CustomContact {
  final Contact contact;
  bool isChecked;

  CustomContact({
    this.contact,
    this.isChecked = false,
  });
}
