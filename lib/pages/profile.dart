/*
  Authors : flutter_ninja (Flutter Ninja)
  Website : https://codecanyon.net/user/flutter_ninja/
  App Name : JobFinder Flutter Template
  This App Template Source code is licensed as per the
  terms found in the Website https://codecanyon.net/licenses/standard/
  Copyright and Good Faith Purchasers © 2022-present flutter_ninja.
*/
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:jobfinder/widget/navbar.dart';
import '../components/styles.dart';
import 'package:file_picker/file_picker.dart';

class Profile extends StatefulWidget {
  static const String id = 'Profile';

  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int selectID = 1;
  String dropdownValueDay = '2';
  String dropdownValueMonth = 'July';
  String dropdownValueYear = '1997';
  String dropdownValueMilitary = 'Muaf';
  String dropdownValueLicense = 'Yapıldı';
  String dropdownValueCountry = 'India';
  String dropdownValueZip = '85001';


  List<String> list = <String>['Tecilli', 'Muaf', 'Yapıldı'];

  bool isCorrect = false;

  PlatformFile? pickedFile;


  List? _tempListOfCities;

  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  final TextEditingController textController = new TextEditingController();

  static List _listOfCities = [
              "Tokyo",
              "New York",
              "London",
              "Paris",
              "Madrid",
              "Dubai",
              "Rome",
              "Barcelona",
              "Cologne",
              "Monte Carlo",
              "Puebla",
              "Florence",
  ];

  String searchValue = '';
  final Map<int, String> _suggestions01 = {
    1 : 'AZERBAIJANI',
    2 : 'ARABIC',
    3 : 'GERMAN',
    4 : 'BULGARIAN',
    5 : 'CHINESE',
    6 : 'FRENCH',
    7 : 'PERSIAN',
    8 : 'ENGLISH',
    9 : 'ITALIAN',
    10 : 'SPANISH',
    11 : 'JAPANESE',
    12 : 'KOREAN',
    13 : 'PORTUGUESE',
    14 : 'RUSSIAN',
    15 : 'TURKISH',
    16 : 'GREEK',
  };



  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if(result == null) return;

