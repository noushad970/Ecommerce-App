/*import 'package:e_shop_today/screens/product_overview_screen.dart';
import 'package:flutter/material.dart';

class HomeAdmin extends StatelessWidget {
  static const routeName = '/Admin-Home-Login';
  const HomeAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Panel',
      debugShowCheckedModeBanner: false,
      home: AdminPanelPage(),
    );
  }
}

class AdminPanelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Admin Panel",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 56, 53, 53),
        ),
        backgroundColor: Color(0xFFededeb),
        body: Column(children: [
          Container(
            child: ElevatedButton(
              onPressed: () {
                // Add functionality for navigating to the home page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductOverviewScreen()),
                );
              },
              child: Text('Go to Home Page'),
            ),
          ),
        ]));
  }
}
*/