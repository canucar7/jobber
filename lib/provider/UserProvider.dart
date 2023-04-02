import 'package:flutter/cupertino.dart';

import '../models/Auth/Login.dart';

class TokenProvider extends ChangeNotifier {
  LoginModel? _auth;

  LoginModel? get auth => _auth;

  void setAuth(LoginModel value) {
    _auth = value;
    notifyListeners();
  }
}