import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:jobfinder/models/Advertisement/AdvertisementApplication.dart';
import 'package:jobfinder/services/AbstractService.dart';

class AdvertisementApplicationService extends AbstractService {
  AdvertisementApplicationService(String token, int userId)
      : super(token: token, userId: userId);

  @override
  String get apiUrl => super.apiUrl + "/advertisement-applications";

  Future<List<AdvertisementApplication>> index() async {
    final response = await http.get(Uri.parse(apiUrl),headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      List<AdvertisementApplication> advertisements = [];
      for (var advertisement in jsonData['data']) {
        advertisements.add(AdvertisementApplication.fromJson(advertisement));
      }

      return advertisements;
    } else {
      throw Exception('Failed to load advertisement applications');
    }
  }

  Future<AdvertisementApplication> store(int advertisementId) async {
    final response = await http.post(
        Uri.parse(apiUrl+"/$advertisementId/apply"), headers: headers);

    if (response.statusCode == 201) {
      final jsonData = json.decode(response.body);

      return AdvertisementApplication.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to store advertisement applications');
    }
  }

}