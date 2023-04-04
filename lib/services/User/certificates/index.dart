import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../models/User/Certificate/Certificate_Index.dart';


class CertificateIndexService {
  String? apiUrl;



  var headers;

  CertificateIndexService(String token, int userId){
    this.apiUrl = "https://compassionate-mahavira.213-142-157-85.plesk.page/api/v1/$userId/certificates";
    this.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<CertificateIndex>> fetchCertificates() async {
    final response = await http.get(Uri.parse(apiUrl!),headers: headers);
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
}