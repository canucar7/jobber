import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobfinder/components/styles.dart';
import 'package:jobfinder/config.dart';
import 'package:jobfinder/models/Location/City.dart';
import 'package:jobfinder/models/Location/District.dart';
import 'package:jobfinder/models/User/UserCertificate.dart';
import 'package:jobfinder/models/User/UserCompany.dart';
import 'package:jobfinder/provider/UserProvider.dart';
import 'package:jobfinder/services/Location/CityService.dart';
import 'package:jobfinder/services/Location/DistrictService.dart';
import 'package:jobfinder/services/User/UserCertificatesService.dart';
import 'package:jobfinder/services/User/UserCompanyService.dart';
import 'package:provider/provider.dart';


class UserCompanies extends StatefulWidget {
  const UserCompanies({Key? key}) : super(key: key);

  @override
  State<UserCompanies> createState() => _UserCompaniesState();
}

class _UserCompaniesState extends State<UserCompanies> {
  String dropdownValueLicense = 'Yapıldı';

  late String _authToken;
  late int _userId;
  late UserCompanyService _userCompanyService;

  late CityService _cityService;
  late DistrictService _districtService;

  late Future<List<UserCompany>> companies;
  late Future<List<City>> cities;
  late Future<List<District>> districts;

  File? _image;

  @override
  void initState() {
    super.initState();
    _authToken = context.read<UserProvider>().auth!.accessToken;
    _userId = context.read<UserProvider>().auth!.user.id;
    _userCompanyService = UserCompanyService(_authToken, _userId);
    _cityService = CityService(_authToken);
    _districtService = DistrictService(_authToken);
    cities = _cityService.getCities(Config.TurkeyId);
    districts = _districtService.getDistricts(null);
    companies = _userCompanyService.index();
  }

  void _updateCompanies() {
    setState(() {
      companies = _userCompanyService.index();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              blackHeadingSmall('companies'.toUpperCase()),
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
                _listBuilder(),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: Text('Add'),
                        onPressed: (){
                          _showModal(false);
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: appColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            )),
      ],
    );
  }

  Widget _listBuilder() {
    return FutureBuilder<List<UserCompany>>(
      future: companies,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final componiess = snapshot.data!;
          return ListView.builder(
            itemCount: componiess.length,
            itemBuilder: (context, index) {
              final company = componiess[index];
              return ListTile(
                title: Text(company.name),
                trailing: Wrap(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showModal(true, company);
                      },
                      child: Icon(Icons.edit_calendar_outlined,color: appColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showDeleteConfirmationDialog(company);
                      },
                      child: Icon(Icons.delete,color: appColor),
                    ),
                  ],
                ),
              );
            },
            shrinkWrap: true,
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void _showModal(bool isUpdate, [UserCompany? company]) {
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
      selectedDistrict = value;
    }
    final companyNameController = TextEditingController();
    final descriptionController = TextEditingController();
    final phoneNumberController = TextEditingController();
    final neighborhoodNameController = TextEditingController();
    final remainingAddressController = TextEditingController();

    if (isUpdate) {
      companyNameController.text = company!.name;
      descriptionController.text = company.description;
      phoneNumberController.text = company.phoneNumber.toString();
      selectedCity = company.address.cityId;
      handleCityChange(selectedCity);
      selectedDistrict = company.address.districtId;
      neighborhoodNameController.text = company.address.neighborhoodName;
      remainingAddressController.text = (company.address.remainingAddress ?? '');
    }

    showModalBottomSheet(isScrollControlled: true,context: context, builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: companyNameController,
                  decoration: const InputDecoration(
                    hintText: 'Company Name',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: phoneNumberController,
                  decoration: const InputDecoration(
                    hintText: 'Phone Number',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                const SizedBox(height: 16),
                TextButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.blueGrey,
                      textStyle: TextStyle(fontSize: 18),
                      side: BorderSide(color: Colors.blueGrey)
                  ),
                  onPressed: () async {
                    final image = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );
                    if (image == null) return;

                    final imageTemp = File(image.path);

                    setState((){
                      this._image = imageTemp;

                    });


                  },
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      const SizedBox(width: 8),
                      Text('Add Photo'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
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
                  onPressed: ()  {
                    final name = companyNameController.text;
                    final description = descriptionController.text;
                    final phoneNumber = phoneNumberController.text;
                    final neighborhoodName = neighborhoodNameController.text;
                    final remainingAddress = remainingAddressController.text;

                    if (name.isNotEmpty && description.isNotEmpty && phoneNumber.isNotEmpty && selectedCity != null && selectedDistrict != null  && neighborhoodName.isNotEmpty && remainingAddress.isNotEmpty) {
                      final data = {
                        "name": name,
                        "description": description,
                        "phone_number": phoneNumber,
                        "country_id": Config.TurkeyId.toString(),
                        "city_id": selectedCity.toString(),
                        "district_id": selectedDistrict.toString(),
                        "neighborhood_name": neighborhoodName,
                        "remaining_address": remainingAddress,
                      };


                      if (isUpdate) {
                        _userCompanyService.update(company!.id, data,_image).then((value) => {
                          _updateCompanies(),
                          Navigator.pop(context),
                        });
                      } else {
                        _userCompanyService.store(data,_image).then((value) => {
                          _updateCompanies(),
                          Navigator.pop(context),
                        });
                      }

                    }
                  },
                  child: Text(isUpdate ? 'Update' : 'Save'),
                ),
                const SizedBox(height: 40,),
              ],
            ),
          ),
        );

      });
    },
    );
  }

  void _showDeleteConfirmationDialog(UserCompany company) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Company"),
          content: const Text("Are you sure you want to delete this company?"),
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
                _userCompanyService.destroy(company.id).then((value) => {
                  _updateCompanies(),
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
