import 'package:e_shop_today/Admin/ProductItemsAdmin.dart';
import 'package:e_shop_today/Widgets/product_Item.dart';
import 'package:e_shop_today/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class productGridAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.itemsAdmin;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: products[i], child: ProductItemAdmin()),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
