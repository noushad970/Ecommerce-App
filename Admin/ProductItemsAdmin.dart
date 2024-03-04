import 'package:e_shop_today/Admin/ProductDetailScreenAdmin.dart';
import 'package:e_shop_today/providers/AdminProduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItemAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<AdminProduct>(context, listen: false);
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                    AdminProductDetailScreen.routeName,
                    arguments: product.id);
              },
              child: Container(
                  width: 150,
                  height: 150,
                  margin: EdgeInsets.only(top: 8, right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                  ),
                  child: FittedBox(
                    child: Image.network(product.imageUrl),
                  ))),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }
}
