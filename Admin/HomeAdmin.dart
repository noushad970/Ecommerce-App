import 'package:e_shop_today/screens/product_overview_screen.dart';
import 'package:flutter/material.dart';

class HomeAdmin extends StatelessWidget {
  const HomeAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the other screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductOverviewScreen()),
            );
          },
          child: Text('Go to Other Screen'),
        ),
      ),
    );
  }
}
