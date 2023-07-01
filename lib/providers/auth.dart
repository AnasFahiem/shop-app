import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  // String _email;
  // String _password;
  // String _name;
  // String _phone;
  // String _address;
  // String _imageUrl;
  Future<void> _authinticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDzcyU0q9AMetBjr6iZmRpi-uijxCxP6Oo');
    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    print(json.decode(response.body));
    // _token = json.decode(response.body)['idToken'];
    // _userId = json.decode(response.body)['localId'];
    // _expiryDate = DateTime.now().add(
    //   Duration(
    //     seconds: int.parse(
    //       json.decode(response.body)['expiresIn'],
    //     ),
    //   ),
    // );
    // notifyListeners();
  }

  Future<void> signup(
    String email,
    String password,
  ) async {
    return _authinticate(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    return _authinticate(email, password, "signInWithPassword");
  }
}
