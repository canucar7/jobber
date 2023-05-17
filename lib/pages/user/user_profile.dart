import 'package:flutter/material.dart';
import 'package:jobfinder/components/styles.dart';
import 'package:jobfinder/models/User/UserProfile.dart';
import 'package:jobfinder/provider/UserProvider.dart';
import 'package:jobfinder/services/User/UserProfileService.dart';
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
      body: _buildBody(),
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
                  "name",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'medium',
                      fontSize: 20),
                ),
                const SizedBox(height: 8),
                Text(
                  'Mail',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                const SizedBox(height: 10),
              ],
            )),
          const SizedBox(height: 8),

          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    blackHeadingSmall('addresses'.toUpperCase()),
                  ],
                ),
              ),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
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
                    children: [
                      Text("data"),
                      const SizedBox(height: 10),
                    ],
                  )),

            ],

          ),

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
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
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
                    children: [
                      Text("data"),
                      const SizedBox(height: 10),
                    ],
                  )),
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
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
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
                    children: [
                      Text("data"),
                      const SizedBox(height: 10),
                    ],
                  )),

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
                    blackHeadingSmall('advertisements'.toUpperCase()),
                  ],
                ),
              ),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
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
                    children: [
                      Text("data"),
                      const SizedBox(height: 10),
                    ],
                  )),

            ],

          ),
        ],
      ),
    );

  }


}
