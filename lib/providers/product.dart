import 'dart:convert';
import '../models/http_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFav;
  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFav = false,
  });
  void _setFavValue(bool newValue) {
    isFav = newValue;
    notifyListeners();
  }

  Future<void> saveFavoriteStatus() async {
    final oldStatus = isFav;
    isFav = !isFav;
    final url = Uri.parse(
        'https://sshoopp-aapppp22-default-rtdb.firebaseio.com//products/$id.json');
    try {
      final response = await http.patch(url,
          body: json.encode({
            'isFavorite': isFav,
          }));
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
        throw HttbException('Could not update product.');
      }
    } catch (error) {
      _setFavValue(oldStatus);
      notifyListeners();
    }
    notifyListeners();
  }
}
