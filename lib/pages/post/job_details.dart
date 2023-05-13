/*
  Authors : flutter_ninja (Flutter Ninja)
  Website : https://codecanyon.net/user/flutter_ninja/
  App Name : JobFinder Flutter Template
  This App Template Source code is licensed as per the
  terms found in the Website https://codecanyon.net/licenses/standard/
  Copyright and Good Faith Purchasers © 2022-present flutter_ninja.
*/
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jobfinder/enums.dart';
import 'package:jobfinder/helpers/map_icon.dart';
import 'package:jobfinder/models/Advertisement/Advertisement.dart';
import 'package:jobfinder/models/User/UserAddress.dart';
import 'package:jobfinder/pages/settings/general_settings.dart';
import 'package:jobfinder/provider/UserProvider.dart';
import 'package:jobfinder/services/Advertisement/AdvertisementService.dart';
import 'package:jobfinder/widget/elevated_button.dart';
import 'package:jobfinder/widget/rating.dart';
import 'package:provider/provider.dart';
import '../../components/styles.dart';

class JobDetails extends StatefulWidget {
  static const String id = 'JobDetails';
  final int advertisementId;

  const JobDetails({Key? key,required this.advertisementId}) : super(key: key);

  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  int selectID = 1;
  double rating = 3.5;

  late String _authToken;
  late int _userId;
  late UserAddress _userAddress;
  late AdvertisementService _advertisementService;

  late Advertisement? advertisement = null;

