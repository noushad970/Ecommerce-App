import 'package:e_shop_today/providers/cart.dart';
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
                      label: Text('\$${cart.totalAmount}'),
                    ),
                    ElevatedButton(onPressed: () {}, child: Text('Order Now'))
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
                  cart.item.values.toList()[i].id,
                  cart.item.values.toList()[i].title,
                  cart.item.values.toList()[i].quantity,
                  cart.item.values.toList()[i].price,
                  cart.item.keys.toList()[i]),
              itemCount: cart.item.length,
            ))
          ],
        ));
  }
}
