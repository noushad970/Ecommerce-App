import 'package:e_shop_today/Widgets/App_Drawer.dart';
import 'package:e_shop_today/providers/cart.dart';
import 'package:e_shop_today/providers/product.dart';
import 'package:e_shop_today/screens/Cart_Screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../Widgets/product_grid.dart';
import '../providers/products.dart';
//import '../Widgets/badge.dart';

enum FilterOptions {
  Favourite,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  static const routeName = '/product-overview-screen';
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showOnlyFavourite = false;
  var _isInit = true;
  var _isLoading = false;
  @override
  void initState() {
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProduct();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProduct().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

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
                    _showOnlyFavourite = true;
                  } else {
                    //  productContainer.showAll();
                    _showOnlyFavourite = false;
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
                alignment: Alignment.center,
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
          ],
          title: Text('MyShop'),
          backgroundColor: Color.fromARGB(255, 0, 187, 255),
        ),
        drawer: AppDrawer(),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : productGrid(_showOnlyFavourite));
  }
}
