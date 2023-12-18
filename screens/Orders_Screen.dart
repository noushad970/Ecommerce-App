import 'package:e_shop_today/Widgets/App_Drawer.dart';
import 'package:e_shop_today/Widgets/order_Item.dart';
import 'package:e_shop_today/providers/orders.dart' show Orders;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (ctx, i) => OrderItem(orderData.orders[i])),
    );
  }
}
