import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jobfinder/models/User/UserProfile.dart';
import 'package:jobfinder/services/AbstractService.dart';

class UserProfileService extends AbstractService {
  UserProfileService(String token, int userId)
      : super(token: token, userId: userId);

  @override
  String get apiUrl => super.apiUrl + "/user";


  Future<UserProfile> show(int profileId) async {
    String requestUrl = apiUrl + "/$profileId?all_detail=true";

    final response = await http.get(Uri.parse(requestUrl), headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      return UserProfile.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to load profiles');
    }
  }
}