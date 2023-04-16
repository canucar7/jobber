import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jobfinder/components/styles.dart';
import 'package:jobfinder/enums.dart';
import 'package:jobfinder/models/User/UserForeignLanguage.dart';
import 'package:jobfinder/provider/UserProvider.dart';
import 'package:jobfinder/services/User/UserForeignLanguage.dart';
import 'package:provider/provider.dart';

class UserForeignLanguages extends StatefulWidget {
  const UserForeignLanguages({Key? key}) : super(key: key);

  @override
  State<UserForeignLanguages> createState() => _UserForeignLanguagesState();
}

class _UserForeignLanguagesState extends State<UserForeignLanguages> {
  late String _authToken;
  late int _userId;
  late UserForeignLanguagesService _userForeignLanguagesService;

  late Future<List<UserForeignLanguage>> foreignLanguages;

  @override
  void initState() {
    super.initState();
    _authToken = context.read<UserProvider>().auth!.accessToken;
    _userId = context.read<UserProvider>().auth!.user.id;
    _userForeignLanguagesService = UserForeignLanguagesService(_authToken, _userId);
    foreignLanguages = _userForeignLanguagesService.index();
  }

  void _updateForeignLanguages() {
    setState(() {
      foreignLanguages = _userForeignLanguagesService.index();
    });
  }

  final TextEditingController textController = new TextEditingController();

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
    return FutureBuilder<List<UserForeignLanguage>>(
      future: foreignLanguages,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final foreignLanguagess = snapshot.data!;
          return ListView.builder(
            itemCount: foreignLanguagess.length,
            itemBuilder: (context, index) {
              final foreignLanguage = foreignLanguagess[index];
              return ListTile(
                title: Text(foreignLanguage.languageName),
                trailing: Wrap(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showModal(true, foreignLanguage);
                      },
                      child: Icon(Icons.edit_calendar_outlined),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showDeleteConfirmationDialog(foreignLanguage);
                      },
                      child: Icon(Icons.delete),
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

  void _showModal(bool isUpdate, [UserForeignLanguage? foreignLanguage]) {
    String? _selectedLanguage = Enums.foreignLanguages.values.first;
    String? _selectedLanguageLevel = Enums.foreignLanguageLevels.values.first;

    if (isUpdate) {
      _selectedLanguage = Enums.foreignLanguages[foreignLanguage!.language];
      _selectedLanguageLevel = Enums.foreignLanguageLevels[foreignLanguage!.level];
    }

    showModalBottomSheet(context: context, builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _selectedLanguage != null ? Enums.foreignLanguages.entries.firstWhere((element) => element.value == _selectedLanguage).key : null,
                decoration: InputDecoration(labelText: 'Select a language'),
                onChanged: (int? newValue) {
                  setState(() {
                    _selectedLanguage = Enums.foreignLanguages[newValue!];
                  });
                },
                items: Enums.foreignLanguages.entries.map((MapEntry<int, String> entry) {
                  return DropdownMenuItem<int>(
                    value: entry.key,
                    child: Text(entry.value),
                  );
                }).toList(),
              ),
              DropdownButtonFormField<int>(
                value: _selectedLanguageLevel != null ? Enums.foreignLanguageLevels.entries.firstWhere((element) => element.value == _selectedLanguageLevel).key : null,
                decoration: InputDecoration(labelText: 'Select a language level'),
                onChanged: (int? newValueLevel) {
                  setState(() {
                    _selectedLanguageLevel = Enums.foreignLanguageLevels[newValueLevel!];
                  });
                },
                items: Enums.foreignLanguageLevels.entries.map((MapEntry<int, String> entry) {
                  return DropdownMenuItem<int>(
                    value: entry.key,
                    child: Text(entry.value),
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: () {
                  var language = Enums.foreignLanguages.entries.firstWhere((element) => element.value == _selectedLanguage).key;
                  var languageLevel = Enums.foreignLanguageLevels.entries.firstWhere((element) => element.value == _selectedLanguageLevel).key;
                  
                  if (language > 0 && languageLevel >= 0) {
                    Map infoForeignLanguage = {
                      "language": language.toString(),
                      "level": languageLevel.toString()
                    };

                    if (isUpdate) {
                      _userForeignLanguagesService.update(foreignLanguage!.id, infoForeignLanguage).then((value) => {
                        _updateForeignLanguages(),
                        Navigator.pop(context),
                      });
                    } else {
                      _userForeignLanguagesService.store(jsonEncode(infoForeignLanguage)).then((value) => {
                        _updateForeignLanguages(),
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
        );

      });
    },
    );
  }

  void _showDeleteConfirmationDialog(UserForeignLanguage foreignLanguage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Foreign Language"),
          content: const Text("Are you sure you want to delete this foreign language?"),
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
                _userForeignLanguagesService.destroy(foreignLanguage.id).then((value) => {
                  _updateForeignLanguages(),
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
