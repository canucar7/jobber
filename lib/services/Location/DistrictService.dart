import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jobfinder/models/Location/District.dart';
import 'package:jobfinder/services/AbstractService.dart';

class DistrictService extends AbstractService {
  DistrictService(String token) : super(token: token);
  
  @override
  String get apiUrl => super.apiUrl + "/location/districts";

  Future<List<District>> getDistricts(cityId) async {
    if (cityId == null) {
      return [];
    }
    final response = await http.get(Uri.parse("$apiUrl?city_id=$cityId"),headers: headers);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<District> districts = [];
      
      for (var district in jsonData['data']) {
         districts.add(District.fromJson( district));
      }
      
      return  districts;
    } else {
      throw Exception('Failed to load districts');
    }
  }
}