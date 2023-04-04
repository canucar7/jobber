import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../models/User/ForeignLanguage/ForeignLanguage_Index.dart';


class LanguageIndexService {
  String? apiUrl;



  var headers;

  LanguageIndexService(String token, int userId){
    this.apiUrl = "https://compassionate-mahavira.213-142-157-85.plesk.page/api/v1/$userId/foreign-languages";
    this. headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<LanguageIndex>> fetchCertificates() async {
    final response = await http.get(Uri.parse(apiUrl!),headers: headers);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<LanguageIndex> certificates = [];
      for (var certificate in jsonData['data']) {
        certificates.add(LanguageIndex.fromJson(certificate));
      }
      return certificates;
    } else {
      throw Exception('Failed to load certificates');
    }
  }
}