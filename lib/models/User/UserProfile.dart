import 'package:jobfinder/models/Advertisement/AdvertisementInformation.dart';
import 'package:jobfinder/models/CompanyInformation.dart';
import 'package:jobfinder/models/User/UserAddress.dart';
import 'package:jobfinder/models/User/UserCertificate.dart';
import 'package:jobfinder/models/User/UserForeignLanguage.dart';

class UserProfile {
  int id;
  String name;
  String email;
  DateTime? emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  List<UserAddress> addresses;
  List<CompanyInformation> companies;
  List<UserForeignLanguage> foreignLanguages;
  List<AdvertisementInformation> advertisements;
  List<UserCertificate> certificates;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.addresses,
    required this.companies,
    required this.foreignLanguages,
    required this.advertisements,
    required this.certificates,
  });

  UserProfile.fromJson(Map<String, dynamic> json) :
      id= json['id'],
      name= json['name'],
      email= json['email'],
      emailVerifiedAt= json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'])
          : null,
      createdAt= DateTime.parse(json['created_at']),
      updatedAt= DateTime.parse(json['updated_at']),
      addresses= List<UserAddress>.from(
        json['addresses'].map((addressJson) => UserAddress.fromJson(addressJson)),
      ),
      companies= List<CompanyInformation>.from(
        json['companies'].map((companyJson) => CompanyInformation.fromJson(companyJson)),
      ),
      foreignLanguages= List<UserForeignLanguage>.from(
        json['foreign_languages']
            .map((languageJson) => UserForeignLanguage.fromJson(languageJson)),
      ),
      advertisements= List<AdvertisementInformation>.from(
        json['advertisements']
            .map((adJson) => AdvertisementInformation.fromJson(adJson)),
      ),
      certificates= List<UserCertificate>.from(
        json['certificates']
            .map((adJson) => UserCertificate.fromJson(adJson)),
      );



}




