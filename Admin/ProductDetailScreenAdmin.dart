import 'package:e_shop_today/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminProductDetailScreen extends StatelessWidget {
 
  
  static const routeName = '/admin-product-detail';

  @override
  Widget build(BuildContext context) {
    final productID = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findByID(productID);
    return Scaffold(
        appBar: AppBar(
          title: Text(loadedProduct.title),
          backgroundColor: Color.fromARGB(255, 0, 187, 255),
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Container(
              width: 300,
              height: 150,
              margin: EdgeInsets.only(top: 8, right: 10),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
              ),
              child: FittedBox(
                child: Image.network(loadedProduct.imageUrl),
              )),
          SizedBox(
            height: 10,
          ),
          Text(
            '\$${loadedProduct.price}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedProduct.Discription,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
                softWrap: true,
              )),
          SizedBox(
            height: 10,
          ),
          Container(
              width: 50,
              height: 50,
              child: FittedBox(
                child: IconButton(
                    onPressed: () {
                      Provider.of<Products>(context, listen: false)
                          .DeleteProduct(loadedProduct.id);
                      Provider.of<Products>(context, listen: false)
                          .AdminfetchAndSetProduct(true);
                    },
                    icon: Icon(Icons.delete)),
              )),
        ])));
  }
}
