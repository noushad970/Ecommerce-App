import 'package:e_shop_today/providers/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widgets/product_grid.dart';

enum FilterOptions {
  Favourite,
  All,
}

class ProductOverviewScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final productContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            PopupMenuButton(
                onSelected: (FilterOptions SelectedValue) {
                  // print(SelectedValue);
                  if (SelectedValue == FilterOptions.Favourite) {
                  } else {}
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
                    ])
          ],
          title: Text('MyShop'),
        ),
        body: productGrid());
  }
}
