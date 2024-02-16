import 'package:e_shop_today/Admin/AdminProductView.dart';
import 'package:e_shop_today/Widgets/App_Drawer.dart';
import 'package:e_shop_today/screens/product_overview_screen.dart';
import 'package:flutter/material.dart';

class HomeAdmin extends StatefulWidget {
  static const routeName = '/Admin-Home-Login';
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
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
      drawer: AppDrawer(),
      drawerScrimColor: Colors.white,
      backgroundColor: Color(0xFFededeb),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
        padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color.fromARGB(255, 53, 51, 51), Colors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderRadius: BorderRadius.vertical(
                top: Radius.elliptical(
                    MediaQuery.of(context).size.width, 110.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
                leading: Icon(Icons.production_quantity_limits),
                title: Text('Manage Products'),
                onTap: () {
                  print('Manage Products button pressed');
                }),
            SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Handle 'Manage Accounts' button press
                  print('Manage Accounts button pressed');
                },
                child: Text(
                  'Manage Accounts',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Handle 'Overview' button press
                  print('Overview button pressed');
                },
                child: Text(
                  'Overview',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
