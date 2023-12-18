import 'package:e_shop_today/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime datetime;
  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.datetime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    orders.insert(
      0,
      OrderItem(
          id: DateTime.now().toString(),
          datetime: DateTime.now(),
          amount: total,
          products: cartProducts),
    );
    notifyListeners();
  }
  /*
  void addOrder(List<CartItem> cartProducts, double total) {
  orders.add(
    OrderItem(
      id: DateTime.now().toString(),
      datetime: DateTime.now(),
      amount: total,
      products: cartProducts,
    ),
  );
  notifyListeners();
}
  */
}
