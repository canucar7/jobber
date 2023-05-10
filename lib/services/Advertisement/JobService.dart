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







}