import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../models/User/Certificate/Certificate_Destroy.dart';


class CertificateDestroyService {

  String? apiUrl;

  var headers;

  CertificateDestroyService(String token, int userId, int certificateId){
    this.apiUrl = "https://compassionate-mahavira.213-142-157-85.plesk.page/api/v1/$userId/certificates/$certificateId";
    this.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }


  Future<List<CertificateDestroy>> destroyCertificates() async {
    final response = await http.delete(Uri.parse(apiUrl!),headers: headers);
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