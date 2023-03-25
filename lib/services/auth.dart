import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jobfinder/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AuthService{

  signIn(String email, password) async{

    try{

      Response response = await post(
          Uri.parse("https://compassionate-mahavira.213-142-157-85.plesk.page/api/v1/auth/login"),
          body: {
            'email' : email,
            'password' : password
          }
      );

      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data);
        print("account login successfully");
      }else{
        print("failed");
      }
    }catch(e){
      print(e.toString());
    }
  }

  void register(String name,String email, String password) async{

    try{

      Response response = await post(
          Uri.parse("https://compassionate-mahavira.213-142-157-85.plesk.page/api/v1/auth/register"),
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


      if(response.statusCode == 201){
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print("account created successfully");

      }else{
        print(response.body);
        print("failed");
      }
    }catch(e){
      print(e.toString());
    }
  }



/*
  signOut() async {
    return await _auth.signOut();
  }

  Future<User?> createPerson(String username, String email, String password) async {
    var user = await _auth.createUserWithEmailAndPassword(email: email, password: password);

    await _firesotre
        .collection("Person")
    .doc(user.user?.uid)
    .set({
      'userName' : username,
      'email' : email
    });

    return user.user;
  }
  */
}