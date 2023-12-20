import 'package:e_shop_today/providers/products.dart';
import 'package:e_shop_today/screens/edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imgUrl;
  UserProductItem(this.id, this.title, this.imgUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title),
        leading: CircleAvatar(backgroundImage: NetworkImage(imgUrl)),
        trailing: Container(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditProductScreen.routeName, arguments: id);
                },
                icon: Icon(Icons.edit),
                color: Colors.purple,
              ),
              IconButton(
                  onPressed: () {
                    Provider.of<Products>(context, listen: false)
                        .DeleteProduct(id);
                  },
                  icon: Icon(Icons.delete),
                  color: Colors.red),
            ],
          ),
        ));
  }
}
