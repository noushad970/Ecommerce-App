import 'package:flutter/material.dart';
import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Charged Assert',
      Discription:
          'Product Dimensions  :  8.86 x 13.39 x 4.53 inches; 1.7 Pounds \nItem model number  :  3026175 \nDepartment  :  mens',
      imageUrl:
          'https://m.media-amazon.com/images/I/61nLC5ZoYXL._AC_SY695_.jpg',
      price: 44.99,
    ),
    Product(
      id: 'p2',
      title: 'Sportstyle Tricot Joggers',
      Discription:
          'Product Dimensions  :  13.58 x 9.76 x 2.13 inches; 11.46 Ounces \nItem model number  :  1290261 \nDepartment  :  mens',
      imageUrl:
          'https://m.media-amazon.com/images/I/41TKL5J43hL._AC_SX679_.jpg',
      price: 50.99,
    ),
    Product(
      id: 'p3',
      title: 'Justin Rectangular Sunglasses',
      Discription:
          'Is Discontinued By Manufacturer  : No\nItem Weight  :  1 Ounces\nItem model number  :  0RB4165\nDepartment  :  womens',
      imageUrl:
          'https://m.media-amazon.com/images/I/41BqQwq4YKL._AC_SX679_.jpg',
      price: 68.99,
    ),
    Product(
      id: 'p4',
      title: 'Gildan Crew T-Shirts',
      Discription:
          'Product Dimensions  :  11.22 x 8.82 x 2.68 inches; 1.32 Pounds \nItem model number  :  G1100 \nDepartment  :  mens',
      imageUrl:
          'https://m.media-amazon.com/images/I/710o0VupScL._AC_SX679_.jpg',
      price: 27.99,
    ),
  ];
  List<Product> get items {
    return [..._items];
  }

  Product findByID(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void addProduct() {
    //_item.add(value);
    notifyListeners();
  }
}