import 'package:flutter/material.dart';
import 'package:jobfinder/components/styles.dart';
import 'package:jobfinder/config.dart';
import 'package:jobfinder/models/Location/City.dart';
import 'package:jobfinder/models/Location/District.dart';
import 'package:jobfinder/models/User/UserAddress.dart';
import 'package:jobfinder/pages/filter.dart';
import 'package:jobfinder/pages/home.dart';
import 'package:jobfinder/pages/settings/general_settings.dart';
import 'package:jobfinder/provider/UserProvider.dart';
import 'package:jobfinder/services/Location/CityService.dart';
import 'package:jobfinder/services/Location/DistrictService.dart';
import 'package:jobfinder/services/User/UserAddressService.dart';
import 'package:jobfinder/widget/navbar.dart';
import 'package:provider/provider.dart';


class UserFirstAddresses extends StatefulWidget {
  const UserFirstAddresses({Key? key}) : super(key: key);

  @override
  State<UserFirstAddresses> createState() => _UserFirstAddressesState();
}

class _UserFirstAddressesState extends State<UserFirstAddresses> {
  late String _authToken;
  late int _userId;
  late UserAddressService _userAddressService;
  late CityService _cityService;
  late DistrictService _districtService;

  late Future<List<UserAddress>> addresses;
  late Future<List<City>> cities;
  late Future<List<District>> districts;

  @override
  void initState() {
    super.initState();
    _authToken = context.read<UserProvider>().auth!.accessToken;
    _userId = context.read<UserProvider>().auth!.user.id;
    _userAddressService = UserAddressService(_authToken, _userId);
    _cityService = CityService(_authToken);
    _districtService = DistrictService(_authToken);
    addresses = _userAddressService.index();
    cities = _cityService.getCities(Config.TurkeyId);
    districts = _districtService.getDistricts(null);
  }

  void _updateaddresses() {
    setState(() {
      addresses = _userAddressService.index();
    });
  }
  int? selectedCity;
  int? selectedDistrict;

  handleCityChange(int? value) {
    setState(() {
      selectedCity = value;
      districts = _districtService.getDistricts(selectedCity);
      selectedDistrict = null;
    });
  }

  handleDistrictChange(int? value) {
    setState((){
      selectedDistrict = value;
    });
  }

  final neighborhoodNameController = TextEditingController();
  final remainingAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('First Address'),
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
      body: _showModal(),
    );;
  }


   Widget _showModal() {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FutureBuilder<List<City>>(
                future: cities,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    final finalData = snapshot.data!;
                    return DropdownButtonFormField<int>(
                      decoration: InputDecoration(labelText: 'Select City'),
                      isExpanded: true,
                      value: selectedCity,
                      onChanged: (int? newValue) {
                        setState(() {
                          handleCityChange(newValue);
                        });
                      },
                      items: finalData
                          .map(
                            (item) => DropdownMenuItem<int>(
                          value: item.id,
                          child: Text(item.name),
                        ),
                      ).toList(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Failed to load: ${snapshot.error}');
                  } else {
                    return Text('Unknown error');
                  }
                },
              ),
              FutureBuilder<List<District>>(
                future: districts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    final finalData = snapshot.data!;
                    return DropdownButtonFormField<int>(
                      decoration: InputDecoration(labelText: 'Select District'),
                      isExpanded: true,
                      value: selectedDistrict,
                      onChanged: (int? newValue) {
                        setState(() {
                          handleDistrictChange(newValue);
                        });
                      },
                      items: finalData
                          .map(
                            (item) => DropdownMenuItem<int>(
                          value: item.id,
                          child: Text(item.name),
                        ),
                      ).toList(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Failed to load: ${snapshot.error}');
                  } else {
                    return Text('Unknown error');
                  }
                },
              ),
              TextField(
                controller: neighborhoodNameController,
                decoration: const InputDecoration(
                  hintText: 'Neighborhood Name',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: remainingAddressController,
                decoration: const InputDecoration(
                  hintText: 'Remaining Address',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final neighborhoodName = neighborhoodNameController.text;
                  final remainingAddress = remainingAddressController.text;

                  if (selectedCity != null && selectedDistrict != null  && neighborhoodName.isNotEmpty && remainingAddress.isNotEmpty) {
                    final data = {
                      "country_id": Config.TurkeyId,
                      "city_id": selectedCity,
                      "district_id": selectedDistrict,
                      "neighborhood_name": neighborhoodName,
                      "remaining_address": remainingAddress,
                    };
                    _userAddressService.firstStore(data, context.read<UserProvider>()).then((value) => {
                      _updateaddresses(),
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Home())),
                    });
                    //TODO: Buraya hata mesajı ekle
                  }
                },
                child: Text('Save'),
                style: ElevatedButton.styleFrom(backgroundColor: appColor),
              ),
            ],
          ),
        );

      }

  void _showDeleteConfirmationDialog(UserAddress address) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete address"),
          content: const Text("Are you sure you want to delete this address?"),
          actions: <Widget>[
            TextButton(
              child: const Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                "DELETE",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                _userAddressService.destroy(address.id).then((value) => {
                  _updateaddresses(),
                  Navigator.of(context).pop(),
                });
              },
            ),
          ],
        );
      },
    );
  }
}
