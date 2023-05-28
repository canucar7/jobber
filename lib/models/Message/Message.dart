import 'package:jobfinder/models/Advertisement/Advertisement.dart';

class Message {
  int id;
  int conversationId;
  int? userId;
  String content;
  String createdAt;
  String? updatedAt;
  User user;

  Message({
    required this.id,
    required this.conversationId,
    this.userId,
    required this.content,
    required this.createdAt,
    this.updatedAt,
    required this.user,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      conversationId: json['conversation_id'],
      userId: int.tryParse(json['user_id'].toString()),
      content: json['content'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'] !=null ? json['updated_at'] : null,
      user: User.fromJson(json['user']),
    );
  }
}
