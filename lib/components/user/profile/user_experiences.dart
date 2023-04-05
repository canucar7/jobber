import 'package:flutter/material.dart';
import 'package:jobfinder/components/styles.dart';

class UserExperiences extends StatefulWidget {
  const UserExperiences({Key? key}) : super(key: key);

  @override
  State<UserExperiences> createState() => _UserExperiencesState();
}

class _UserExperiencesState extends State<UserExperiences> {
  int selectID = 1;
  String dropdownValueDay = '2';
  String dropdownValueMonth = 'July';
  String dropdownValueYear = '1997';
  String dropdownValueMilitary = 'Muaf';
  String dropdownValueLicense = 'Yapıldı';
  String dropdownValueCountry = 'India';
  String dropdownValueZip = '85001';

  bool isCorrect = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              blackHeadingSmall('Experiences'.toUpperCase()),
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
                textFieldNo('Home Address'),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: Text('ADD'),
                        onPressed: (){
                          showModalBottomSheet(context: context, builder: (BuildContext context) {
                            return Container(
                                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                                height: MediaQuery.of(context).size.height * .60,
                                child : Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 20),
                                        greyTextSmall('Job Title'),
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
                                    textFieldNo('Company Name'),
                                    Row(
                                      children: [
                                        Expanded(child: greyTextSmall('Start Date'),),
                                        Expanded(child:  greyTextSmall('End Date'),)
                                      ],
                                    ),
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

                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: isCorrect,
                                          onChanged: (bool? newValue) {
                                            setState(() {
                                              isCorrect = newValue!;
                                            });
                                          },
                                        ),
                                        Text("Still working")
                                      ],),
                                    SizedBox(height: 40,),
                                    ElevatedButton(
                                        onPressed: (){},
                                        child: Text("SAVE")),



                                  ],
                                )
                            );
                          }
                          );
                        },

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
}
