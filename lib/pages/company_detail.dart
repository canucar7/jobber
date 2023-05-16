import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jobfinder/helpers/map_icon.dart';
import 'package:jobfinder/models/User/UserCompany.dart';
import 'package:jobfinder/pages/view_jobs.dart';
import 'package:jobfinder/provider/UserProvider.dart';
import 'package:jobfinder/services/User/UserCompanyService.dart';
import 'package:jobfinder/widget/elevated_button.dart';
import 'package:jobfinder/widget/navbar.dart';
import 'package:provider/provider.dart';
import '../components/styles.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CompanyDetail extends StatefulWidget {
  static const String id = 'CompanyDetail';
  final int companyId;

  const CompanyDetail({Key? key, required this.companyId}) : super(key: key);

  @override
  _CompanyDetailState createState() => _CompanyDetailState();
}

class _CompanyDetailState extends State<CompanyDetail> {
  late String _authToken;
  late int _userId;
  late UserCompanyService _userCompanyService;

  late UserCompany? company = null;

  late BitmapDescriptorSingleton _mapAttributes;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _authToken = context.read<UserProvider>().auth!.accessToken;
    _userId = context.read<UserProvider>().auth!.user.id;
    _userCompanyService = UserCompanyService(_authToken, _userId);
    getCompanyDetails();
    getMapAttributes();
  }

  void getCompanyDetails() async {
    UserCompany fetchCompany = await _userCompanyService.show(widget.companyId);
    setState(() {
      company = fetchCompany;
    });
  }
  
  void getMapAttributes() async {
    _mapAttributes = BitmapDescriptorSingleton();
    await _mapAttributes.initialize();
  }
  
  void _onMapCreated(GoogleMapController controller) async {
    controller.setMapStyle(_mapAttributes.mapStyle);
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('Id-1'),
          position: LatLng(company!.address.latitude!, company!.address.longitude!),
          icon: _mapAttributes.companyIcon
        ),
      );
    });
  }

  Future<BitmapDescriptor> getCustomMarker() async {
    final ImageConfiguration config = ImageConfiguration(devicePixelRatio: 2.5);
    final BitmapDescriptor customMarker = await BitmapDescriptor.fromAssetImage(
    config,
    'assets/images/map-pin-company.png',
    );

    return customMarker;
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          drawer: const NavBar(),
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            title:  Text(company == null ? '' : company!.name),
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
          body: company == null ? const Center(child: CircularProgressIndicator()) : _buildBody());
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
                      blackHeadingSmall(company!.name),
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
                  const SizedBox(height: 8),
                  Container(
                    width: 500,
                    height: 100,
                    child: Text(
                      company!.description,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),

                ],
              )),
          const SizedBox(height: 16),
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
                  _buildOverviewList(Icons.location_on_outlined, 'Country',
                      company!.address.countryId.toString()),
                  _buildOverviewList(Icons.location_on_outlined, 'Location',
                      company!.address.neighborhoodName + " " + company!.address.remainingAddress+
                          "\n"+company!.address.districtId.toString() + "/" + company!.address.cityId.toString() ),
                  _buildOverviewList(
                      Icons.call_outlined, 'Phone Number', company!.phoneNumber.toString()),
                  _buildOverviewList(Icons.mail_outline, 'Email Address',
                      context.read<UserProvider>().auth!.user.email),
                ],
              )),
          const SizedBox(height: 8),
          blackHeadingSmall('Destination Map'.toUpperCase()),
          _mapAttributes == null ? const Center(child: CircularProgressIndicator())
              : Container(
            height: 300,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition:  CameraPosition(
                  target: LatLng(company!.address.latitude!, company!.address.longitude!), zoom: 18),
              markers: _markers,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              compassEnabled: true,
              zoomControlsEnabled: true,
              gestureRecognizers: Set()
                ..add(Factory<PanGestureRecognizer>(
                        () => PanGestureRecognizer()))
                ..add(Factory<ScaleGestureRecognizer>(
                        () => ScaleGestureRecognizer()))
                ..add(Factory<TapGestureRecognizer>(
                        () => TapGestureRecognizer()))
                ..add(Factory<VerticalDragGestureRecognizer>(
                        () => VerticalDragGestureRecognizer())),
            ),),
          const SizedBox(height: 16),
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
    ) ;
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
