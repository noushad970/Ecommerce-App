import 'package:flutter/material.dart';
import '../Widgets/product_grid.dart';

class ProductOverviewScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MyShop'),
        ),
        body: productGrid());
  }
}
