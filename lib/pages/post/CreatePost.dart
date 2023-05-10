import 'package:flutter/material.dart';
import 'package:jobfinder/components/styles.dart';
import 'package:jobfinder/enums.dart';
import 'package:jobfinder/models/Advertisement/Job.dart';
import 'package:jobfinder/models/User/UserAddress.dart';
import 'package:jobfinder/models/User/UserCompany.dart';
import 'package:jobfinder/provider/UserProvider.dart';
import 'package:jobfinder/services/Advertisement/AdvertisementService.dart';
import 'package:jobfinder/services/Advertisement/JobService.dart';
import 'package:jobfinder/services/User/UserAddressService.dart';
import 'package:jobfinder/services/User/UserCompanyService.dart';
import 'package:jobfinder/widget/checkbox.dart';
import 'package:jobfinder/widget/navbar.dart';
import 'package:provider/provider.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

enum SingingCharacter { var1 , var2, var3, var4 }



class _CreatePostState extends State<CreatePost> {

  SingingCharacter? _character = SingingCharacter.var1;
  SingingCharacter? _character2 = SingingCharacter.var3;


  String? _selectedEmploymentType = Enums.employmentType.values.first;
  String? _selectedPeriod = Enums.period.values.first;

  late String _authToken;
  late int _userId;
  late AdvertisementService _advertisementService;

  late UserAddressService _userAddressService;
  late UserCompanyService _userCompanyService;
  late JobService _jobService;

  late Future<List<UserAddress>> addresses;
  late Future<List<UserCompany>> companies;
  late Future<List<Job>> jobs;

  @override
  void initState() {
    super.initState();
    _authToken = context.read<UserProvider>().auth!.accessToken;
    _userId = context.read<UserProvider>().auth!.user.id;
    _advertisementService = AdvertisementService(_authToken, _userId);
    _userAddressService = UserAddressService(_authToken, _userId);
    _userCompanyService = UserCompanyService(_authToken, _userId);
    _jobService = JobService(_authToken);
  }



  final titleController = TextEditingController();
  final descriptionNameController = TextEditingController();

