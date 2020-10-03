import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_nitk/constants/endpoints.dart';
import 'package:pocket_nitk/providers/lecture_hall.dart';

class LectureHalls with ChangeNotifier {
  List<LectureHall> _lectureHall = [];
  LectureHalls(this._lectureHall);

  List<LectureHall> get lectureHalls {
    return [..._lectureHall];
  }

  // Event findById(String id) {
  //   return _eve.firstWhere((prod) => prod.id == id);
  // }

  Future<void> fetchAndSetLectureHalls() async {
    var url = lectureHallsEndPoint;
    try {
      final response = await http.get(url);

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      final List<LectureHall> loadedProductTypes = [];
      extractedData.forEach((prodId, prodData) {
        loadedProductTypes.add(LectureHall(
          title: prodData['title'] ?? 'Title Not Available',
          imgUrl: prodData['imgUrl'] ?? blankImage,
        ));
      });

      _lectureHall = loadedProductTypes;

      notifyListeners();
    } on SocketException {
      throw 'NO INTERNET';
    } catch (error) {
      print('#####');
      throw (error);
    }
  }
}
