import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jobfinder/pages/home.dart';
import 'package:jobfinder/pages/auth/login.dart';
import 'package:jobfinder/provider/UserProvider.dart';
import 'package:jobfinder/widget/elevated_button.dart';
import 'package:jobfinder/widget/text_btn.dart';
import 'package:provider/provider.dart';
import '../../components/styles.dart';
import 'package:http/http.dart';
import 'package:jobfinder/services/Auth/AuthService.dart';

class Register extends StatefulWidget {
  static const String id = 'Register';

  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool passwordVisible=false;

  @override
  void initState() {
    super.initState();
    passwordVisible=true;
  }

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
      child: SingleChildScrollView(child: _buildLoginDetail()),
    );
  }

  Widget _buildHeader() {
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.35,
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
              'Welcome to Jobber',
              style: TextStyle(
                  color: Colors.white, fontSize: 26, fontFamily: 'medium'),
            ),
          ],
        ));
  }

  Widget _buildLoginDetail() {
    AuthService _authService = AuthService(context.read<UserProvider>());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    suffixIcon: Icon(
                      Icons.person,
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const Login()));
                        },
                        text: 'Already have an account?',
                        colors: appColor),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          MyElevatedButton(
              onPressed: () {
                _authService.register(context, nameController.text.toString(),emailController.text.toString(), passwordController.text.toString()).then((value) {
                  if(value){
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Successfully registered. Please login.'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 5),
                        )
                    );
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Failed to register.'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        )
                    );
                  }
                });
              },
              text: const Icon(Icons.arrow_forward),
              height: 40,
              width: 40),
          Container(
            padding: const EdgeInsets.all(24),
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }

  imageButton(image, name, color) {
    return Container(
        width: double.infinity,
        height: 46,
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        margin: const EdgeInsets.symmetric(vertical: 8),
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
