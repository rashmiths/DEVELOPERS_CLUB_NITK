import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


class HomePhotos with ChangeNotifier{
  List<String> _homephotos = [];
  HomePhotos(this._homephotos);

 List<String> get homephotos {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._homephotos];
  }
  Future<void> fetchAndSetHomePhotos() async {
    var url = 'https://pocketnitk.firebaseio.com/homephotos.json';
    try {
      
      final response = await http.get(url);      
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      final List<String> loadedHomePhotos = [];
      extractedData.forEach((photId, photData) {
        loadedHomePhotos.add(
          
       photData??
              'https://www.capwholesalers.com/shop/images/p.68628.1-thumbs-up.png',
        );
      });
      _homephotos = loadedHomePhotos;      
      print(_homephotos);
      notifyListeners();
    } on SocketException {
      throw 'NO INTERNET';
    } catch (error) {
      print('#####');
      throw (error);
    }
  }
}