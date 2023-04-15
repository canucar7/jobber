import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:jobfinder/models/User/UserForeignLanguage.dart';
import 'package:jobfinder/services/AbstractService.dart';

class UserForeignLanguagesService extends AbstractService {
  UserForeignLanguagesService(String token, int userId)
      : super(token: token, userId: userId);

  @override
  String get apiUrl => super.apiUrl + "/$userId/foreign-languages";

  Future<List<UserForeignLanguage>> index() async {
    final response = await http.get(Uri.parse(apiUrl),headers: headers);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      List<UserForeignLanguage> foreignLanguages = [];
      for (var foreignLanguage in jsonData['data']) {
        foreignLanguages.add(UserForeignLanguage.fromJson(foreignLanguage));
      }

      return foreignLanguages;
    } else {
      throw Exception('Failed to load foreign languages');
    }
  }

  Future<UserForeignLanguage> store(body) async {
    final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: body);

    if (response.statusCode == 201) {
      final jsonData = json.decode(response.body);

      return UserForeignLanguage.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to store foreign languages');
    }
  }

  Future<UserForeignLanguage> show(int foreignLanguageId) async {
    String requestUrl = apiUrl + "/$foreignLanguageId";

    final response = await http.get(Uri.parse(requestUrl),headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      return UserForeignLanguage.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to load foreign languages');
    }
  }

  Future<UserForeignLanguage> update(int foreignLanguageId, body) async {
    String requestUrl = apiUrl + "/$foreignLanguageId";
    final response = await http.put(
        Uri.parse(requestUrl),
        headers: headers,
        body: body);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData);
      return UserForeignLanguage.fromJson(jsonData['data']);
    } else {
      print('anasının amı');
      print(response.statusCode);
      throw Exception('Failed to update foreign languages');
    }
  }

  Future<bool> destroy(int foreignLanguageId) async {
    String requestUrl = apiUrl + "/$foreignLanguageId";

    final response = await http.delete(Uri.parse(requestUrl),headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to load foreign languages');
    }
  }
}