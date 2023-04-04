import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jobfinder/provider/UserProvider.dart';
import 'package:provider/provider.dart';

import '../../../models/User/Certificate/Certificate_Store.dart';


class CertificateStoreService {

  String? apiUrl;

  var headers;

  CertificateStoreService(String token,int userId){
    this.apiUrl = "https://compassionate-mahavira.213-142-157-85.plesk.page/api/v1/$userId/certificates";
    this.headers = {
      'Content-type' : 'application/json',
      'Authorization': 'Bearer $token',
    };
  }


  Future<List<CertificateStore>> storeCertificates(String name, String institution,String date) async {
    final response = await http.post(Uri.parse(apiUrl!),headers: headers,body: {"name":name,"institution":institution,"date":date });
    print(response.body);
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
}