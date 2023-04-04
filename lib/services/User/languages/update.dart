import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../models/User/ForeignLanguage/ForeignLanguage_Update.dart';


class LanguageUpdateService {
  String? apiUrl;



  var headers;

  LanguageUpdateService(String token, int userId, int languageId){
    this.apiUrl = "https://compassionate-mahavira.213-142-157-85.plesk.page/api/v1/$userId/foreign-languages/$languageId";
    this.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<LanguageUpdate>> updateCertificates() async {
    final response = await http.put(Uri.parse(apiUrl!),headers: headers);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<LanguageUpdate> certificates = [];
      for (var certificate in jsonData['data']) {
        certificates.add(LanguageUpdate.fromJson(certificate));
      }
      return certificates;
    } else {
      throw Exception('Failed to load certificates');
    }
  }
}