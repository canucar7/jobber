import 'package:http/http.dart' as http;
import 'package:jobfinder/models/Advertisement/Job.dart';
import 'dart:convert';

import 'package:jobfinder/services/AbstractService.dart';

class JobService extends AbstractService {
  JobService(String token):super(token: token);

  @override
  String get apiUrl => super.apiUrl + "/jobs";

  Future<List<Job>> index() async {
    final response = await http.get(Uri.parse(apiUrl),headers: headers);


    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      List<Job> jobs = [];
      for (var job in jsonData ) {
        jobs.add(Job.fromJson(job));
      }
      return jobs;
    } else {
      throw Exception('Failed to load jobs');
    }
  }

  Future<List<Map<String, dynamic>>>activeByAddress(int addressId) async {
    final response = await http.get(Uri.parse(apiUrl+"/address/$addressId/active"),headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      List<Map<String, dynamic>> jobs = [];
      for (var job in jsonData) {
        Map<String, dynamic> jobMap = {
          'job': Job.fromJson(job['job'][0]),
          'advertisement_count': job['advertisement_count']
        };
        jobs.add(jobMap);
      }
      return jobs;
    } else {
      throw Exception('Failed to load jobs');
    }
  }







}