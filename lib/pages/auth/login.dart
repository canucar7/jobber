import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jobfinder/pages/auth/forgot_password.dart';
import 'package:jobfinder/pages/home.dart';
import 'package:jobfinder/pages/auth/register.dart';
import 'package:jobfinder/provider/UserProvider.dart';
import 'package:jobfinder/services/Auth/AuthService.dart';
import 'package:jobfinder/widget/elevated_button.dart';
import 'package:jobfinder/widget/text_btn.dart';
import 'package:provider/provider.dart';
import '../../components/styles.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

class Login extends StatefulWidget {
  static const String id = 'Login';

  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    passwordVisible=true;
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  bool _isLoading = false;

  bool passwordVisible=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(),
      appBar: _buildAppBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(200),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        flexibleSpace: _buildHeader(),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: _isLoading ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(child: _buildLoginDetail()),
    );
  }

  Widget _buildHeader() {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            appColor,
            appColor2,
          ],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logoImg(),
            const Text(
              'Welcome Back!',
              style: TextStyle(
                  color: Colors.white, fontSize: 26, fontFamily: 'medium'),
            ),
          ],
        ));
  }

  Widget _buildLoginDetail() {
    AuthService _authService = AuthService(context.read<UserProvider>());
    return Center(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20.0,
              )
            ]),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email Adrdress',
                      suffixIcon: Icon(
                        Icons.mail_outline,
                        size: 20,
                        color: Colors.blueGrey,
                      ),
                      labelStyle: const TextStyle(color: Colors.black54, fontSize: 12),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: appColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    controller: passwordController,
                    obscureText: passwordVisible,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(
                                () {
                              passwordVisible = !passwordVisible;
                            },
                          );
                        },
                      ),
                      labelStyle: const TextStyle(color: Colors.black54, fontSize: 12),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: appColor),
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,

                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MyTextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPassword()));
                          },
                          text: 'Forgot Password',
                          colors: appColor),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            MyElevatedButton(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                  });
                  _authService.login(context, emailController.text.toString(), passwordController.text.toString()).then((value) {
                    setState(() {
                      _isLoading = false;
                    });
                    if (value) {
                      return Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
                    }
                  });
                },
                text: const Icon(Icons.arrow_forward),
                height: 40,
                width: 40),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      blackText("Don't have an account?"),
                      MyTextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Register()));
                          },
                          colors: appColor,
                          text: "Sign up")
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget _buildBottomNavigationBar() {
  //   return ;
  // }

  imageButton(image, name, color) {
    return Container(
        width: double.infinity,
        height: 46,
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  name,
                  style: const TextStyle(
                      fontFamily: 'medium', fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Image.asset(
                image,
                width: 24,
                height: 24,
              ),
            ),
          ],
        ));
  }

  logoImg() {
    return Image.asset(
      'assets/images/job.png',
      color: Colors.white,
      width: 120,
      height: 100,
    );
  }


  }

