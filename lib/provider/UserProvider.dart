import 'package:flutter/cupertino.dart';

import '../models/Auth/Login.dart';
import '../models/User/UserAddress.dart';

class UserProvider extends ChangeNotifier {
  LoginModel? _auth;
  UserAddress? _address;

  LoginModel? get auth => _auth;
  UserAddress? get address => _address;

  void setAuth(LoginModel value) {
    _auth = value;
    notifyListeners();
  }

  void setAddress(UserAddress value) {
    _address = value;
    notifyListeners();
  }
}