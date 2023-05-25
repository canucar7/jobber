import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:jobfinder/helpers/date_helper.dart';
import 'package:jobfinder/models/Message/Conversation.dart';
import 'package:jobfinder/models/Message/Message.dart';
import 'package:jobfinder/pages/chat.dart';
import 'package:jobfinder/provider/UserProvider.dart';
import 'package:jobfinder/services/Message/MessageService.dart';
import 'package:jobfinder/widget/navbar.dart';
import 'package:provider/provider.dart';
import '../components/styles.dart';

class Inbox extends StatefulWidget {
  static const String id = 'Inbox';

  const Inbox({Key? key}) : super(key: key);

  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  late String _authToken;
  late int _userId;
  late MessageService _messageService;

  late List<Conversation>? conversations = null;
  Map<int, String>? lastMessages = {};

  @override
  void initState() {
    super.initState();
    _authToken = context.read<UserProvider>().auth!.accessToken;
    _userId = context.read<UserProvider>().auth!.user.id;
    _messageService = MessageService(_authToken, _userId);
    getConversations();
  }

  void getConversations() async {
    List<Conversation> fetchConversations = await _messageService.index();
    setState(() {
      conversations = fetchConversations;
      fetchConversations.forEach((conversation) {
        lastMessages![conversation.id] = '...';
      });
    });
    getLastMessages();
  }

  void getLastMessages() async {
    lastMessages?.forEach((key, value) async {
      List<Message> fetchMessages = await _messageService.show(key);
      DateTime dateTime = DateTime.parse(fetchMessages.last.createdAt);
      setState(() {
        lastMessages![key] ='${dateTime.day} ${DateHelper.getMonthName(dateTime.month)} ${DateHelper.formatHourMinute(dateTime.hour, dateTime.minute)}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('MESSAGES'),
          centerTitle: true,
          titleSpacing: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[appColor2, appColor]),
            ),
          ),
          elevation: 0,
        ),
        body: conversations == null ? Center(child: CircularProgressIndicator()) : _buildBody());
  }

  Widget _buildBody() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: conversations!.length,
      itemBuilder: (context, i) => Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                      Chat(
                        conversationId: conversations![i].id,
                        advertisementId: conversations![i].advertisementId,
                        oppositeUserId: conversations![i].user1Id == _userId
                          ? conversations![i].user2.id
                          : conversations![i].user1.id,)));
            },
            leading: CircleAvatar(
              child: Icon(
                conversations![i].advertisement?.company != null ? Icons.maps_home_work_outlined : Icons.person,
                size: 32,
                color: Colors.white,
              ),
              backgroundColor: Colors.blue,
              radius: 22,
            ),
            title: boldText(conversations![i].user1Id == _userId
                ? conversations![i].user2.name
                : conversations![i].user1.name),
            subtitle: greyTextSmall(conversations![i].advertisement?.job != null ? conversations![i].advertisement?.job?.name : conversations![i].advertisement?.jobTitle),
            trailing: greyTextSmall(lastMessages![conversations![i].id] ?? ''),
          ),
          const Divider(thickness: 1, color: backgroundColor)
        ],
      ),
    );
  }
}
