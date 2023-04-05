import 'package:flutter/material.dart';

import '../../styles.dart';

class UserInformations extends StatefulWidget {
  const UserInformations({Key? key}) : super(key: key);

  @override
  State<UserInformations> createState() => _UserInformationsState();
}

class _UserInformationsState extends State<UserInformations> {
  int selectID = 1;
  String dropdownValueDay = '2';
  String dropdownValueMonth = 'July';
  String dropdownValueYear = '1997';
  String dropdownValueMilitary = 'Muaf';
  String dropdownValueLicense = 'Yapıldı';
  String dropdownValueCountry = 'India';
  String dropdownValueZip = '85001';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              blackHeadingSmall('Basic Informations'.toUpperCase()),
            ],
          ),
        ),
        Container(
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
                textFieldNo('Full Name'),
                textFieldNo('Phone Number'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    greyTextSmall('Gender'),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSelect('Male', 1),
                        _buildSelect('Female', 2),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    greyTextSmall('Date of Birth'),
                    Row(
                      children: [
                        Expanded(
                            child: DropdownButton<String>(
                              value: dropdownValueDay,
                              icon: const Icon(Icons.arrow_drop_down),
                              style: const TextStyle(color: Colors.black87),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValueDay = newValue!;
                                });
                              },
                              items: <String>['1', '2', '3', '4']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )),
                        const SizedBox(width: 10),
                        Expanded(
                            child: DropdownButton<String>(
                              value: dropdownValueMonth,
                              icon: const Icon(Icons.arrow_drop_down),
                              style: const TextStyle(color: Colors.black87),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValueMonth = newValue!;
                                });
                              },
                              items: <String>['January', 'March', 'April', 'July']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )),
                        const SizedBox(width: 10),
                        Expanded(
                            child: DropdownButton<String>(
                              value: dropdownValueYear,
                              icon: const Icon(Icons.arrow_drop_down),
                              style: const TextStyle(color: Colors.black87),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValueYear = newValue!;
                                });
                              },
                              items: <String>['1994', '1995', '1996', '1997']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    greyTextSmall('Military Status'),
                    Row(
                      children: [
                        Expanded(
                            child: DropdownButton<String>(
                              value: dropdownValueMilitary,
                              icon: const Icon(Icons.arrow_drop_down),
                              style: const TextStyle(color: Colors.black87),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValueMilitary = newValue!;
                                });
                              },
                              items: <String>['Tecilli', 'Yapıldı', 'Muaf']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    greyTextSmall('Driving License'),
                    Row(
                      children: [
                        Expanded(
                            child: DropdownButton<String>(
                              value: dropdownValueLicense,
                              icon: const Icon(Icons.arrow_drop_down),
                              style: const TextStyle(color: Colors.black87),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValueLicense = newValue!;
                                });
                              },
                              items: <String>['Tecilli', 'Yapıldı', 'Muaf']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            )
        ),
      ]
    );
  }

  Widget _buildSelect(title, id) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectID = id;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 50),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
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
}
