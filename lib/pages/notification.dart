/*
  Authors : flutter_ninja (Flutter Ninja)
  Website : https://codecanyon.net/user/flutter_ninja/
  App Name : JobFinder Flutter Template
  This App Template Source code is licensed as per the
  terms found in the Website https://codecanyon.net/licenses/standard/
  Copyright and Good Faith Purchasers © 2022-present flutter_ninja.
*/
import 'package:flutter/material.dart';
import 'package:jobfinder/widget/navbar.dart';
import '../components/styles.dart';

class NotificationScreen extends StatefulWidget {
  static const String id = 'NotificationScreen';

  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Notifications'),
          centerTitle: true,
          titleSpacing: 0,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[appColor2, appColor]),
            ),
          ),
          elevation: 0,
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 20,
        itemBuilder: (context, i) => Column(
          children: [
            ListTile(
              onTap: () {},
              leading: const CircleAvatar(
                  backgroundColor: backgroundColor,
                  child: Icon(Icons.notifications_outlined,
                      size: 18, color: appColor),
                  radius: 16),
              minLeadingWidth: 0,
              title: Container(
                padding: const EdgeInsets.only(bottom: 6),
                child: boldText('Grow Next Level Business'),
              ),
              subtitle: greyTextSmall(
                  'Hey this is test Notification which allow this archived profetional...'),
              trailing: greyTextSmall('5:42 pm'),
            ),
            const Divider(thickness: 1, color: backgroundColor)
          ],
        ),
      ),
    );
  }
}
