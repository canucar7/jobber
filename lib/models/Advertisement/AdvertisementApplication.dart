import 'package:jobfinder/models/Advertisement/Advertisement.dart';

class AdvertisementApplication {
  Advertisement advertisement;
  User user;
  int id;
  int advertisementId;
  int status;
  DateTime createdAt;
  DateTime? updatedAt;

  AdvertisementApplication({
    required this.advertisement,
    required this.user,
    required this.id,
    required this.advertisementId,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });

  AdvertisementApplication.fromJson(Map<String, dynamic> json) :
    advertisement= Advertisement.fromJson(json['advertisement']),
    user= User.fromJson(json['user']),
    id= json['id'],
    advertisementId= json['advertisement_id'],
    status= json['status'],
    createdAt= DateTime.parse(json['created_at']),
    updatedAt= json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;
}