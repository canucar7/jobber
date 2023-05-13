import 'package:jobfinder/models/Advertisement/Job.dart';
import 'package:jobfinder/models/User/UserAddress.dart';

class Advertisement {
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
  User user;
  Company? company;
  Job? job;
  UserAddress address;

  Advertisement({
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
    required this.user,
    this.company,
    this.job,
    required this.address,
  });

  Advertisement.fromJson(Map<String, dynamic> json) :
      id= json['id'],
      userId= json['user_id'],
      companyId= json['company_id'] != null ? int.parse(json['company_id'].toString()) : null,
      purpose= int.parse(json['purpose'].toString()),
      status= json['status'],
      jobId= json['job_id'] != null ? int.parse(json['job_id']) : null,
      jobTitle= json['job_title'] != null ? (json['job_title'].toString()) : null,
      employmentType= json['employment_type'].toString(),
      description= json['description'] != null ? (json['description'].toString()) : null,
      period= json['period'].toString(),
      createdAt= DateTime.parse(json['created_at']),
      updatedAt= json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      publishedDate = json['published_date'] != null ? json['published_date'].toString() : null,
      user= User.fromJson(json['user']),
      company= json['company'] != null ? Company.fromJson(json['company']):null,
      job= json['job'] != null ? Job.fromJson(json['job']):null,
      address= UserAddress.fromJson(json['address']);

}

class User {
  int id;
  String name;
  String email;
  DateTime? emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) :
      id= json['id'],
      name= json['name'],
      email= json['email'],
      emailVerifiedAt= json['email_verified_at'] != null ? DateTime.parse(json['email_verified_at']) : null,
      createdAt= DateTime.parse(json['created_at']),
      updatedAt= DateTime.parse(json['updated_at']);

}
class Company {
  int id;
  int userId;
  String name;
  String description;
  String coverImageUrl;
  int phoneNumber;
  int status;
  DateTime? deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  UserAddress address;

  Company({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.coverImageUrl,
    required this.phoneNumber,
    required this.status,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.address,
  });

  Company.fromJson(Map<String, dynamic> json) :
      id= json['id'],
      userId= json['user_id'],
      name= json['name'],
      description= json['description'],
      coverImageUrl= json['cover_image_url'],
      phoneNumber= json['phone_number'],
      status= json['status'],
      deletedAt= json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
      createdAt= DateTime.parse(json['created_at']),
      updatedAt= DateTime.parse(json['updated_at']),
      address= UserAddress.fromJson(json['address']);

}
