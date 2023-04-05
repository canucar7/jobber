import 'package:flutter/material.dart';
import 'package:jobfinder/components/styles.dart';

class UserProfileHeader extends StatefulWidget {
  const UserProfileHeader({Key? key}) : super(key: key);

  @override
  State<UserProfileHeader> createState() => _UserProfileHeaderState();
}

class _UserProfileHeaderState extends State<UserProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[appColor2, appColor]),
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.menu, color: Colors.white)),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Profile',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'medium',
                          fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 40)
              ],
            ),
            const CircleAvatar(
              backgroundImage: null,
              radius: 40,
            ),
            const SizedBox(height: 8),
            const Text(
              'Admin',
              style: TextStyle(
                  fontSize: 18, fontFamily: 'medium', color: Colors.white),
            ),
            const SizedBox(height: 8),
            const Text(
              'admin@hotmail.com',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            const SizedBox(height: 10),
            /*
            SizedBox(
              width: 120,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      primary: backgroundColor,
                      shadowColor: Colors.black38,
                      onPrimary: Colors.black,
                      elevation: 0,
                      shape: (RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      )),
                      padding: const EdgeInsets.all(0)),
                  child: greyTextSmall('My Resume'.toUpperCase())),
            ),*/
          ],
        ));
  }
}
