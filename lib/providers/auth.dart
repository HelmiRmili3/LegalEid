//import 'dart:convert';
import 'dart:convert';

import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  // final String _token = '';
  // final String _userId = '';
  // final DateTime _expiryDate = DateTime.now();

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    // final url = Uri.parse(
    //     'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAeBWWDd3Ei8qu8Rj17vkRv7w24zuRnfGg');
    final url = Uri.parse(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/$urlSegment?key=AIzaSyAeBWWDd3Ei8qu8Rj17vkRv7w24zuRnfGg');
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
    if (kDebugMode) {
      print(json.decode(response.body));
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
