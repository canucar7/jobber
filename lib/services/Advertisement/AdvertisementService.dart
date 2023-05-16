import 'package:http/http.dart' as http;
import 'package:jobfinder/models/Advertisement/Advertisement.dart';
import 'dart:convert';

import 'package:jobfinder/services/AbstractService.dart';

class AdvertisementService extends AbstractService {
  AdvertisementService(String token, int userId)
      : super(token: token, userId: userId);

  @override
  String get apiUrl => super.apiUrl + "/advertisements";

  Future<List<Advertisement>> activeByAddress(int addressId) async {
    final response = await http.get(Uri.parse(apiUrl+"?address_id=$addressId"),headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      List<Advertisement> advertisements = [];
      for (var advertisement in jsonData['data']) {
        advertisements.add(Advertisement.fromJson(advertisement));
      }

      return advertisements;
    } else {
      throw Exception('Failed to load advertisements');
    }
  }

  Future<List<Advertisement>> activeByAddressAndJob(int addressId, int jobId) async {
    final response = await http.get(Uri.parse(apiUrl+"?address_id=$addressId&job_id=$jobId"),headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      List<Advertisement> advertisements = [];
      for (var advertisement in jsonData['data']) {
        advertisements.add(Advertisement.fromJson(advertisement));
      }

      return advertisements;
    } else {
      throw Exception('Failed to load advertisements');
    }
  }

  Future<List<Advertisement>> activeByAddressAndCompany(int addressId, int companyId) async {
    final response = await http.get(Uri.parse(apiUrl+"?address_id=$addressId&company_id=$companyId"),headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      List<Advertisement> advertisements = [];
      for (var advertisement in jsonData['data']) {
        advertisements.add(Advertisement.fromJson(advertisement));
      }

      return advertisements;
    } else {
      throw Exception('Failed to load advertisements');
    }
  }

  Future<Advertisement> store(body) async {
    print(body);
    final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: body);

    print(response.body);
    if (response.statusCode == 201) {
      final jsonData = json.decode(response.body);

      return Advertisement.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to store advertisements');
    }
  }

  Future<Advertisement> show(int advertisementId) async {
    String requestUrl = apiUrl + "/$advertisementId";

    final response = await http.get(Uri.parse(requestUrl),headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      return Advertisement.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to load advertisements');
    }
  }
}