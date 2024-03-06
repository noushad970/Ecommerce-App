import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserListScreenAdmin extends StatefulWidget {
  static const routeName = '/admin-account-screen';
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreenAdmin> {
  List<String> authenticationIds = [];

  Future<void> fetchAuthenticationIds() async {
    final url = 'https://e-shop-today-default-rtdb.firebaseio.com/';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        authenticationIds = List<String>.from(data);
      });
    } else {
      // Handle errors
      print('Failed to fetch authentication IDs');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAuthenticationIds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication IDs'),
      ),
      body: ListView.builder(
        itemCount: authenticationIds.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(authenticationIds[index]),
          );
        },
      ),
    );
  }
}
