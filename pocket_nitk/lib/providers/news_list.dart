import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_nitk/providers/news.dart';

class NewsList with ChangeNotifier {
  List<News> _news = [];
  NewsList(this._news);

  List<News> get news {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._news];
  }

  List<News> get latestnews {
    return _news.where((element) => element.isLatest).toList();
  }

  // Event findById(String id) {
  //   return _eve.firstWhere((prod) => prod.id == id);
  // }

  Future<void> fetchAndSetNews() async {
    var url = 'https://pocketnitk.firebaseio.com/news.json';
    try {
      final response = await http.get(url);

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      final List<News> loadedProductTypes = [];
      extractedData.forEach((prodId, prodData) {
        loadedProductTypes.add(News(
            title: prodData['title'] ?? 'Title Not Available',
            imgUrl: prodData['imgUrl'] ??
                'https://www.capwholesalers.com/shop/images/p.68628.1-thumbs-up.png',
            description: prodData['description'] ?? '',
            isLatest: prodData['isLatest'] ?? false,
            date: prodData['date'] ?? ''));
      });
      _news = loadedProductTypes;
      _news.sort((a, b) => int.parse(b.date.substring(6, 10) +
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
