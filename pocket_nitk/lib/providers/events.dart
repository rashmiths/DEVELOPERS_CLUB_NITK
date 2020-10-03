import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:pocket_nitk/providers/event.dart';
import 'package:http/http.dart' as http;

class Events with ChangeNotifier {
  List<Event> _events = [];
  Events(this._events);

  List<Event> get events {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._events];
  }
  List<Event> get latestevents{

    return _events.where((element) => element.isLatest).toList();

  }

  // Event findById(String id) {
  //   return _eve.firstWhere((prod) => prod.id == id);
  // }

  Future<void> fetchAndSetEvents() async {
    var url = 'https://pocketnitk.firebaseio.com/events.json';
    try {
       
      final response = await http.get(url);
     
     
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      final List<Event> loadedProductTypes = [];
      extractedData.forEach((prodId, prodData) {
        loadedProductTypes.add(Event(
          
          title: prodData['title'] ?? 'Title Not Available',
          imgUrl: prodData['imgUrl'] ??
              'https://www.capwholesalers.com/shop/images/p.68628.1-thumbs-up.png',
          isUpcoming: prodData['isUpcoming']??false,
          isLatest:prodData['isLatest']??false ,
          description: prodData['description']??' The massive technology conference Techweek references past attendees and sponsors to illustrate how popular and illustrious the event is',
          date:prodData['date']??''
        ));
      });
      
      _events = loadedProductTypes;
      _events.sort((a, b) => int.parse(b.date.substring(6, 10) +
            b.date.substring(3, 5) +
            b.date.substring(0, 2))
        .compareTo(int.parse(a.date.substring(6, 10) +
            a.date.substring(3, 5) +
            a.date.substring(0, 2))));
      notifyListeners();
    } on SocketException {
      throw 'NO INTERNET';
    } catch (error) {
      print('#####');
      throw (error);
    }
  }
}
