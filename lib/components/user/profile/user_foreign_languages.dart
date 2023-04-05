import 'package:flutter/material.dart';
import 'package:jobfinder/components/styles.dart';

class UserForeignLanguages extends StatefulWidget {
  const UserForeignLanguages({Key? key}) : super(key: key);

  @override
  State<UserForeignLanguages> createState() => _UserForeignLanguagesState();
}

class _UserForeignLanguagesState extends State<UserForeignLanguages> {
  final TextEditingController textController = new TextEditingController();
  List? _tempListOfCities;
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

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
      ],
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

  Widget _showBottomSheetWithSearch(int index, List listOfCities) {
    return Text(listOfCities[index],
        style: TextStyle(color: Colors.black, fontSize: 16),textAlign: TextAlign.center);
  }
}
