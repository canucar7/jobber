import 'package:http/http.dart' as http;
import 'package:jobfinder/models/User/Certificate/Certificate_Destroy.dart';
import 'dart:convert';

import 'package:jobfinder/models/User/Certificate/Certificate_Index.dart';
import 'package:jobfinder/models/User/Certificate/Certificate_Show.dart';
import 'package:jobfinder/models/User/Certificate/Certificate_Store.dart';
import 'package:jobfinder/models/User/Certificate/Certificate_Update.dart';
import 'package:jobfinder/services/AbstractService.dart';

class UserCertificatesService extends AbstractService {
  UserCertificatesService(String token, int userId)
      : super(token: token, userId: userId);

  @override
  String get apiUrl => super.apiUrl + "/$userId/certificates";

  Future<List<CertificateIndex>> index() async {
    final response = await http.get(Uri.parse(apiUrl),headers: headers);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      List<CertificateIndex> certificates = [];
      for (var certificate in jsonData['data']) {
        certificates.add(CertificateIndex.fromJson(certificate));
      }

      return certificates;
    } else {
      throw Exception('Failed to load certificates');
    }
  }

  Future<List<CertificateStore>> storeCertificates(String name, String institution,String date) async {
    final response = await http.post(Uri.parse(apiUrl),headers: headers,body: {"name":name,"institution":institution,"date":date });

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      List<CertificateStore> certificates = [];
      for (var certificate in jsonData['data']) {
        certificates.add(CertificateStore.fromJson(certificate));
      }

      return certificates;
    } else {
      throw Exception('Failed to load certificates');
    }
  }

  Future<List<CertificateShow>> show(int certificateId) async {
    apiUrl = apiUrl + "/$certificateId";
    final response = await http.get(Uri.parse(apiUrl),headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      List<CertificateShow> certificates = [];
      for (var certificate in jsonData['data']) {
        certificates.add(CertificateShow.fromJson(certificate));
      }

      return certificates;
    } else {
      throw Exception('Failed to load certificates');
    }
  }

  Future<List<CertificateUpdate>> update(int certificateId) async {
    apiUrl = apiUrl + "/$certificateId";
    final response = await http.put(Uri.parse(apiUrl),headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      List<CertificateUpdate> certificates = [];
      for (var certificate in jsonData['data']) {
        certificates.add(CertificateUpdate.fromJson(certificate));
      }

      return certificates;
    } else {
      throw Exception('Failed to load certificates');
    }
  }

  Future<List<CertificateDestroy>> destroy(int certificateId) async {
    apiUrl = apiUrl + "/$certificateId";
    final response = await http.delete(Uri.parse(apiUrl),headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      List<CertificateDestroy> certificates = [];
      for (var certificate in jsonData['data']) {
        certificates.add(CertificateDestroy.fromJson(certificate));
      }

      return certificates;
    } else {
      throw Exception('Failed to load certificates');
    }
  }
}