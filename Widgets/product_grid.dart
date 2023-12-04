import 'package:e_shop_today/Widgets/product_Item.dart';
import 'package:e_shop_today/providers/product.dart';
import 'package:e_shop_today/providers/products.dart';
import 'package:flutter/material.dart';
import '../screens/product_overview_screen.dart';
import 'package:provider/provider.dart';

class productGrid extends StatelessWidget {
  final bool showFavs;
  productGrid(this.showFavs);
  // const productGrid({
  //   required Key key,
  //   required this.loadedProduct,
  // }) : super(key: key);
  // final List<Product> loadedProduct;

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFavs ? productsData.favouriteItem : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          //create: (c) => products[i],
          value: products[i],
          child: ProductItem(
              // ImgURL: products[i].imageUrl,
              // id: products[i].id,
              // title: products[i].title,
              )),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
