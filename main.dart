import 'package:e_shop_today/providers/auth.dart';
import 'package:e_shop_today/providers/cart.dart';
import 'package:e_shop_today/providers/orders.dart';
import 'package:e_shop_today/screens/264%20auth_screen.dart';
import 'package:e_shop_today/screens/Cart_Screen.dart';
import 'package:e_shop_today/screens/Orders_Screen.dart';
import 'package:e_shop_today/screens/edit_product_screen.dart';
import 'package:e_shop_today/screens/users_product_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/product_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProvider.value(
            value: Products(),
          ),
          ChangeNotifierProvider.value(
            value: Cart(),
          ),
          ChangeNotifierProvider.value(
            value: Orders(),
          )
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MyShop',
            theme: ThemeData(
              primarySwatch: Colors.purple,
            ),
            home: AuthScreen(),
            routes: {
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrderScreen.routeName: (ctx) => OrderScreen(),
              UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
            }));
  }
}
