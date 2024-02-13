import 'package:e_shop_today/Admin/AdminLogin.dart';
import 'package:e_shop_today/providers/auth.dart';
import 'package:e_shop_today/providers/cart.dart';
import 'package:e_shop_today/providers/orders.dart';
import 'package:e_shop_today/screens/auth_screen.dart';
import 'package:e_shop_today/screens/Cart_Screen.dart';
import 'package:e_shop_today/screens/Orders_Screen.dart';
import 'package:e_shop_today/screens/edit_product_screen.dart';
import 'package:e_shop_today/screens/splash_screen.dart';
import 'package:e_shop_today/screens/users_product_Screen.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/product_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
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
          ChangeNotifierProvider(create: (ctx) => Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: (ctx) => Products('', '', []),
            update: (ctx, auth, previousProductsProviderState) => Products(
                auth.token!,
                auth.userId!,
                previousProductsProviderState!.items),
          ),
          ChangeNotifierProvider.value(
            value: Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            update: (ctx, auth, previousProducts) => Orders(
                auth.token!,
                auth.userId!,
                previousProducts == null ? [] : previousProducts.orders),
            create: (_) => Orders('', '', []),
          )
        ],
        child: Consumer<Auth>(
            builder: (ctx, auth, _) => MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'MyShop',
                    theme: ThemeData(
                      primarySwatch: Colors.purple,
                    ),
                    home: auth.isAuth
                        ? ProductOverviewScreen()
                        : FutureBuilder(
                            future: auth.tryAutoLogin(),
                            builder: (ctx, authresultSnapShot) =>
                                authresultSnapShot.connectionState ==
                                        ConnectionState.waiting
                                    ? SplashScreen()
                                    : AuthScreen()),
                    routes: {
                      ProductDetailScreen.routeName: (ctx) =>
                          ProductDetailScreen(),
                      CartScreen.routeName: (ctx) => CartScreen(),
                      OrderScreen.routeName: (ctx) => OrderScreen(),
                      UserProductsScreen.routeName: (ctx) =>
                          UserProductsScreen(),
                      EditProductScreen.routeName: (ctx) => EditProductScreen(),
                      AdminLogin.routeName: (ctx) => AdminLogin(),
                    })));
  }
}
