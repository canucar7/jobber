import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../models/User/Certificate/Certificate_Show.dart';


class CertificateShowService {

  String? apiUrl;

  var headers;

  CertificateShowService(String token, int userId, int certificateId){
    this.apiUrl = "https://compassionate-mahavira.213-142-157-85.plesk.page/api/v1/$userId/certificates/$certificateId";
    this.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      };
  }


  Future<List<CertificateShow>> showCertificates() async {
    final response = await http.get(Uri.parse(apiUrl!),headers: headers);
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
}