
import 'package:flutter/material.dart';
import 'package:jobfinder/pages/auth/login.dart';
import 'package:jobfinder/pages/slider.dart';
import 'package:jobfinder/provider/UserProvider.dart';
import 'package:provider/provider.dart';
import '../components/styles.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JobFinder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "regular",
        primaryColor: appColor,
        backgroundColor: appColor,
        dividerColor: Colors.transparent,
      ),
      initialRoute: SliderScreen.id,
      routes: {
        SliderScreen.id: (context) => const Login(),
      },
    );
  }
}
