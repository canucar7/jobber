import 'package:flutter/material.dart';
import 'package:jobfinder/components/styles.dart';
import 'package:jobfinder/config.dart';
import 'package:jobfinder/models/Location/City.dart';
import 'package:jobfinder/models/Location/District.dart';
import 'package:jobfinder/models/User/UserAddress.dart';
import 'package:jobfinder/provider/UserProvider.dart';
import 'package:jobfinder/services/Location/CityService.dart';
import 'package:jobfinder/services/Location/DistrictService.dart';
import 'package:jobfinder/services/User/UserAddressService.dart';
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
    return Column(
      children: [
        SizedBox(height:30),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              blackHeadingSmall('address'.toUpperCase()),
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
                _showModal(),
                const SizedBox(height: 10),
              ],
            )),
      ],
    );
  }


   Widget _showModal() {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                    return DropdownButton<int>(
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
                    return DropdownButton<int>(
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
                    _userAddressService.store(data).then((value) => {
                      _updateaddresses(),
                      Navigator.pop(context),
                    });
                    //TODO: Buraya hata mesajı ekle
                  }
                },
                child: Text('Save'),
              ),
              const SizedBox(height: 40,),
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
