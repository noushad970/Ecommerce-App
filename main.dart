import 'package:flutter/material.dart';
import './screens/product_overview_screen.dart';
import './screens/product_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: ProductOverviewScreens(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        });
  }
}
