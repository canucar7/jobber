/*
  Authors : flutter_ninja (Flutter Ninja)
  Website : https://codecanyon.net/user/flutter_ninja/
  App Name : JobFinder Flutter Template
  This App Template Source code is licensed as per the
  terms found in the Website https://codecanyon.net/licenses/standard/
  Copyright and Good Faith Purchasers © 2022-present flutter_ninja.
*/
import 'package:flutter/material.dart';
import 'package:jobfinder/pages/view_jobs.dart';
import 'package:jobfinder/widget/elevated_button.dart';
import 'package:jobfinder/widget/navbar.dart';
import '../components/styles.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CompanyDetail extends StatefulWidget {
  static const String id = 'CompanyDetail';

  const CompanyDetail({Key? key}) : super(key: key);

  @override
  _CompanyDetailState createState() => _CompanyDetailState();
}

class _CompanyDetailState extends State<CompanyDetail> {
  final Set<Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(
        const Marker(
          markerId: MarkerId('Id-1'),
          position: LatLng(21.5397106, 71.8215543),
        ),
      );
    });
  }

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
          title: const Text('Company Name'),
          centerTitle: true,
          titleSpacing: 0,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
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
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              color: backgroundColor,
              child: Stack(
                children: [
                  Column(
                    children: [_buildHeader(), _buildBottomDtl()],
                  ),
                  Positioned(
                      top: 120,
                      width: MediaQuery.of(context).size.width * 1,
                      child: _buildLoginDetail()),
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        image: DecorationImage(
            image: AssetImage('assets/images/p2.jpg'), fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildLoginDetail() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20.0,
              )
            ]),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: const EdgeInsets.only(right: 10),
                    child: Image.asset('assets/images/n3.png',
                        width: 30, height: 30)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      blackHeadingSmall('flutter_ninja Technology'),
                      greyTextSmall('Mumbai, India')
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: -16,
              right: 0,
              child: SizedBox(
                child: MyElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ViewJobs()));
                    },
                    text: btnText('4 OPEN POSITIONS'),
                    height: 28,
                    width: 140),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBottomDtl() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 42),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          blackHeadingSmall('About us'.toUpperCase()),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20.0,
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  blackHeadingSmall('Grow Next Level Business'.toUpperCase()),
                  const SizedBox(height: 8),
                  greyText(
                      'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which dont look \n \n Lorem slightly believable. If you ar ything embarra text on theefined chunks as necessary,')
                ],
              )),
          const SizedBox(height: 8),
          blackHeadingSmall('Intro video'.toUpperCase()),
          Container(
            height: 160,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              image: DecorationImage(
                  image: AssetImage('assets/images/p2.jpg'), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 8),
          blackHeadingSmall('Overview company'.toUpperCase()),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20.0,
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildOverviewList(Icons.category_outlined, 'Categories',
                      'Design & Creative'),
                  _buildOverviewList(Icons.location_on_outlined, 'Location',
                      'Los Angeles California PO'),
                  _buildOverviewList(
                      Icons.call_outlined, 'Phone Number', '987-654-3210'),
                  _buildOverviewList(Icons.mail_outline, 'Email Address',
                      'admin@flutter_ninja.com'),
                  _buildOverviewList(
                      Icons.language, 'Website', 'www.flutter_ninja.com'),
                ],
              )),
          const SizedBox(height: 8),
          blackHeadingSmall('Destination Map'.toUpperCase()),
          Container(
            height: 160,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              markers: _markers,
              initialCameraPosition: const CameraPosition(
                  target: LatLng(21.5397106, 71.8215543), zoom: 15),
            ),
          ),
          const SizedBox(height: 8),
          blackHeadingSmall('Social Profile'.toUpperCase()),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20.0,
                    )
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/images/facebook.png',
                      width: 40, height: 40, fit: BoxFit.cover),
                  Image.asset('assets/images/linkedinicon.png',
                      width: 40, height: 40, fit: BoxFit.cover),
                  Image.asset('assets/images/twitter.png',
                      width: 40, height: 40, fit: BoxFit.cover),
                  Image.asset('assets/images/instagram.png',
                      width: 40, height: 40, fit: BoxFit.cover),
                  Image.asset('assets/images/youtube.png',
                      width: 40, height: 40, fit: BoxFit.cover),
                ],
              )),
          const SizedBox(height: 8),
          blackHeadingSmall('Job Vacancies'.toUpperCase()),
          SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 2,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, i) => Column(
                  children: [_buildJobs()],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildOverviewList(icon, title, txt) {
    return Column(
      children: [
        ListTile(
          onTap: () {},
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          leading: CircleAvatar(
              backgroundColor: backgroundColor,
              child: Icon(icon, size: 20, color: appColor),
              radius: 18),
          minLeadingWidth: 0,
          title: Container(
              padding: const EdgeInsets.only(bottom: 6),
              child: boldText(title)),
          subtitle: greyTextSmall(txt),
        ),
        const Divider(thickness: 1, color: Colors.black12)
      ],
    );
  }

  Widget _buildJobs() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
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
                    child: Image.asset('assets/images/n3.png',
                        width: 30, height: 30)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      blackHeadingSmall('Flutter Developer'),
                      greyTextSmall('Gobook Tech. los Angeles, CA')
                    ],
                  ),
                ),
                const Icon(Icons.bookmark, color: appColor, size: 16),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: greyTextSmall(
                  'It is a long established fact that a reader be distracted by content of page when looking at its layout..'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                boldText('\$35,000 - \$85,000 a year'),
                MyElevatedButton(
                    onPressed: () {},
                    text: btnText('Apply'),
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
