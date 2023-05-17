import 'package:flutter/material.dart';
import 'package:jobfinder/pages/address_add.dart';
import 'package:jobfinder/pages/applied_jobs.dart';
import 'package:jobfinder/pages/bookmark.dart';
import 'package:jobfinder/pages/categories.dart';
import 'package:jobfinder/pages/company.dart';
import 'package:jobfinder/pages/home.dart';
import 'package:jobfinder/pages/inbox.dart';
import 'package:jobfinder/pages/invite_friend.dart';
import 'package:jobfinder/pages/auth/login.dart';
import 'package:jobfinder/pages/notification.dart';
import 'package:jobfinder/pages/post/create_post.dart';
import 'package:jobfinder/pages/post/my_posts.dart';
import 'package:jobfinder/pages/user/profile.dart';
import 'package:jobfinder/provider/UserProvider.dart';

import 'package:jobfinder/services/Auth/AuthService.dart';
import 'package:provider/provider.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final provider = context.read<UserProvider>();
    AuthService _authService = AuthService(provider);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              provider.auth!.user.name,
              style: TextStyle(color: Colors.white),
            ),
            accountEmail: Text(
              provider.auth!.user.email,
              style: TextStyle(color: Colors.white),
            ),
            currentAccountPicture: const Text(
                'Jobber',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home Page'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
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
            leading: const Icon(Icons.maps_home_work_outlined),
            title: const Text('Companies'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Companies()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.create),
            title: const Text('Create Post'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CreatePost()));
            },
          ),
          /*ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Add Address'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddAddress()));
            },
          ),*/
          ListTile(
            leading: const Icon(Icons.done_all),
            title: const Text('My Posts'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyJobs()));
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
            leading: const Icon(Icons.inbox),
            title: const Text('Inbox'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Inbox()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('View Profile'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Profile()));
            },
          ),
          /*ListTile(
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
          ),*/
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
            onTap: () {
              _authService.logout();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Login()));
            },
          ),
        ],
      ),
    );
  }
}