  int? selectedAddress;
  int? selectedCompany;
  int? selectedJob;





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        drawer: const NavBar(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Post'),
          centerTitle: true,
          titleSpacing: 0,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
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
      body: _buildBody(),
    );
  }


  Widget _buildBody() {
    return Container(
        margin: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  blackHeadingSmall('Post Purpose'.toUpperCase()),
                ],
              ),
            ),
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Looking for job'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.var1,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Looking for employee'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.var2,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 14,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  blackHeadingSmall('Post Type'.toUpperCase()),
                ],
              ),
            ),
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Company Advertisement'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.var3,
                      groupValue: _character2,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character2 = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Personal Advertisement'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.var4,
                      groupValue: _character2,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character2 = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 14,),
            _character2 == SingingCharacter.var3 ?
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  blackHeadingSmall('Company'.toUpperCase()),
                ],
              ),
            ): SizedBox(height: 1,),
            _character2 == SingingCharacter.var3 ?
            Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
                    FutureBuilder<List<UserCompany>>(
                      future: _userCompanyService.index(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<DropdownMenuItem<int>> items = [];
                          for (UserCompany company in snapshot.data!) {
                            items.add(
                              DropdownMenuItem(
                                value: company.id,
                                child: Text(company.name,overflow: TextOverflow.ellipsis,),

                              ),
                            );
                          }

                          return DropdownButton(
                            value: selectedCompany,
                            items: items,
                            onChanged: (value) {
                              setState(() {
                                selectedCompany = value as int?;
                              });// Seçilen adresi kullanın
                            },
                            isExpanded: true,
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }

                        return CircularProgressIndicator();
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                )): SizedBox(height: 1,),


            SizedBox(height: 14,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  blackHeadingSmall('Job Title'.toUpperCase()),
                ],
              ),
            ),
            Card(
              child:
                Column(
                  children: [
                    FutureBuilder<List<Job>>(
                      future: _jobService.index(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<DropdownMenuItem<int>> items = [];
                          items.add(DropdownMenuItem(
                            value: 0,
                            child: Text('OTHER',overflow: TextOverflow.ellipsis,),
                          ),);
                          for (Job job in snapshot.data!) {
                            items.add(
                              DropdownMenuItem(
                                value: job.id,
                                child: Text(job.name.toString(),overflow: TextOverflow.ellipsis,),

                              ),
                            );
                          }

                          return DropdownButton(
                            value: selectedJob,
                            items: items,
                            onChanged: ( value) {
                              setState(() {
                                selectedJob = value as int?;
                              });// Seçilen adresi kullanın
                            },
                            isExpanded: true,
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }

                        return CircularProgressIndicator();
                      },
                    ),
                    if(selectedJob == 0)
                    SizedBox(height:14),
                    if(selectedJob == 0)
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(labelText: 'Please Enter Your Post Title ',
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.grey),),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.grey)
                      )
                      )
                      ),
                  ],
                )

            ),

            SizedBox(height: 14,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  blackHeadingSmall('Employment Types'.toUpperCase()),
                ],
              ),
            ),
            Card(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 DropdownButtonFormField<int>(
                   value: _selectedEmploymentType != null ? Enums.employmentType.entries.firstWhere((element) => element.value == _selectedEmploymentType).key : null,
                   onChanged: (int? newValueLevel) {
                     setState(() {
                       _selectedEmploymentType = Enums.employmentType[newValueLevel!];
                     });
                   },
                   items: Enums.employmentType.entries.map((MapEntry<int, String> entry) {
                     return DropdownMenuItem<int>(
                       value: entry.key,
                       child: Text(entry.value),
                     );
                   }).toList(),
                 ),
               ],
             ),
            ),

            SizedBox(height: 14,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  blackHeadingSmall('Post Details'.toUpperCase()),
                ],
              ),
            ),
            Card(
              child:
              TextField(
                controller:descriptionNameController,
              ),
            ),


            SizedBox(height: 14,),
            _character2 == SingingCharacter.var4 ?
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  blackHeadingSmall('Address'.toUpperCase()),
                ],
              ),
            ): SizedBox(height: 1,),
            _character2 == SingingCharacter.var4 ?
            Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
                    FutureBuilder<List<UserAddress>>(
                      future: _userAddressService.index(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<DropdownMenuItem<int>> items = [];
                          for (UserAddress address in snapshot.data!) {
                            items.add(
                              DropdownMenuItem(
                                value: address.id,
                                child: Text(address.neighborhoodName + ' ' + address.remainingAddress,overflow: TextOverflow.ellipsis,),

                              ),
                            );
                          }

                          return DropdownButton(
                            value: selectedAddress,
                            items: items,
                            onChanged: (value) {
                              setState(() {
                                selectedAddress = value as int?;
                              });// Seçilen adresi kullanın
                            },
                            isExpanded: true,
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }

                        return CircularProgressIndicator();
                      },
                    ),
                  ],
                )):SizedBox(height: 1,),




            SizedBox(height: 12,),
            _character == SingingCharacter.var2 ?
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  blackHeadingSmall('Duration'.toUpperCase()),
                ],
              ),
            ): SizedBox(height: 1,),
            _character == SingingCharacter.var2 ?
            Card(
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DropdownButtonFormField<int>(
                    value: _selectedPeriod != null ? Enums.period.entries.firstWhere((element) => element.value == _selectedPeriod).key : null,
                    onChanged: (int? newValueLevel) {
                      setState(() {
                        _selectedPeriod = Enums.period[newValueLevel!];
                      });
                    },
                    items: Enums.period.entries.map((MapEntry<int, String> entry) {
                      return DropdownMenuItem<int>(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ) : SizedBox(height: 1,),

            SizedBox(height: 16,),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 120),
              child:  ElevatedButton(
                onPressed: () {
                  final data = {};

                  if(selectedJob == 0){
                    data['job_title'] = titleController.text.toString();
                  }
                  else {
                    data['job_it'] = selectedJob.toString();
                  }

                  if(_character2 == SingingCharacter.var3){
                    data['company_id'] = selectedCompany.toString();//company_id
                  }
                  else{
                    data['address_id'] = selectedAddress.toString();//address_id
                  }

                  data['employment_type'] = Enums.employmentType.entries.firstWhere((element) => element.value == _selectedEmploymentType).key.toString();//.toString()
                  data['description'] = descriptionNameController.text.toString();
                  data['period'] = Enums.period.entries.firstWhere((element) => element.value == _selectedPeriod).key.toString();//.toString()
                  data['purpose'] = _character == SingingCharacter.var1 ? 1.toString() : 2.toString();


                  if (true) {

                      _advertisementService.store(data).then((value) => {
                        print(value.id)
                        //Navigator.pop(context),
                      });


                  }
                },
                child: Text('Publish'),
              ),
            )



          ],
        )
    );
  }



}
