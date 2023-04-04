import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../models/User/ForeignLanguage/ForeignLanguage_Destroy.dart';


class LanguageDestroyService {
  String? apiUrl;



  var headers;

  LanguageDestroyService(String token, int userId, int languageId){
    this.apiUrl = "https://compassionate-mahavira.213-142-157-85.plesk.page/api/v1/$userId/foreign-languages/$languageId";
    this.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<LanguageDestroy>> destroyCertificates() async {
    final response = await http.delete(Uri.parse(apiUrl!),headers: headers);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<LanguageDestroy> certificates = [];
      for (var certificate in jsonData['data']) {
        certificates.add(LanguageDestroy.fromJson(certificate));
      }
      return certificates;
    } else {
      throw Exception('Failed to load certificates');
    }
  }
}