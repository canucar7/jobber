import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../models/Location/Cities.dart';


class CityService {
  String? apiUrl;



  var headers;

  CityService(String token, int countryId){
    this.apiUrl = "https://compassionate-mahavira.213-142-157-85.plesk.page/api/v1/location/cities?country_id=$countryId";
    this.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<City>> getCities() async {
    final response = await http.get(Uri.parse(apiUrl!),headers: headers);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<City> certificates = [];
      for (var certificate in jsonData['data']) {
        certificates.add(City.fromJson(certificate));
      }
      return certificates;
    } else {
      throw Exception('Failed to load certificates');
    }
  }
}