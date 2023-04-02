import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../models/User/ForeignLanguage/ForeignLanguage_Store.dart';


class CertificateService {
  String? apiUrl;



  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2NvbXBhc3Npb25hdGUtbWFoYXZpcmEuMjEzLTE0Mi0xNTctODUucGxlc2sucGFnZS9hcGkvdjEvYXV0aC9sb2dpbiIsImlhdCI6MTY4MDI4MDkzOCwiZXhwIjoxNjgwMjg0NTM4LCJuYmYiOjE2ODAyODA5MzgsImp0aSI6InpLRHp5aW81VGpZNXNURjMiLCJzdWIiOiIxIiwicHJ2IjoiYjkxMjc5OTc4ZjExYWE3YmM1NjcwNDg3ZmZmMDFlMjI4MjUzZmU0OCIsImRhdGEiOnsidXNlcklkIjoxfX0.2FpW_egSUybn8_UjR3r5FnI4g2w9FwO7oq6hJ7gu7kE',
  };

  CertificateService(int userId){
    this.apiUrl = "https://compassionate-mahavira.213-142-157-85.plesk.page/api/v1/$userId/foreign-languages";
  }

  Future<List<LanguageStore>> fetchCertificates() async {
    final response = await http.get(Uri.parse(apiUrl!),headers: headers);
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