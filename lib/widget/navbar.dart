/*
  Authors : flutter_ninja (Flutter Ninja)
  Website : https://codecanyon.net/user/flutter_ninja/
  App Name : JobFinder Flutter Template
  This App Template Source code is licensed as per the
  terms found in the Website https://codecanyon.net/licenses/standard/
  Copyright and Good Faith Purchasers © 2022-present flutter_ninja.
*/
import 'package:flutter/material.dart';
import 'package:jobfinder/pages/applied_jobs.dart';
import 'package:jobfinder/pages/bookmark.dart';
import 'package:jobfinder/pages/categories.dart';
import 'package:jobfinder/pages/company.dart';
import 'package:jobfinder/pages/inbox.dart';
import 'package:jobfinder/pages/invite_friend.dart';
import 'package:jobfinder/pages/notification.dart';
import 'package:jobfinder/pages/profile.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              'Admin',
              style: TextStyle(color: Colors.white),
            ),
            accountEmail: const Text(
              'admin@flutter_ninja.com',
              style: TextStyle(color: Colors.white),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/s3.jpg',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('View Profile'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Profile()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categories'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Categories()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text('Bookmark'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Bookmark()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.done_all),
            title: const Text('Applied Jobs'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AppliedJobs()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.computer),
            title: const Text('Companies'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Company()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.inbox),
            title: const Text('Inbox'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Inbox()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory_outlined),
            title: const Text('Invite Friend'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InviteFriend()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notification'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationScreen()));
            },
          ),
        ],
      ),
    );
  }
}
