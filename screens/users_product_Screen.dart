import 'package:e_shop_today/Widgets/App_Drawer.dart';
import 'package:e_shop_today/Widgets/User_product_items.dart';
import 'package:e_shop_today/providers/products.dart';
import 'package:e_shop_today/screens/edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProduct();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Products'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProductScreen.routeName);
                },
                icon: Icon(Icons.add))
          ],
        ),
        drawer: AppDrawer(),
        body: RefreshIndicator(
          onRefresh: () => _refreshProduct(context),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListView.builder(
              itemBuilder: (_, i) => Column(
                children: [
                  UserProductItem(
                    productData.items[i].id,
                    productData.items[i].title,
                    productData.items[i].imageUrl,
                  ),
                  Divider()
                ],
              ),
              itemCount: productData.items.length,
            ),
          ),
        ));
  }
}
