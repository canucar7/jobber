import 'package:flutter/material.dart';
import 'package:jobfinder/components/styles.dart';
import 'package:jobfinder/components/user/profile/user_addresses.dart';
import 'package:jobfinder/components/user/profile/user_first_address.dart';
import 'package:jobfinder/models/Auth/Login.dart';
import 'package:jobfinder/provider/UserProvider.dart';
import 'package:jobfinder/widget/navbar.dart';
import 'package:provider/provider.dart';

class AddAddress extends StatefulWidget {
  static const String id = 'AddAddress';

  const AddAddress({Key? key}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}


class _AddAddressState extends State<AddAddress> {
  LoginModel? user;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = Provider.of<UserProvider>(context).auth;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavBar(),
        extendBodyBehindAppBar: true,
        backgroundColor: backgroundColor,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   iconTheme: const IconThemeData(color: Colors.white),
        //   title: const Text('Profile'),
        //   centerTitle: true,
        //   elevation: 0,
        // ),
        body: UserFirstAddresses());
  }

}
