import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
//login system user
class Auth with ChangeNotifier {
  String? _userId;
  String? _token;
  DateTime? _expiryDate;
  Timer? _authTimer;
  bool get isAuth {
    return _token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

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
      //print(json.decode(response.body));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate?.toIso8601String()
      });
      prefs.setString('userData', userData);
    } catch (error) {
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }

  Future<void> singup(String email, String password) async {
    print('signUp');
    return authenticate(email, password, 'signUp');
  }

  Future<void> singin(String email, String password) async {
    print('signIn');
    return authenticate(email, password, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) return false;
    final extractedUserData = json.decode(prefs.getString('userData') as String)
        as Map<String, Object>;
    final expiryDate =
        DateTime.parse(extractedUserData['expiryDate'] as String);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _userId = extractedUserData['userId'] as String?;
    _token = extractedUserData['token'] as String?;
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    // _userId = null;
    // _token = null;
    // _expiryDate = null;

    if (_authTimer != null) {
      _authTimer?.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer?.cancel();
    }
    final timeToExpire = _expiryDate?.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpire!), logout);
  }
}
