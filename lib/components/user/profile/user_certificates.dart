import 'package:date_time_picker/date_time_picker.dart';
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

  void _updateCertificates() {
    setState(() {
      certificates = _userCertificatesService.index();
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
              blackHeadingSmall('Certificates'.toUpperCase()),
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
    return FutureBuilder<List<UserCertificate>>(
      future: certificates,
      builder: (context, snapshot) {
         if (snapshot.hasData) {
          final certificatess = snapshot.data!;
          return ListView.builder(
            itemCount: certificatess.length,
            itemBuilder: (context, index) {
              final certificate = certificatess[index];
              return ListTile(
                title: Text(certificate.name),
                trailing: Wrap(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showModal(true, certificate);
                      },
                      child: Icon(Icons.edit_calendar_outlined,color: appColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showDeleteConfirmationDialog(certificate);
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

  void _showModal(bool isUpdate, [UserCertificate? certificate]) {
    final certificateNameController = TextEditingController();
    final institutionNameController = TextEditingController();
    String dateString = (certificate?.issueDate).toString();

    if (isUpdate) {
      certificateNameController.text = certificate!.name;
      institutionNameController.text = certificate.institution;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: (
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: certificateNameController,
                    decoration: const InputDecoration(
                      hintText: 'Certificate Name',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: institutionNameController,
                    decoration: const InputDecoration(
                      hintText: 'Institution Name',
                    ),
                  ),
                  const SizedBox(height: 16),
                  DateTimePicker(
                    type: DateTimePickerType.date,
                    initialValue: dateString,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    dateLabelText: 'Select Date',
                    onChanged: (val) {
                      dateString = val;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final name = certificateNameController.text;
                      final institution = institutionNameController.text;
                      final date = dateString;

                      if (name.isNotEmpty && institution.isNotEmpty) {
                        final infoCertificate = {
                          "name": name,
                          "institution": institution,
                          "issue_date": date,
                        };
                        if (isUpdate) {
                          _userCertificatesService.update(certificate!.id, infoCertificate).then((value) => {
                            _updateCertificates(),
                            Navigator.pop(context),
                          });
                        } else {
                          _userCertificatesService.store(infoCertificate).then((value) => {
                            _updateCertificates(),
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
            )
          ),
        );
      },
    );

  }

  void _showDeleteConfirmationDialog(UserCertificate certificate) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Certificate"),
          content: const Text("Are you sure you want to delete this certificate?"),
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
                _userCertificatesService.destroy(certificate.id).then((value) => {
                  _updateCertificates(),
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
