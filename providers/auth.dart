import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  late String _userId;
  late String _token;
  late DateTime _expiryDate;
  //Auth(this._userId, this._token, this._expiryDate);
  Future<void> authenticate(
      String email, String password, String urlsegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlsegment?key=AIzaSyAP_5R83H1_alNmf5dKxpXqiKn_PB1q7F8';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
    } catch (error) {
      throw error;
    }
    // print(json.decode(response.body));
  }

  Future<void> singup(String email, String password) async {
    return authenticate(email, password, 'signUp');
  }

  Future<void> singin(String email, String password) async {
    return authenticate(email, password, 'signInWithPassword');
  }
}