  late BitmapDescriptorSingleton mapIcon;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _authToken = context.read<UserProvider>().auth!.accessToken;
    _userId = context.read<UserProvider>().auth!.user.id;
    _userAddress = context.read<UserProvider>().address!;
    _advertisementService = AdvertisementService(_authToken, _userId);
    getAdvertisementDetails();
  }

  void getAdvertisementDetails() async {
    mapIcon = BitmapDescriptorSingleton();
    await mapIcon.initialize();

    print(mapIcon.companyIcon);

    Advertisement fetchAdvertisement = await _advertisementService.show(widget.advertisementId);
    setState(() {
      advertisement = fetchAdvertisement;
    });
  }

  void _onMapCreated(GoogleMapController controller) async {
    // Map Style
    String style = '''
    [      {        "featureType": "poi",        "stylers": [          { "visibility": "off" }        ]
      },
      {
        "featureType": "transit",
        "stylers": [
          { "visibility": "off" }
        ]
      },
      {
        "featureType": "road",
        "elementType": "geometry",
        "stylers": [
          { "visibility": "on" }
        ]
      },
      {
        "featureType": "road",
        "elementType": "labels.icon",
        "stylers": [
          { "visibility": "off" }
        ]
      },
      {
        "featureType": "road",
        "elementType": "labels.text",
        "stylers": [
          { "visibility": "on" }
        ]
      }
    ]
  ''';

    controller.setMapStyle(style);

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('Id-1'),
          position: LatLng(advertisement!.address.latitude!, advertisement!.address.longitude!),
          icon: mapIcon.companyIcon,
          infoWindow: InfoWindow(
            title: advertisement!.company != null ? advertisement!.company!.name : advertisement!.user.name,
            snippet: advertisement!.address.neighborhoodName + (advertisement?.address.remainingAddress ?? ''),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => GeneralSettings()));
            },
          ),
        ),
      );
      _markers.add(
        Marker(
          markerId: MarkerId('Id-2'),
          position: LatLng(_userAddress.latitude!, _userAddress.longitude!),
          icon: mapIcon.youIcon,
            infoWindow: InfoWindow(
              title: 'Your Location',
              snippet: _userAddress.neighborhoodName + _userAddress.remainingAddress! ?? '',
            )
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Post Detail'),
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
        body: _buildBody());
  }

  Widget _buildBody() {
    if (advertisement == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              _buildJobName(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSelect('Description', 1),
                  advertisement?.company != null ? _buildSelect('Company', 2) : Container(),
                ],
              ),
              Column(children: [
                if (selectID == 1)
                  _buildDescription()
                else if (selectID == 2)
                  advertisement?.company != null ? _buildCompany() : Container()
              ]),
            ],
          ));
    }

  }

  Widget _buildJobName() {
    return Container(
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
          children: [
            Icon(
              advertisement?.company != null ? Icons.business_center : Icons.work,
              size: 50,
              color: appColor,
            ),
            const SizedBox(height: 8),
            blackHeadingSmall(advertisement?.job != null ? advertisement?.job?.name : advertisement?.jobTitle),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                  decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: greyTextSmall(Enums.employmentType[int.tryParse(advertisement?.employmentType ?? '1')]),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      advertisement?.company != null ? Icons.business_outlined : Icons.person,
                      size: 40,
                      color: appColor,
                    )),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      blackHeadingSmall(advertisement?.company != null ? advertisement?.company?.name : advertisement?.user.name,),
                    ],
                  ),
                ),
                greyTextSmall(advertisement?.publishedDate ?? ''),
              ],
            ),
          ],
        ));
  }

  Widget _buildSelect(title, id) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectID = id;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[appColor2, appColor]),
          color: selectID == id ? appColor : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(50.0)),
        ),
        child: Text(title,
            style: TextStyle(
                fontFamily: 'medium',
                fontSize: 14,
                color: selectID == id ? Colors.white : Colors.black54)),
      ),
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: blackHeading('Qualifications'.toUpperCase()),
        ),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                ListTile(
                  leading: const SizedBox(
                      height: double.infinity,
                      child: Icon(Icons.circle, size: 14)),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  minLeadingWidth: 0,
                  title: greyText(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco'),
                ),
                ListTile(
                  leading: const SizedBox(
                      height: double.infinity,
                      child: Icon(Icons.circle, size: 14)),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  minLeadingWidth: 0,
                  title: greyText(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco'),
                ),
              ],
            )),
        Container(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: blackHeading('About the job'.toUpperCase()),
        ),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                ListTile(
                  leading: const SizedBox(
                      height: double.infinity,
                      child: Icon(Icons.circle, size: 14)),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  minLeadingWidth: 0,
                  title: greyText(
                      'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor '),
                ),
                ListTile(
                  leading: const SizedBox(
                      height: double.infinity,
                      child: Icon(Icons.circle, size: 14)),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  minLeadingWidth: 0,
                  title: greyText(
                      'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor '),
                ),
              ],
            )),
        Container(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: blackHeading('Responsibilities'.toUpperCase()),
        ),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                ListTile(
                  leading: const SizedBox(
                      height: double.infinity,
                      child: Icon(Icons.circle, size: 14)),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  minLeadingWidth: 0,
                  title: greyText(
                      'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor '),
                ),
                ListTile(
                  leading: const SizedBox(
                      height: double.infinity,
                      child: Icon(Icons.circle, size: 14)),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  minLeadingWidth: 0,
                  title: greyText(
                      'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor '),
                ),
              ],
            )),
        Container(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: blackHeading('Address'.toUpperCase()),
        ),
        mapIcon == null ? const Center(child: CircularProgressIndicator())
          : Container(
              height: 300,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition:  CameraPosition(
                target: LatLng(advertisement!.address.latitude!, advertisement!.address.longitude!), zoom: 18),
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
      ],
    );
  }

  Widget _buildCompany() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: blackHeading('Qualifications'.toUpperCase()),
        ),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                ListTile(
                  leading: const SizedBox(
                      height: double.infinity,
                      child: Icon(Icons.circle, size: 14)),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  minLeadingWidth: 0,
                  title: greyText(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco'),
                ),
                ListTile(
                  leading: const SizedBox(
                      height: double.infinity,
                      child: Icon(Icons.circle, size: 14)),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  minLeadingWidth: 0,
                  title: greyText(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco'),
                ),
              ],
            )),
      ],
    );
  }
}