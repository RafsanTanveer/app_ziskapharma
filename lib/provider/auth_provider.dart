import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String user_id = '';
  String user_pass = '';

  setUserId(String uid) {
    user_id = uid;
    notifyListeners();
  }

  setUserPass(String pass) {
    user_pass = pass;
    notifyListeners();
  }

}
