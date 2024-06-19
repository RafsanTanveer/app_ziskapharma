import 'package:app_ziskapharma/model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AuthProvider extends ChangeNotifier {
  String user_id = '';
  String user_pass = '';

   UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  setUserId(String uid) {
    user_id = uid;
    notifyListeners();
  }

  setUserPass(String pass) {
    user_pass = pass;
    notifyListeners();
  }


}
