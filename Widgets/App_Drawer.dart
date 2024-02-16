import 'package:e_shop_today/Admin/AdminLogin.dart';
import 'package:e_shop_today/providers/auth.dart';
import 'package:e_shop_today/screens/Orders_Screen.dart';
import 'package:e_shop_today/screens/auth_screen.dart';
import 'package:e_shop_today/screens/users_product_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Friends!'),
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromARGB(255, 0, 234, 255),
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.shop),
              title: Text('Shop'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.payment),
              title: Text('Orders'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(OrderScreen.routeName);
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.admin_panel_settings),
              title: Text('Admin Panel'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(AdminLogin.routeName);
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.edit),
              title: Text('Manage Products'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(UserProductsScreen.routeName);
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                Navigator.of(context).pop();
                Provider.of<Auth>(context, listen: false).logout();

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AuthScreen()));
              }),
        ],
      ),
    );
  }
}
