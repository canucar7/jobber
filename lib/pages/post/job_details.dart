import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jobfinder/enums.dart';
import 'package:jobfinder/helpers/map_icon.dart';
import 'package:jobfinder/models/Advertisement/Advertisement.dart';
import 'package:jobfinder/models/User/UserAddress.dart';
import 'package:jobfinder/pages/company_detail.dart';
import 'package:jobfinder/pages/settings/general_settings.dart';
import 'package:jobfinder/pages/user/user_profile.dart';
import 'package:jobfinder/provider/UserProvider.dart';
import 'package:jobfinder/services/Advertisement/AdvertisementService.dart';
import 'package:jobfinder/widget/elevated_button.dart';
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

  late BitmapDescriptorSingleton _mapAttributes;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _authToken = context.read<UserProvider>().auth!.accessToken;
    _userId = context.read<UserProvider>().auth!.user.id;
    _userAddress = context.read<UserProvider>().address!;
    _advertisementService = AdvertisementService(_authToken, _userId);
    getAdvertisementDetails();
    getMapAttributes();
  }

  void getAdvertisementDetails() async {
    Advertisement fetchAdvertisement = await _advertisementService.show(widget.advertisementId);
    setState(() {
      advertisement = fetchAdvertisement;
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
          position: LatLng(advertisement!.address.latitude!, advertisement!.address.longitude!),
          icon: _mapAttributes.companyIcon,
          infoWindow: InfoWindow(
            title: advertisement!.company != null ? advertisement!.company!.name : advertisement!.user.name,
            snippet: advertisement!.address.neighborhoodName + (advertisement?.address.remainingAddress ?? ''),
            onTap: () {
              if (advertisement?.company != null) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyDetail(companyId: advertisement!.company!.id)));
              } else {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyDetail(companyId: advertisement!.company!.id)));
              }
            },
          ),
        ),
      );
      _markers.add(
        Marker(
          markerId: MarkerId('Id-2'),
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
              SizedBox(height:8),
              applyButton(),
              _buildDescription(),
            ],
          ));
    }

  }

  Widget applyButton(){
    return MyElevatedButton(
        onPressed: ()  {},
        text: Text('Apply',
          style:TextStyle(
              fontSize: 19, fontFamily: 'medium', color: Colors.white) ,),
        height: 40,
        width: 300);
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
              advertisement?.company != null ? Icons.maps_home_work_outlined : Icons.person,
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
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        advertisement?.company != null ? Icons.maps_home_work_outlined : Icons.person,
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
                  greyTextSmall(advertisement?.publishedDate?.split(" ").first.toString() ?? ''),
                  SizedBox(height: 20,),
                ],
              ),
              SizedBox(height: 10,),
              Row(children: [
                MyElevatedButton(
                    onPressed: ()  {
                      if(advertisement?.company != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CompanyDetail(companyId: advertisement!.company!.id)));
                      }else{
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProfiles(profileId: advertisement!.user.id,)));
                      }

                    },
                    text: btnText('See Details'),
                    height: 28,
                    width: 100)
              ],
              mainAxisAlignment: MainAxisAlignment.start,)

            ],
           ),
          ],
        ));
  }


  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: blackHeading('Purpose'.toUpperCase()),
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
                  title: greyText(Enums.jobPurpose[advertisement?.purpose ?? 1]),
                ),
              ],
            )),
        Container(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: blackHeading('Job'.toUpperCase()),
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
                  title: greyText(advertisement?.job != null ? advertisement?.job?.name : advertisement?.jobTitle),
                ),
              ],
            )),
        Container(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: blackHeading('Details'.toUpperCase()),
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
                  title: greyText(advertisement?.description ?? ''),
                ),
              ],
            )),

        Container(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: blackHeading('Address'.toUpperCase()),
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
                  title: greyText(advertisement?.address.fullAddress ?? ''),
                ),
              ],
            )),
        Container(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: blackHeading('Location'.toUpperCase()),
        ),
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

}
