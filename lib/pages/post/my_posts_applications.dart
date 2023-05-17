import 'package:flutter/material.dart';
import 'package:jobfinder/models/Advertisement/AdvertisementApplication.dart';
import 'package:jobfinder/pages/post/job_details.dart';
import 'package:jobfinder/pages/settings/general_settings.dart';
import 'package:jobfinder/provider/UserProvider.dart';
import 'package:jobfinder/services/Advertisement/AdvertisementApplicationService.dart';
import 'package:jobfinder/services/Advertisement/AdvertisementService.dart';
import 'package:jobfinder/widget/elevated_button.dart';
import 'package:jobfinder/widget/navbar.dart';
import 'package:provider/provider.dart';
import '../../components/styles.dart';

class MyPostsApplications extends StatefulWidget {
  static const String id = 'MyPostsApplications';
  final int advertisementId;
  const MyPostsApplications({Key? key, required this.advertisementId}) : super(key: key);

  @override
  _MyPostsApplicationsState createState() => _MyPostsApplicationsState();
}

class _MyPostsApplicationsState extends State<MyPostsApplications> {
  late String _authToken;
  late int _userId;

  late AdvertisementService _advertisementService;

  List<AdvertisementApplication>? advertisementApplications = null;

  @override
  void initState() {
    super.initState();
    _authToken = context.read<UserProvider>().auth!.accessToken;
    _userId = context.read<UserProvider>().auth!.user.id;
    _advertisementService = AdvertisementService(_authToken, _userId);
    _loadAdvertisementApplications();
  }

  Future<void> _loadAdvertisementApplications() async {
    List<AdvertisementApplication> loadedAdvertisementApplications = await _advertisementService.applications(widget.advertisementId);
    setState(() {
      advertisementApplications = loadedAdvertisementApplications;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Applied Positions'),
          centerTitle: true,
          titleSpacing: 0,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const GeneralSettings()));
                },
                icon: const Icon(Icons.location_pin))
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
        body: advertisementApplications == null ? Center(child: CircularProgressIndicator()) : _buildBody());
  }

  Widget _buildBody() {
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: advertisementApplications!.length,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, i) => Column(
            children: [_buildJobs(advertisementApplications![i])],
          ),
        ));
  }

  Widget _buildJobs(advertisementApplication) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  JobDetails(advertisementId: advertisementApplication.advertisement.id,)));
      },
      child: Container(
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
                        advertisementApplication.advertisement?.company != null ? Icons.maps_home_work_outlined : Icons.person,
                        size: 30,
                        color: appColor,
                      ),),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      blackHeadingSmall(advertisementApplication.advertisement?.job != null ? advertisementApplication.advertisement?.job?.name : advertisementApplication.advertisement?.jobTitle),
                      greyTextSmall(advertisementApplication.advertisement?.company != null ? advertisementApplication.advertisement?.company?.name : advertisementApplication.advertisement?.user.name,)
                    ],
                  ),
                ),
                const Icon(Icons.bookmark, color: appColor, size: 16),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: greyTextSmall(advertisementApplication.advertisement?.address?.fullAddress ?? ''),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                boldText(''),
                MyElevatedButton(
                    onPressed: () {},
                    text: btnText('Appled'),
                    height: 28,
                    width: 80)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
