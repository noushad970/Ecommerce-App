import 'package:e_shop_today/providers/cart.dart';
import 'package:e_shop_today/providers/orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widgets/Cart_Item.dart' as ci;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('MyCart'),
        ),
        body: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    SizedBox(
                      width: 10,
                    ),
                    Chip(
                      // label: Text('\$' + cart.totalAmount.toString()),
                      label: Text('\$${cart.totalAmount.toStringAsFixed(2)}'),
                    ),
                    ElevatedButton(
                        child: Text('Order Now'),
                        onPressed: () {
                          Provider.of<Orders>(context, listen: false).addOrder(
                              cart.items.values.toList(), cart.totalAmount);
                          cart.clear();
                        })
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (ctx, i) => ci.CartItem(
                  cart.items.values.toList()[i].id,
                  cart.items.values.toList()[i].title,
                  cart.items.values.toList()[i].quantity,
                  cart.items.values.toList()[i].price,
                  cart.items.keys.toList()[i]),
              itemCount: cart.items.length,
            ))
          ],
        ));
  }
}
