import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_nitk/providers/hostel.dart';

class Hostels with ChangeNotifier {
  List<Hostel> _hostel = [];
  Hostels(this._hostel);

  List<Hostel> get hostels {
    return [..._hostel];
  }

  // Event findById(String id) {
  //   return _eve.firstWhere((prod) => prod.id == id);
  // }

  Future<void> fetchAndSetHostels() async {
    var url = 'https://pocketnitk.firebaseio.com/buildings/hostels.json';
    try {
      final response = await http.get(url);

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      final List<Hostel> loadedProductTypes = [];
      extractedData.forEach((prodId, prodData) {
        
        
        loadedProductTypes.add(Hostel(
          title: prodData['title'] ?? 'Title Not Available',
          imgUrl: prodData['imgUrl'] ??
              'https://www.capwholesalers.com/shop/images/p.68628.1-thumbs-up.png',
          hostelName: prodData['hostelName'] ?? 'NA',
          rooms: prodData['rooms'] ?? -1,
          strength: prodData['strength'] ?? -1,
          wardenName: prodData['wardenName'] ?? 'NA',
          monday: prodData['monday'],
          tuesday: prodData['tuesday'],
          wednesday: prodData['wednesday'],
          thursday: prodData['thursday'],
          friday: prodData['friday'],
          saturday: prodData['saturday'],
          sunday: prodData['sunday']
        ));
      });

      _hostel = loadedProductTypes;
     

      notifyListeners();
    } on SocketException {
      throw 'NO INTERNET';
    } catch (error) {
      print('#####');
      throw (error);
    }
  }
}
