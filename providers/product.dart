import 'package:flutter/foundation.dart';

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
  void toggleFavouriteStatus() {
    isFavourite = !isFavourite;
    notifyListeners();
  }
}
