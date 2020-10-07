import 'dart:typed_data';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'emergency_contacts.g.dart';

@HiveType(typeId: 1)
class EmergencyContact {
  @HiveField(1)
  final Uint8List avatar;
  @HiveField(2)
  final String displayName;
  @HiveField(3)
  final String givenName;
  @HiveField(4)
  final String value;

  EmergencyContact({
    @required this.avatar,
    @required this.displayName,
    @required this.givenName,
    @required this.value,
  });
}

class Emergency with ChangeNotifier {
  final Map<String, EmergencyContact> emcontacts =
      Hive.box('cart').toMap().cast<String, EmergencyContact>();
  Map<String, EmergencyContact> get emergencyContacts {
    print('****************');
    print(emcontacts);
    return emcontacts;
  }

  void addEmergencyContacts(List<Contact> contacts) async {
    for (int i = 0; i < contacts.length; i++) {
      List<Item> list = contacts[i].phones.toList();

      final hiveItem = EmergencyContact(
          avatar: contacts[i].avatar,
          displayName: contacts[i].displayName,
          givenName: contacts[i].givenName,
          value:
              list.length >= 1 && list[0]?.value != null ? list[0].value : '');

      await Hive.openBox('cart');

      Hive.box('cart').put(hiveItem.value, hiveItem);
      emcontacts.putIfAbsent(hiveItem.value, () => hiveItem);

      notifyListeners();
    }

    // Hive.box('cart').add(contacts[i]);
  }

  void removeEmergencyContact(String id) {
    // print('############################################');
    // print(Hive.box('cart').get('$id $i'));
    Hive.box('cart').delete(id);
    emcontacts.removeWhere((key, value) => value.value == id);

    notifyListeners();
  }
//  Future clearHive() async {
//    await  Hive.box('cart').clear();

//   }

}
