import 'package:http/http.dart' as http;
import 'package:jobfinder/models/Advertisement/Advertisement.dart';
import 'dart:convert';

import 'package:jobfinder/services/AbstractService.dart';

class AdvertisementService extends AbstractService {
  AdvertisementService(String token, int userId)
      : super(token: token, userId: userId);

  @override
  String get apiUrl => super.apiUrl + "/advertisements";


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