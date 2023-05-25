import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:jobfinder/models/Message/Conversation.dart';
import 'package:jobfinder/models/Message/Message.dart';
import 'package:jobfinder/services/AbstractService.dart';

class MessageService extends AbstractService {
  MessageService(String token, int userId)
      : super(token: token, userId: userId);

  @override
  String get apiUrl => super.apiUrl + "/messages";

  Future<List<Conversation>> index() async {
    final response = await http.get(Uri.parse(apiUrl),headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      List<Conversation> conversations = [];
      for (var conversation in jsonData['data']) {
        conversations.add(Conversation.fromJson(conversation));
      }

      return conversations;
    } else {
      throw Exception('Failed to load conversations');
    }
  }

  Future<Message> store(body) async {
    final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: body);

    if (response.statusCode == 201) {
      final jsonData = json.decode(response.body);

      return Message.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to store message');
    }
  }

  Future<List<Message>>show(int conversationId) async {
    String requestUrl = apiUrl + "/$conversationId";

    final response = await http.get(Uri.parse(requestUrl),headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      List<Message> messages = [];
      for (var message in jsonData['data']) {
        messages.add(Message.fromJson(message));
      }

      return messages;
    } else {
      throw Exception('Failed to load messages');
    }
  }


}