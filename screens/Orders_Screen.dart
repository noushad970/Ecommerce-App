import 'package:e_shop_today/Widgets/App_Drawer.dart';
import 'package:e_shop_today/Widgets/order_Item.dart';
import 'package:e_shop_today/providers/orders.dart' show Orders;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _isLoading = false;
  @override
  void initState() {
    _isLoading = true;

    Provider.of<Orders>(context, listen: false)
        .fetchAndSetOrder()
        .then((_) => setState(() {
              _isLoading = false;
            }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
         backgroundColor: Color.fromARGB(255, 0, 187, 255),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: orderData.orders.length,
              itemBuilder: (ctx, i) => OrderItem(orderData.orders[i])),
    );
  }
}
