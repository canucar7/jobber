import 'package:jobfinder/models/Advertisement/Advertisement.dart';
import 'package:jobfinder/models/User/UserAddress.dart';
import 'package:jobfinder/models/User/UserCompany.dart';
import 'package:jobfinder/models/User/UserForeignLanguage.dart';

class UserProfile {
  int id;
  String name;
  String email;
  DateTime? emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  List<UserAddress> addresses;
  List<UserCompany> companies;
  List<UserForeignLanguage> foreignLanguages;
  List<Advertisement> advertisements;

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
      companies= List<UserCompany>.from(
        json['companies'].map((companyJson) => UserCompany.fromJson(companyJson)),
      ),
      foreignLanguages= List<UserForeignLanguage>.from(
        json['foreign_languages']
            .map((languageJson) => UserForeignLanguage.fromJson(languageJson)),
      ),
      advertisements= List<Advertisement>.from(
        json['advertisements']
            .map((adJson) => Advertisement.fromJson(adJson)),
      );


}




