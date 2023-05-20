import 'package:jobfinder/models/Advertisement/Job.dart';
import 'package:jobfinder/models/User/UserAddress.dart';

class AdvertisementInformation {
  int id;
  int userId;
  int? companyId;
  int purpose;
  int status;
  int? jobId;
  String? jobTitle;
  String employmentType;
  String? description;
  String period;
  DateTime createdAt;
  DateTime? updatedAt;
  String? publishedDate;

  AdvertisementInformation({
    required this.id,
    required this.userId,
    this.companyId,
    required this.purpose,
    required this.status,
    this.jobId,
    this.jobTitle,
    required this.employmentType,
    this.description,
    required this.period,
    required this.createdAt,
    this.updatedAt,
    this.publishedDate,
  });

  AdvertisementInformation.fromJson(Map<String, dynamic> json) :
      id= json['id'],
      userId= json['user_id'],
      companyId= json['company_id'] != null ? int.parse(json['company_id'].toString()) : null,
      purpose= int.parse(json['purpose'].toString()),
      status= json['status'],
      jobId= json['job_id'] != null ? int.parse(json['job_id'].toString()) : null,
      jobTitle= json['job_title'] != null ? (json['job_title'].toString()) : null,
      employmentType= json['employment_type'].toString(),
      description= json['description'] != null ? (json['description'].toString()) : null,
      period= json['period'].toString(),
      createdAt= DateTime.parse(json['created_at']),
      updatedAt= json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      publishedDate = json['published_date'] != null ? json['published_date'].toString() : null;

}

