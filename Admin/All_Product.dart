// Your imports here
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product {
  final String id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});
}

class AdminPanelPage extends StatefulWidget {
  static const routeName = '/Admin-All-Products';
  @override
  _AdminPanelPageState createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends State<AdminPanelPage> {
  late List<Product> products;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse(
        'https://e-shop-today-default-rtdb.firebaseio.com/products.json'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List<Product> fetchedProducts = [];

      data.forEach((key, value) {
        fetchedProducts.add(Product(
          id: key,
          name: value['name'],
          price: value['price'],
        ));
      });

      setState(() {
        products = fetchedProducts;
      });
    }
  }

  Future<void> deleteProduct(String id) async {
    final response =
        await http.delete(Uri.parse('YOUR_FIREBASE_URL/products/$id.json'));

    if (response.statusCode == 200) {
      fetchProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name),
            subtitle: Text('\$${products[index].price.toString()}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                deleteProduct(products[index].id);
              },
            ),
          );
        },
      ),
    );
  }
}
