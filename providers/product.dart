import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String Discription;
  final String imageUrl;
  final double price;
  bool isFavourite;
  Product(
      {required this.id,
      required this.title,
      required this.Discription,
      required this.imageUrl,
      required this.price,
      this.isFavourite = false});

  Future<void> toggleFavouriteStatus() async {
    final oldState = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url =
        'https://e-shop-today-default-rtdb.firebaseio.com/products/$id.json';
    try {
      await http.patch(Uri.parse(url),
          body: json.encode({
            'isFavorite': isFavourite,
          }));
    } catch (error) {
      isFavourite = oldState;
    }
    notifyListeners();
  }

  String getId() {
    return id;
  }
}
