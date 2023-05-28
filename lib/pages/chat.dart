import 'package:flutter/material.dart';
import 'package:jobfinder/helpers/date_helper.dart';
import 'package:jobfinder/models/Message/Message.dart';
import 'package:jobfinder/provider/UserProvider.dart';
import 'package:jobfinder/services/Message/MessageService.dart';
import 'package:provider/provider.dart';
import '../components/styles.dart';

class Chat extends StatefulWidget {
  static const String id = 'Chat';
  final int conversationId;
  final int oppositeUserId;
  final int advertisementId;

  const Chat({
    Key? key,
    required this.conversationId,
    required this.oppositeUserId,
    required this.advertisementId
  }) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController _messageController = TextEditingController();

  late String _authToken;
  late int _userId;
  late MessageService _messageService;

  late List<Message>? messages = null;
  String messageTitle = '';

  @override
  void initState() {
    super.initState();
    _authToken = context.read<UserProvider>().auth!.accessToken;
    _userId = context.read<UserProvider>().auth!.user.id;
    _messageService = MessageService(_authToken, _userId);
    getMessages();
  }

  void getMessages() async {
    List<Message> fetchMessages = await _messageService.show(widget.conversationId);
    setState(() {
      messages = fetchMessages;
      try {
        messageTitle = messages!.firstWhere((message) => message.userId == widget.oppositeUserId).user.name;
      } catch (e) {
        messageTitle = "";
      }
    });
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      scrollToBottom();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _scrollController.addListener(() {
        if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
            !_scrollController.position.outOfRange) {
        }
      });

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          // title: messages == null ? Text('') : Text(messages!.firstWhere((message) => message.userId == widget.oppositeUserId) != null ? messages!.firstWhere((message) => message.userId == widget.oppositeUserId).user.name.toUpperCase() : ''),
          title:  Text(messageTitle),
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
        bottomNavigationBar: _buildBottom(),
        body: messages == null ? Center(child: CircularProgressIndicator()) : _buildBody());
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: messages!.map<Widget>((Message msg) {
          return msg.userId != _userId
              ? Container(
            margin: const EdgeInsets.only(bottom: 16),
            width: MediaQuery.of(context).size.width - 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                const CircleAvatar(
                  backgroundColor: appColor,
                  child: Icon(
                    Icons.person,
                    size: 14,
                    color: Colors.white,
                  ),
                  radius: 12,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16),
                            topLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: Text(
                          msg.content,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 16, top: 6),
                        child: smallText('${DateTime.parse(msg.createdAt).day} ${DateHelper.getMonthName(DateTime.parse(msg.createdAt).month)} ${DateHelper.formatHourMinute(DateTime.parse(msg.createdAt).hour, DateTime.parse(msg.createdAt).minute)}'),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                width: MediaQuery.of(context).size.width - 120,
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: <Color>[appColor2, appColor],
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(16),
                                    topLeft: Radius.circular(16),
                                    bottomLeft: Radius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  msg.content,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    right: 10, top: 6),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.end,
                                  children: [
                                    smallText('${DateTime.parse(msg.createdAt).day} ${DateHelper.getMonthName(DateTime.parse(msg.createdAt).month)} ${DateHelper.formatHourMinute(DateTime.parse(msg.createdAt).hour, DateTime.parse(msg.createdAt).minute)}'),
                                    const SizedBox(width: 4),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }


  Widget _buildBottom() {
    return SingleChildScrollView(
      reverse: true,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                ),
                child: TextField(
                  controller: _messageController,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  cursorColor: appColor,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Write message',
                      hintStyle: TextStyle(color: Colors.black, fontSize: 12)),
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                setState(() {
                  messages = null;
                });
                FocusScope.of(context).unfocus();
                final data = {
                  "user1_id": _userId.toString(),
                  "user2_id": widget.oppositeUserId.toString(),
                  "advertisement_id": widget.advertisementId.toString(),
                  "content": _messageController.text.toString(),
                };
                _messageService.store(data).then((value) => {
                  getMessages(),
                  _messageController.clear(),
                });
              },
              child: const CircleAvatar(
                backgroundColor: appColor,
                radius: 24,
                child: Icon(Icons.near_me, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Item {
  const Item(this.side, this.msg);
  final String side;
  final String msg;
}
