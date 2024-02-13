import 'dart:convert';
import 'package:flutter/material.dart';
import 'product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  // var _showFavouriteOnly = false;

  List<Product> _items = [];
  List<Product> get items {
    return [..._items];
  }

  List<Product> get favouriteItem {
    return _items.where((prodItem) => prodItem.isFavourite).toList();
  }

  final String authToken;
  final String userId;
  Products(this.authToken, this.userId, this._items);

  Future<void> fetchAndSetProduct([bool filterByUser = false]) async {
    String filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        'https://e-shop-today-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filterString';
    try {
      final response = await http.get(Uri.parse(url));
      // print(json.decode(response.body));
      final ExtractedData = json.decode(response.body) as Map<String, dynamic>;
      if (ExtractedData == null) {
        return;
      }
      url =
          'https://e-shop-today-default-rtdb.firebaseio.com/userFavourite/$userId.json?auth=$authToken';
      final favouriteResponse = await http.get(Uri.parse(url));
      final favouriteData = json.decode(favouriteResponse.body);
      final List<Product> LoadedProducts = [];
      ExtractedData.forEach((ProdId, ProdData) {
        LoadedProducts.add(Product(
          id: ProdId,
          title: ProdData['title'],
          Discription: ProdData['discription'],
          imageUrl: ProdData['imageUrl'],
          isFavourite:
              favouriteData == null ? false : favouriteData[ProdId] ?? false,
          price: ProdData['price'],
        ));
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
    final url =
        'https://e-shop-today-default-rtdb.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'title': product.title,
            'discription': product.Discription,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'creatorId': userId,
          }));
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        Discription: product.Discription,
        imageUrl: product.imageUrl,
        price: product.price,
      );

      _items.insert(0, newProduct);

      //_items.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
    notifyListeners();
  }

  Future<void> UpdateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://e-shop-today-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
      await http.patch(Uri.parse(url),
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.Discription,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
            //  'isFavorite': newProduct.isFavourite
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else
      print('...');
  }

  void DeleteProduct(String id) {
    final url =
        'https://e-shop-today-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    Product? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    http.delete(Uri.parse(url)).then((_) {
      existingProduct = null;
    }).catchError((_) {
      _items.insert(existingProductIndex, existingProduct!);
    });
    notifyListeners();
  }
}
