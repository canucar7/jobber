import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jobfinder/helpers/map_icon.dart';
import 'package:jobfinder/models/Advertisement/Advertisement.dart';
import 'package:jobfinder/models/User/UserAddress.dart';
import 'package:jobfinder/pages/categories.dart';
import 'package:jobfinder/pages/filter.dart';
import 'package:jobfinder/pages/post/job_details.dart';
import 'package:jobfinder/pages/settings/general_settings.dart';
import 'package:jobfinder/pages/view_jobs.dart';
import 'package:jobfinder/provider/UserProvider.dart';
import 'package:jobfinder/services/Advertisement/AdvertisementService.dart';
import 'package:jobfinder/services/Advertisement/JobService.dart';
import 'package:jobfinder/services/User/UserCompanyService.dart';
import 'package:jobfinder/widget/elevated_button.dart';
import 'package:jobfinder/widget/navbar.dart';
import 'package:provider/provider.dart';
import '../components/styles.dart';

class CategoryDetails extends StatefulWidget {
  static const String id = 'CategoryDetails';
  final int jobId;

  const CategoryDetails({Key? key, required this.jobId}) : super(key: key);

  @override
  _CategoryDetailsState createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  late String _authToken;
  late int _userId;
  late UserAddress _userAddress;
  late int _selectedUserAddress;

  late AdvertisementService _advertisementService;

  List<Advertisement>? advertisements = null;

  late BitmapDescriptorSingleton _mapAttributes;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _authToken = context.read<UserProvider>().auth!.accessToken;
    _userId = context.read<UserProvider>().auth!.user.id;
    _userAddress = context.read<UserProvider>().address!;
    _selectedUserAddress = context.read<UserProvider>().address!.id;
    _advertisementService = AdvertisementService(_authToken, _userId);
    _loadAdvertisements();
    getMapAttributes();
  }

  Future<void> _loadAdvertisements() async {
    List<Advertisement> loadedAdvertisements = await _advertisementService.activeByAddressAndJob(_selectedUserAddress, widget.jobId);
    setState(() {
      advertisements = loadedAdvertisements;
    });
  }

  void getMapAttributes() async {
    _mapAttributes = BitmapDescriptorSingleton();
    await _mapAttributes.initialize();
  }

  void _onMapCreated(GoogleMapController controller) async {
    controller.setMapStyle(_mapAttributes.mapStyle);

    for (var advertisement in advertisements!) {
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId(advertisement.id.toString()),
            position: LatLng(advertisement.address.latitude!, advertisement.address.longitude!),
            icon: advertisement.company != null ? _mapAttributes.companyIcon : _mapAttributes.userIcon,
            infoWindow: InfoWindow(
              title: advertisement.job != null ? advertisement.job?.name : advertisement.jobTitle,
              snippet: advertisement.company != null ? advertisement.company!.name : advertisement.user.name,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => JobDetails(advertisementId: advertisement.id,)));
              },
            ),
          ),
        );
      });
    }

    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId('Id-user'),
            position: LatLng(_userAddress.latitude!, _userAddress.longitude!),
            icon: _mapAttributes.youIcon,
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
      backgroundColor: Colors.white,
      drawer: const NavBar(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Category Details'),
        centerTitle: true,
        titleSpacing: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const GeneralSettings()));
              },
              icon: const Icon(Icons.location_pin)),
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
      body: _mapAttributes == null ? Center(child: CircularProgressIndicator()) : _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          advertisements == null ? const Center(child: CircularProgressIndicator())
              : Container(
            height: 400,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition:  CameraPosition(
                  target: LatLng(_userAddress.latitude!, _userAddress.longitude!), zoom: 18),
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                blackHeadingSmall('Posts'.toUpperCase()),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ViewJobs()));
                    },
                    child: appcolorText(''))
              ],
            ),
          ),
          advertisements == null ?  const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: advertisements?.length,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, i) => Column(
                  children: [_buildJobs(advertisements![i])],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildJobs(Advertisement advertisement) {
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
                      advertisement.company != null ? Icons.maps_home_work_outlined  : Icons.person,
                      size: 30,
                      color: appColor,
                    ),),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      blackHeadingSmall(advertisement.job != null ? advertisement.job?.name : advertisement.jobTitle),
                      greyTextSmall(advertisement.company != null ? advertisement?.company?.name : advertisement?.user.name,)
                    ],
                  ),
                ),
                const Icon(Icons.bookmark, color: appColor, size: 16),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: greyTextSmall(
                  advertisement.address.neighborhoodName + ' ' + (advertisement.address.remainingAddress ?? '')),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                boldText(''),
                MyElevatedButton(
                    onPressed: ()  {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>  JobDetails(advertisementId: advertisement.id,)));
                    },
                    text: btnText('See Details'),
                    height: 28,
                    width: 100)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Item {
  const Item(this.img, this.name);
  final String img;
  final String name;
}
