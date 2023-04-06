import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jobfinder/config.dart';

import 'package:jobfinder/models/Auth/Login.dart';
import 'package:jobfinder/provider/UserProvider.dart';

class AuthService{
  final UserProvider _userProvider;
  String apiUrl = Config.apiUrl;

  AuthService(this._userProvider);

  Future<bool> login(BuildContext context, String email, String password) async{
    apiUrl = apiUrl + "/auth/login";
    Response response = await post(
        Uri.parse(apiUrl),
        headers: {
          'Accept' : 'application/json' ,
        },
        body: {
          'email' : email,
          'password' : password
        }
    );

    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      LoginModel user = LoginModel.fromJson(data);
      _userProvider.setAuth(user);

      return true;
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Giriş bilgileri hatalıdır'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          )
      );
      return false;
    }
  }

  Future<bool> register(BuildContext context, String name,String email, String password) async{
    apiUrl = apiUrl + "/auth/register";
    Response response = await post(
        Uri.parse(apiUrl),
        headers: {
          'Accept' : 'application/json' ,
        },
        body: {
          'name' : name,
          'email' : email,
          'password' : password,
          'confirmPassword' : password
        }
    );
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 201){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> logout() async{
    apiUrl = apiUrl + "/auth/logout";

    Response response = await post(Uri.parse(apiUrl));

    if(response.statusCode == 200){
     return true;
    }else{
      return false;
    }
  }
}