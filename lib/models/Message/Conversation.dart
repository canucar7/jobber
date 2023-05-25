import 'package:jobfinder/models/Advertisement/Advertisement.dart';

class Conversation {
  Advertisement advertisement;
  User user1;
  User user2;
  int id;
  int advertisementId;
  int user1Id;
  int user2Id;
  String createdAt;
  String? updatedAt;

  Conversation({
    required this.advertisement,
    required this.user1,
    required this.user2,
    required this.id,
    required this.advertisementId,
    required this.user1Id,
    required this.user2Id,
    required this.createdAt,
    this.updatedAt,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      advertisement: Advertisement.fromJson(json['advertisement']),
      user1: User.fromJson(json['user_1']),
      user2: User.fromJson(json['user_2']),
      id: json['id'],
      advertisementId: json['advertisement_id'],
      user1Id: json['user1_id'],
      user2Id: json['user2_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'] != null ? json['updated_at'] : null,
    );
  }
}