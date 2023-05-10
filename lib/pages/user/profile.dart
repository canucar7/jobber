import 'package:flutter/material.dart';
import 'package:jobfinder/components/user/profile/user_addresses.dart';
import 'package:jobfinder/components/user/profile/user_certificates.dart';
import 'package:jobfinder/components/user/profile/user_companies.dart';
import 'package:jobfinder/components/user/profile/user_educations.dart';
import 'package:jobfinder/components/user/profile/user_experiences.dart';
import 'package:jobfinder/components/user/profile/user_foreign_languages.dart';
import 'package:jobfinder/components/user/profile/user_informations.dart';
import 'package:jobfinder/components/user/profile/user_profile_header.dart';
import 'package:jobfinder/components/user/profile/user_resume.dart';
import 'package:jobfinder/components/user/profile/user_skills.dart';
import 'package:jobfinder/models/Auth/Login.dart';
import 'package:jobfinder/provider/UserProvider.dart';
import 'package:jobfinder/widget/navbar.dart';
import 'package:provider/provider.dart';
import 'package:jobfinder/components/styles.dart';

class Profile extends StatefulWidget {
  static const String id = 'Profile';

  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            UserProfileHeader(),
            const SizedBox(height: 8),
            UserInformations(),
            UserAddresses(),
            UserCompanies(),
            UserExperiences(),
            UserEducations(),
            UserSkills(),
            UserCertificates(),
            UserForeignLanguages(),
            UserResume(),
            const SizedBox(height: 20)
          ],
    ));
  }
}
