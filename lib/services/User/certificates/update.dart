import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../models/User/Certificate/Certificate_Update.dart';


class CertificateUpdateService {

  String? apiUrl;

  var headers;

  CertificateUpdateService(String token, int userId, int certificateId){
    this.apiUrl = "https://compassionate-mahavira.213-142-157-85.plesk.page/api/v1/$userId/certificates/$certificateId";
    this.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }


  Future<List<CertificateUpdate>> storeCertificates() async {
    final response = await http.put(Uri.parse(apiUrl!),headers: headers);
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
}