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

  Future<void> toggleFavouriteStatus(String token, String userId) async {
    final oldState = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url =
        'https://e-shop-today-default-rtdb.firebaseio.com/userFavourite/$userId/$id.json?auth=$token';
    try {
      await http.put(Uri.parse(url),
          body: json.encode(
            isFavourite,
          ));
    } catch (error) {
      isFavourite = oldState;
    }
    notifyListeners();
  }
}
