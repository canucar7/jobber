import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jobfinder/models/Location/City.dart';
import 'package:jobfinder/services/AbstractService.dart';

class CityService extends AbstractService {

  CityService(String token) : super(token: token);

  @override
  String get apiUrl => super.apiUrl + "/location/cities";

  Future<List<City>> getCities(int countryId) async {
    apiUrl = apiUrl + "?country_id=$countryId";
    final response = await http.get(Uri.parse(apiUrl),headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<City> cities = [];

      for (var city in jsonData['data']) {
        cities.add(City.fromJson(city));
      }

      return cities;
    } else {
      throw Exception('Failed to load cities');
    }
  }
}