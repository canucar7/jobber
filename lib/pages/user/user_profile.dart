import 'package:flutter/material.dart';
import 'package:jobfinder/components/styles.dart';
import 'package:jobfinder/models/CompanyInformation.dart';
import 'package:jobfinder/models/User/UserProfile.dart';
import 'package:jobfinder/pages/company_detail.dart';
import 'package:jobfinder/provider/UserProvider.dart';
import 'package:jobfinder/services/User/UserProfileService.dart';
import 'package:jobfinder/widget/elevated_button.dart';
import 'package:jobfinder/widget/navbar.dart';
import 'package:provider/provider.dart';


class UserProfiles extends StatefulWidget {
  final int profileId;
  const UserProfiles({Key? key,required this.profileId}) : super(key: key);

  @override
  State<UserProfiles> createState() => _UserProfilesState();
}

class _UserProfilesState extends State<UserProfiles> {
  late String _authToken;
  late int _userId;

  late UserProfileService _userProfileService;

  late UserProfile? profile = null;

  @override
  void initState() {
    super.initState();
    _authToken = context.read<UserProvider>().auth!.accessToken;
    _userId = context.read<UserProvider>().auth!.user.id;
    _userProfileService = UserProfileService(_authToken, _userId);
    getProfileDetails();
  }

  void getProfileDetails() async {
    UserProfile fetchCompany = await _userProfileService.show(widget.profileId);
    setState(() {
      profile = fetchCompany;
    });
  }

  Widget buildCompany() {
    return Column(
      children: profile!.companies.map((e) => Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 20.0,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    e != null ? Icons.maps_home_work_outlined  : Icons.person,
                    size: 30,
                    color: appColor,
                  ),),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      blackHeadingSmall(e != null ? e.name : e.toString()),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: greyTextSmall(
                  e.description + '\n\n' + e.phoneNumber.toString()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                boldText(''),
                MyElevatedButton(
                    onPressed: ()  {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CompanyDetail(companyId: e.id)));
                    },
                    text: btnText('See Details'),
                    height: 28,
                    width: 100)
              ],
            ),
          ],
        ),
      ),).toList(),
    );
  }

  Widget buildLanguage() {
    return Column(
      children: profile!.foreignLanguages.map((e) => Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 20.0,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    e != null ? Icons.language  : Icons.person,
                    size: 30,
                    color: appColor,
                  ),),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      blackHeadingSmall(e != null ? e.languageName : e.toString()),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: greyTextSmall(
                  e.languageLevel),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget buildCertificate() {
    return Column(
      children: profile!.certificates.map((e) => Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 20.0,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    e != null ? Icons.description  : Icons.person,
                    size: 30,
                    color: appColor,
                  ),),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      blackHeadingSmall(e != null ? e.name : e.toString()),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: greyTextSmall(
                  e.institution + '\n\n' + e.issueDate.toString().split(" ").first.toString()),
            ),
          ],
        ),
      )).toList(),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Profile'),
        centerTitle: true,
        titleSpacing: 0,
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
      body: profile==null ? Center(child: CircularProgressIndicator()) :_buildBody() ,
    );
  }



  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 100),
      child: Column(
        children: [
          Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[appColor2, appColor]),
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 16),
                SizedBox(height: 8,),
                const CircleAvatar(
                  backgroundImage: null,
                  radius: 40,
                ),

                const SizedBox(height: 8),
                Text(
                  profile!.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'medium',
                      fontSize: 20),
                ),
                const SizedBox(height: 8),
                Text(
                  profile!.email,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                const SizedBox(height: 10),
              ],
            )),
          const SizedBox(height: 8),


          const SizedBox(height: 8),

          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    blackHeadingSmall('company'.toUpperCase()),
                  ],
                ),
              ),
              Column(
                children: [
                  buildCompany(),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),

          SizedBox(height: 8,),

          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    blackHeadingSmall('foreign languages'.toUpperCase()),
                  ],
                ),
              ),
              Column(
                children: [
                  buildLanguage(),
                  const SizedBox(height: 10),
                ],
              ),

            ],

          ),

          SizedBox(height: 8,),

          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    blackHeadingSmall('Certificates'.toUpperCase()),
                  ],
                ),
              ),
              Column(
                children: [
                  buildCertificate(),
                  const SizedBox(height: 10),
                ],
              ),

            ],

          ),
        ],
      ),
    );

  }


}
