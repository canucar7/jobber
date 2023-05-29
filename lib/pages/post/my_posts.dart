import 'package:flutter/material.dart';
import 'package:jobfinder/models/Advertisement/Advertisement.dart';
import 'package:jobfinder/pages/post/job_details.dart';
import 'package:jobfinder/pages/post/my_posts_applications.dart';
import 'package:jobfinder/pages/settings/general_settings.dart';
import 'package:jobfinder/provider/UserProvider.dart';
import 'package:jobfinder/services/Advertisement/AdvertisementService.dart';
import 'package:jobfinder/widget/elevated_button.dart';
import 'package:jobfinder/widget/navbar.dart';
import 'package:provider/provider.dart';
import '../../components/styles.dart';

class MyJobs extends StatefulWidget {
  static const String id = 'MyJobs';

  const MyJobs({Key? key}) : super(key: key);

  @override
  _MyJobsState createState() => _MyJobsState();
}

class _MyJobsState extends State<MyJobs> {
  late String _authToken;
  late int _userId;

  late AdvertisementService _advertisementService;

  List<Advertisement>? advertisements = null;

  @override
  void initState() {
    super.initState();
    _authToken = context.read<UserProvider>().auth!.accessToken;
    _userId = context.read<UserProvider>().auth!.user.id;
    _advertisementService = AdvertisementService(_authToken, _userId);
    _loadAdvertisements();
  }

  Future<void> _loadAdvertisements() async {
    List<Advertisement> loadedAdvertisements = await _advertisementService.allUserApplications(_userId);
    setState(() {
      advertisements = loadedAdvertisements;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('My Posts'),
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
        body: advertisements == null ? Center(child: CircularProgressIndicator()) : _buildBody());
  }

  Widget _buildBody() {
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: advertisements!.length,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, i) => Column(
            children: [_buildJobs(advertisements![i])],
          ),
        ));
  }

  Widget _buildJobs(advertisement) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  JobDetails(advertisementId: advertisement.id,)));
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
                        advertisement?.company != null ? Icons.maps_home_work_outlined : Icons.person,
                        size: 30,
                        color: appColor,
                      ),),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      blackHeadingSmall(advertisement?.job != null ? advertisement?.job?.name : advertisement?.jobTitle.toString()),
                      greyTextSmall(advertisement?.company != null ? advertisement?.company?.name : advertisement?.user.name,)
                    ],
                  ),
                ),
                const Icon(Icons.bookmark, color: appColor, size: 16),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: greyTextSmall(advertisement?.address?.fullAddress ?? ''),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                boldText(''),
                MyElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>  MyPostsApplications(advertisementId: advertisement.id,)));
                    },
                    text: btnText('View Applications'),
                    height: 28,
                    width: 195)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
