import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../models/Location/Districts.dart';


class DistrictService {
  String? apiUrl;



  var headers;

  DistrictService(String token, int countryId, int cityId){
    this.apiUrl = "https://compassionate-mahavira.213-142-157-85.plesk.page/api/v1/location/districts?city_id=$cityId";
    this. headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<District>> getDistricts() async {
    final response = await http.get(Uri.parse(apiUrl!),headers: headers);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<District> certificates = [];
      for (var certificate in jsonData['data']) {
        certificates.add(District.fromJson(certificate));
      }
      return certificates;
    } else {
      throw Exception('Failed to load certificates');
    }
  }
}