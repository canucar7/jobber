import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:jobfinder/models/CompanyInformation.dart';
import 'package:jobfinder/models/User/UserCompany.dart';
import 'dart:convert';

import 'package:jobfinder/services/AbstractService.dart';

class UserCompanyService extends AbstractService {
  UserCompanyService(String token, int userId)
      : super(token: token, userId: userId);

  @override
  String get apiUrl => super.apiUrl + "/$userId/companies";

  Future<List<UserCompany>> index() async {
    final response = await http.get(Uri.parse(apiUrl),headers: headers);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      List<UserCompany> companies = [];
      for (var company in jsonData['data']) {
        companies.add(UserCompany.fromJson(company));
      }

      return companies;
    } else {
      throw Exception('Failed to load companies');
    }
  }

  Future<List<Map<String, dynamic>>>activeByAddress(int addressId) async {
    final response = await http.get(Uri.parse(super.apiUrl+"/companies/address/$addressId/active"),headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<Map<String, dynamic>> companies = [];
      for (var company in jsonData) {
        Map<String, dynamic> companyMap = {
          'company': CompanyInformation.fromJson(company['company']),
          'advertisement_count': company['advertisement_count']
        };
        companies.add(companyMap);
      }

      return companies;
    } else {
      throw Exception('Failed to load companies');
    }
  }

  Future<UserCompany> store(body, image) async {

    final request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.headers.addAll(headers);
    request.fields.addAll(body);


    if(image is File){
      final file = await http.MultipartFile.fromPath('cover_image', image.path);
      request.files.add(file);
    }

    final firstResponse = await request.send();
    final responseString = await firstResponse.stream.bytesToString();
    final response = http.Response(responseString, firstResponse.statusCode);


    if (response.statusCode == 201) {
      final jsonData = json.decode(response.body);

      return UserCompany.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to store companies');
    }
  }

  Future<UserCompany> show(int companyId) async {
    String requestUrl = apiUrl + "/$companyId";

    final response = await http.get(Uri.parse(requestUrl),headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      return UserCompany.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to load companies');
    }
  }

  Future<UserCompany> update(int companyId, body, image) async {

    String requestUrl = apiUrl + "/$companyId?_method=PUT";
    final request = http.MultipartRequest('POST', Uri.parse(requestUrl));
    request.headers.addAll(headers);
    request.fields.addAll(body);


    if(image is File){
      final file = await http.MultipartFile.fromPath('cover_image', image.path);
      request.files.add(file);
    }


    final firstResponse = await request.send();
    final responseString = await firstResponse.stream.bytesToString();
    final response = http.Response(responseString, firstResponse.statusCode);

    if (response.statusCode == 200) {

      final jsonData = json.decode(response.body);

      return UserCompany.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to update companies');
    }
  }

  Future<bool> destroy(int companyId) async {
    String requestUrl = apiUrl + "/$companyId";

    final response = await http.delete(Uri.parse(requestUrl),headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to load companies');
    }
  }
}