    setState(() {
      pickedFile = result.files.first;
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
        extendBodyBehindAppBar: true,
        backgroundColor: backgroundColor,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   iconTheme: const IconThemeData(color: Colors.white),
        //   title: const Text('Profile'),
        //   centerTitle: true,
        //   elevation: 0,
        // ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return SingleChildScrollView(
        child: Column(
      children: [
        _buildHeader(),
        const SizedBox(height: 8),
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
            )),
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              blackHeadingSmall('Education'.toUpperCase()),
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
                                        greyTextSmall('Degree'),
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
                                    textFieldNo('School Name'),
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
                                              items: <String>['1', '2', '3', '4','5']
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
                                        Text("Still studying")
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              blackHeadingSmall('Skills'.toUpperCase()),
            ],
          ),
        ),
        Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                                    textFieldNo('Skills and Abilities'),
                                    SizedBox(height: 40,),
                                    ElevatedButton(
                                        onPressed: (){},
                                        child: Text("SAVE")),

                                  ],


                                ),

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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              blackHeadingSmall('Certificates'.toUpperCase()),
            ],
          ),
        ),
        Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                                    textFieldNo('Certificate Name'),
                                    textFieldNo('Institution Name'),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 20),
                                        greyTextSmall('Date'),
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              blackHeadingSmall('Foreign Languages'.toUpperCase()),
            ],
          ),
        ),
        Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                                        greyTextSmall('Language'),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.transparent,
                                                    foregroundColor: Colors.black,
                                                    elevation: 0,
                                                    side: BorderSide(
                                                      width: 1.0,
                                                      color: Colors.black.withOpacity(0.1)
                                                    )

                                                  ),
                                                  child: Row(children :[Text('Select',style:TextStyle(fontSize: 13) ,),] ),
                                                  onPressed: (){
                                                    _showModal(context);
                                                  },
                                                ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 20),
                                        greyTextSmall('Level'),
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              blackHeadingSmall('My Resume'.toUpperCase()),
            ],
          ),
        ),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: Text('ADD'),
                        onPressed: selectFile,
                      ),
                    ),
                  ],
                ),


                const SizedBox(height: 10),
              ],
            )),
        const SizedBox(height: 20)
      ],
    ));
  }

  Widget _buildHeader() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[appColor2, appColor]),
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.menu, color: Colors.white)),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Profile',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'medium',
                          fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 40)
              ],
            ),
            const CircleAvatar(
              backgroundImage: null,
              radius: 40,
            ),
            const SizedBox(height: 8),
            const Text(
              'Admin',
              style: TextStyle(
                  fontSize: 18, fontFamily: 'medium', color: Colors.white),
            ),
            const SizedBox(height: 8),
            const Text(
              'admin@hotmail.com',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            const SizedBox(height: 10),
            /*
            SizedBox(
              width: 120,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      primary: backgroundColor,
                      shadowColor: Colors.black38,
                      onPrimary: Colors.black,
                      elevation: 0,
                      shape: (RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      )),
                      padding: const EdgeInsets.all(0)),
                  child: greyTextSmall('My Resume'.toUpperCase())),
            ),*/
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

  void _showModal(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
        ),
        context: context,
        builder: (context) {
          //3
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return DraggableScrollableSheet(
                    expand: false,
                    builder:
                        (BuildContext context, ScrollController scrollController) {
                      return Column(children: [
                        Padding(
                            padding: EdgeInsets.all(8),
                            child: Row(children: [
                              Expanded(
                                  child: TextField(
                                      controller: textController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(8),
                                        border: new OutlineInputBorder(
                                          borderRadius:
                                          new BorderRadius.circular(15.0),
                                          borderSide: new BorderSide(),
                                        ),
                                        prefixIcon: Icon(Icons.search),
                                      ),
                                      onChanged: (value) {
                                        //4
                                        setState(() {
                                          _tempListOfCities =
                                              _buildSearchList(value);
                                        });
                                      })),
                              IconButton(
                                  icon: Icon(Icons.close),
                                  color: Color(0xFF1F91E7),
                                  onPressed: () {
                                    setState(() {
                                      textController.clear();
                                      _tempListOfCities?.clear();
                                    });
                                  }),
                            ])),
                        Expanded(
                          child: ListView.separated(
                              controller: scrollController,
                              //5
                              itemCount: (_tempListOfCities != null &&
                                  _tempListOfCities!.length > 0)
                                  ? _tempListOfCities!.length
                                  : _listOfCities.length,
                              separatorBuilder: (context, int) {
                                return Divider();
                              },
                              itemBuilder: (context, index) {
                                return InkWell(

                                  //6
                                    child: (_tempListOfCities != null &&
                                        _tempListOfCities!.length > 0)
                                        ? _showBottomSheetWithSearch(
                                        index, _tempListOfCities!)
                                        : _showBottomSheetWithSearch(
                                        index, _listOfCities),
                                    onTap: () {
                                      //7
                                      _scaffoldKey.currentState!.showSnackBar(
                                          SnackBar(
                                              behavior: SnackBarBehavior.floating,
                                              content: Text((_tempListOfCities !=
                                                  null &&
                                                  _tempListOfCities!.length > 0)
                                                  ? _tempListOfCities![index]
                                                  : _listOfCities[index])));

                                      Navigator.of(context).pop();
                                    });
                              }),
                        )
                      ]);
                    });
              });
        });
  }

  Widget _showBottomSheetWithSearch(int index, List listOfCities) {
    return Text(listOfCities[index],
        style: TextStyle(color: Colors.black, fontSize: 16),textAlign: TextAlign.center);
  }
  List _buildSearchList(String userSearchTerm) {
    List _searchList = [];

    for (int i = 0; i < _listOfCities.length; i++) {
      String name = _listOfCities[i];
      if (name.toLowerCase().contains(userSearchTerm.toLowerCase())) {
        _searchList.add(_listOfCities[i]);
      }
    }
    return _searchList;
  }




}
