import 'package:e_shop_today/providers/cart.dart';
import 'package:e_shop_today/providers/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widgets/product_grid.dart';
import '../providers/products.dart';
//import '../Widgets/badge.dart';

enum FilterOptions {
  Favourite,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool showOnlyFavourite = false;
  @override
  Widget build(BuildContext context) {
    //  final productContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (FilterOptions SelectedValue) {
                // print(SelectedValue);
                setState(() {
                  if (SelectedValue == FilterOptions.Favourite) {
                    // productContainer.showFavouriteOnly();
                    showOnlyFavourite = true;
                  } else {
                    //  productContainer.showAll();
                    showOnlyFavourite = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text('Only Favourite'),
                  value: FilterOptions.Favourite,
                ),
                PopupMenuItem(
                  child: Text('Show All'),
                  value: FilterOptions.All,
                ),
              ],
            ),
            Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                child: ch,
                //problem of value parameter
                label: Text(cart.itemCount.toString()),
              ),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
            ),
          ],
          title: Text('MyShop'),
        ),
        body: productGrid(showOnlyFavourite));
  }
}
