import 'package:flutter/material.dart';
import 'package:jobfinder/components/styles.dart';
import 'package:jobfinder/models/User/UserCertificate.dart';
import 'package:jobfinder/provider/UserProvider.dart';
import 'package:jobfinder/services/User/UserCertificatesService.dart';
import 'package:provider/provider.dart';

class UserCertificates extends StatefulWidget {
  const UserCertificates({Key? key}) : super(key: key);

  @override
  State<UserCertificates> createState() => _UserCertificatesState();
}

class _UserCertificatesState extends State<UserCertificates> {
  String dropdownValueLicense = 'Yapıldı';

  late String _authToken;
  late int _userId;
  late UserCertificatesService _userCertificatesService;

  late Future<List<UserCertificate>> certificates;

  @override
  void initState() {
    super.initState();
    _authToken = context.read<UserProvider>().auth!.accessToken;
    _userId = context.read<UserProvider>().auth!.user.id;
    _userCertificatesService = UserCertificatesService(_authToken, _userId);
    certificates = _userCertificatesService.index();
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
                                        onPressed: (){
                                          //CertificateStoreService service =  CertificateStoreService(context.read<UserProvider>().auth!.accessToken,context.read<UserProvider>().auth!.user.id);
                                          //service.storeCertificates("şükrü deneme","patika","2023-09-20");
                                        },
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
