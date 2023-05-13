import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:jobfinder/models/User/UserAddress.dart';
import 'package:jobfinder/provider/UserProvider.dart';
import 'package:jobfinder/services/AbstractService.dart';

class UserAddressService extends AbstractService {
  UserAddressService(String token, int userId)
      : super(token: token, userId: userId);

  @override
  String get apiUrl => super.apiUrl + "/$userId/addresses";

  Future<List<UserAddress>> index() async {
    final response = await http.get(Uri.parse(apiUrl),headers: headers);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      List<UserAddress> addresses = [];
      for (var address in jsonData['data']) {
        addresses.add(UserAddress.fromJson(address));
      }

      return addresses;
    } else {
      throw Exception('Failed to load addresses');
    }
  }

  Future<UserAddress> store(body) async {
    headers['Content-Type'] = 'application/json';

    final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(body));

    if (response.statusCode == 201) {
      final jsonData = json.decode(response.body);

      return UserAddress.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to store addresses');
    }
  }

  Future<UserAddress> show(int addressId) async {
    String requestUrl = apiUrl + "/$addressId";

    final response = await http.get(Uri.parse(requestUrl),headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      return UserAddress.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to load addresses');
    }
  }

  Future<UserAddress> update(int addressId, body) async {
    String requestUrl = apiUrl + "/$addressId";

    final response = await http.put(
        Uri.parse(requestUrl),
        headers: headers,
        body: body);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      return UserAddress.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to update addresses');
    }
  }

  Future<bool> destroy(int addressId) async {
    String requestUrl = apiUrl + "/$addressId";

    final response = await http.delete(Uri.parse(requestUrl),headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to load addresses');
    }
  }

  Future<UserAddress> firstStore(body,UserProvider _userProvider) async {
    headers['Content-Type'] = 'application/json';

    final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(body));



    if (response.statusCode == 201) {
      final jsonData = json.decode(response.body);

      UserAddress _userAddress = UserAddress.fromJson(jsonData['data']);
      _userProvider.setAddress(_userAddress);
      return _userAddress;
    } else {
      throw Exception('Failed to store addresses');
    }
  }
}