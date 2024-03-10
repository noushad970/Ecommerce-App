import 'package:flutter/foundation.dart';

class AdminProduct with ChangeNotifier {
  final String id;
  final String title;
  final String Discription;
  final String imageUrl;
  final double price;
  AdminProduct({
    required this.id,
    required this.title,
    required this.Discription,
    required this.imageUrl,
    required this.price,
  });
}
