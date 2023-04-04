import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../models/User/ForeignLanguage/ForeignLanguage_Store.dart';


class LanguageStoreService {
  String? apiUrl;



  var headers;

  LanguageStoreService(String token, int userId){
    this.apiUrl = "https://compassionate-mahavira.213-142-157-85.plesk.page/api/v1/$userId/foreign-languages";
    this.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<LanguageStore>> storeCertificates() async {
    final response = await http.post(Uri.parse(apiUrl!),headers: headers);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<LanguageStore> certificates = [];
      for (var certificate in jsonData['data']) {
        certificates.add(LanguageStore.fromJson(certificate));
      }
      return certificates;
    } else {
      throw Exception('Failed to load certificates');
    }
  }
}