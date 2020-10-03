import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_nitk/constants/endpoints.dart';
import 'package:pocket_nitk/providers/rank.dart';

class Ranks with ChangeNotifier {
  List<Rank> _ranks = [];
  Ranks(this._ranks);

  List<Rank> get ranks {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._ranks];
  }

  List<Rank> get latestRanks {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return _ranks.where((element) => element.isLatest).toList();
  }

  Future<void> fetchAndSetRanks() async {
    var url = rankEndPoint;
    try {
      final response = await http.get(url);

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      final List<Rank> loadedRanks = [];
      extractedData.forEach((prodId, prodData) {
        loadedRanks.add(Rank(
            board: prodData['board'] ?? 'board Not Available',
            ranking: prodData['rank'],
            isLatest: prodData['isLatest'] ?? false,
            year: prodData['year']));
      });
      _ranks = loadedRanks;
      notifyListeners();
    } on SocketException {
      throw 'NO INTERNET';
    } catch (error) {
      print('#####');
      throw (error);
    }
  }
}
