import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../models/User/Certificate/Certificate_Store.dart';


class CertificateService {

  String? apiUrl;

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2NvbXBhc3Npb25hdGUtbWFoYXZpcmEuMjEzLTE0Mi0xNTctODUucGxlc2sucGFnZS9hcGkvdjEvYXV0aC9sb2dpbiIsImlhdCI6MTY4MDQ1MDUyMiwiZXhwIjoxNjgwNDU0MTIyLCJuYmYiOjE2ODA0NTA1MjIsImp0aSI6ImdHR012M2FRZ1ZtODlYOTkiLCJzdWIiOiIxIiwicHJ2IjoiYjkxMjc5OTc4ZjExYWE3YmM1NjcwNDg3ZmZmMDFlMjI4MjUzZmU0OCIsImRhdGEiOnsidXNlcklkIjoxfX0.5CQa2J5CtA56n5qCBtSA2dSr0bLTb7KsSD-Wu6Ny_mo',
  };

  CertificateService(int userId){
    this.apiUrl = "https://compassionate-mahavira.213-142-157-85.plesk.page/api/v1/$userId/certificates";
  }


  Future<List<CertificateStore>> fetchCertificates() async {
    final response = await http.post(Uri.parse(apiUrl!),headers: headers);
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