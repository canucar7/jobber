import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:jobfinder/models/User/UserCertificate.dart';
import 'package:jobfinder/services/AbstractService.dart';

class UserCertificatesService extends AbstractService {
  UserCertificatesService(String token, int userId)
      : super(token: token, userId: userId);

  @override
  String get apiUrl => super.apiUrl + "/$userId/certificates";

  Future<List<UserCertificate>> index() async {
    final response = await http.get(Uri.parse(apiUrl),headers: headers);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      List<UserCertificate> certificates = [];
      for (var certificate in jsonData['data']) {
        certificates.add(UserCertificate.fromJson(certificate));
      }

      return certificates;
    } else {
      throw Exception('Failed to load certificates');
    }
  }

  Future<UserCertificate> store(String name, String institution,String date) async {
    final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: {
          "name": name,
          "institution": institution,
          "date": date
        });

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      return UserCertificate.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to store certificates');
    }
  }

  Future<UserCertificate> show(int certificateId) async {
    apiUrl = apiUrl + "/$certificateId";
    final response = await http.get(Uri.parse(apiUrl),headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      return UserCertificate.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to load certificates');
    }
  }

  Future<UserCertificate> update(int certificateId) async {
    apiUrl = apiUrl + "/$certificateId";
    final response = await http.put(Uri.parse(apiUrl),headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      return UserCertificate.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to load certificates');
    }
  }

  Future<bool> destroy(int certificateId) async {
    apiUrl = apiUrl + "/$certificateId";
    final response = await http.delete(Uri.parse(apiUrl),headers: headers);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to load certificates');
    }
  }
}