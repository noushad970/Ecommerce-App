import 'dart:convert';

import 'package:flutter/material.dart';
import 'product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  // var _showFavouriteOnly = false;

  List<Product> _items = [];
  List<Product> get items {
    // if (_showFavouriteOnly) {
    //   return _items.where((prodItem) => prodItem.isFavourite).toList();
    // }
    return [..._items];
  }

  List<Product> get favouriteItem {
    return _items.where((prodItem) => prodItem.isFavourite).toList();
  }

  // void showFavouriteOnly() {
  //   _showFavouriteOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavouriteOnly = false;
  //   notifyListeners();
  // }
  Future<void> fetchAndSetProduct() async {
    const url =
        'https://e-shop-today-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.get(Uri.parse(url));
      // print(json.decode(response.body));
      final ExtractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> LoadedProducts = [];
      ExtractedData.forEach((ProdId, ProdData) {
        LoadedProducts.add(Product(
            id: ProdId,
            title: ProdData['title'],
            Discription: ProdData['discription'],
            imageUrl: ProdData['imageUrl'],
            price: ProdData['price']));
      });
      _items = LoadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Product findByID(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  //using firebase on this method
  Future<void> addProduct(Product product) async {
    const url =
        'https://e-shop-today-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'title': product.title,
            'discription': product.Discription,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavourite,
          }));
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          Discription: product.Discription,
          imageUrl: product.imageUrl,
          price: product.price);
      _items.add(newProduct);

      //_items.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  void UpdateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://e-shop-today-default-rtdb.firebaseio.com/products/$id.json';
      await http.patch(Uri.parse(url),
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.Discription,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else
      print('...');
  }

  void DeleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
