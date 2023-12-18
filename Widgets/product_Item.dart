import 'package:e_shop_today/providers/cart.dart';
import 'package:e_shop_today/providers/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                  arguments: product.id);
            },
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: Consumer<Product>(
              builder: (ctx, product, _) => IconButton(
                  onPressed: () {
                    //this will execute that the file is favourite or not
                    product.toggleFavouriteStatus();
                    if (product.isFavourite) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added to favorites'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Removed from favorites'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  icon: Icon(product.isFavourite
                      ? Icons.favorite
                      : Icons.favorite_border),
                  color: Colors.deepOrange),
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
                onPressed: () {
                  cart.addItem(product.id, product.price, product.title);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Added Item to Cart!'),
                      duration: Duration(seconds: 2),
                      action: SnackBarAction(
                        label: 'Undo',
                        textColor: Colors.red,
                        onPressed: () {
                          cart.removeItem(product.id);
                        },
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.shopping_cart),
                color: Colors.deepOrange),
          ),
        ));
  }
}
