import 'package:flutter/material.dart';
import 'package:jobfinder/models/Advertisement/AdvertisementApplication.dart';
import 'package:jobfinder/models/Message/Conversation.dart';
import 'package:jobfinder/pages/chat.dart';
import 'package:jobfinder/pages/post/job_details.dart';
import 'package:jobfinder/pages/settings/general_settings.dart';
import 'package:jobfinder/pages/user/user_profile.dart';
import 'package:jobfinder/provider/UserProvider.dart';
import 'package:jobfinder/services/Advertisement/AdvertisementApplicationService.dart';
import 'package:jobfinder/services/Advertisement/AdvertisementService.dart';
import 'package:jobfinder/services/Message/MessageService.dart';
import 'package:jobfinder/widget/elevated_button.dart';
import 'package:jobfinder/widget/navbar.dart';
import 'package:provider/provider.dart';
import '../../components/styles.dart';

class MyPostsApplications extends StatefulWidget {
  static const String id = 'MyPostsApplications';
  final int advertisementId;
  const MyPostsApplications({Key? key, required this.advertisementId}) : super(key: key);

  @override
  _MyPostsApplicationsState createState() => _MyPostsApplicationsState();
}

class _MyPostsApplicationsState extends State<MyPostsApplications> {
  late String _authToken;
  late int _userId;

  late AdvertisementService _advertisementService;
  late MessageService _messageService;

  List<AdvertisementApplication>? advertisementApplications = null;
  late List<Conversation>? conversations = null;

  @override
  void initState() {
    super.initState();
    _authToken = context.read<UserProvider>().auth!.accessToken;
    _userId = context.read<UserProvider>().auth!.user.id;
    _advertisementService = AdvertisementService(_authToken, _userId);
    _messageService = MessageService(_authToken, _userId);
    _loadAdvertisementApplications();
    getConversations();
  }

  Future<void> _loadAdvertisementApplications() async {
    List<AdvertisementApplication> loadedAdvertisementApplications = await _advertisementService.applications(widget.advertisementId);
    setState(() {
      advertisementApplications = loadedAdvertisementApplications;
    });
  }

  void getConversations() async {
    List<Conversation> fetchConversations = await _messageService.index();
    setState(() {
      conversations = fetchConversations;
    });
  }

  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Applications'),
          centerTitle: true,
          titleSpacing: 0,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const GeneralSettings()));
                },
                icon: const Icon(Icons.location_pin))
          ],
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
        body: advertisementApplications == null || loading ? Center(child: CircularProgressIndicator()) : _buildBody());
  }

  Widget _buildBody() {
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: advertisementApplications!.length,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, i) => Column(
            children: [_buildJobs(advertisementApplications![i])],
          ),
        ));
  }

  Widget _buildJobs(advertisementApplication) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  JobDetails(advertisementId: advertisementApplication.advertisement.id,)));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 20.0,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                        advertisementApplication.advertisement?.company != null ? Icons.maps_home_work_outlined : Icons.person,
                        size: 50,
                        color: appColor,
                      ),),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      blackHeadingSmall(advertisementApplication.user.name),
                    ],
                  ),
                ),
                const Icon(Icons.bookmark, color: appColor, size: 16),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  boldText(''),
                  MyElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProfiles(profileId: advertisementApplication.user.id,)));
                      },
                      text: btnText('Profile'),
                      height: 28,
                      width: 76)
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                boldText(''),
                conversations == null ? MyElevatedButton(
                  onPressed: () {},
                  text: btnText('Waiting'),
                  height: 28,
                  width: 120,) : MyElevatedButton(
                  onPressed: () async {
                    List<Conversation> foundConversations = conversations!.where((conversation) {
                      return conversation.advertisementId == widget.advertisementId &&
                          (conversation.user1Id == advertisementApplication.user.id || conversation.user2Id == advertisementApplication.user.id);
                    }).toList();

                    if (foundConversations.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Chat(
                            conversationId: foundConversations.first.id,
                            advertisementId: widget.advertisementId,
                            oppositeUserId: advertisementApplication.user.id,
                          ),
                        ),
                      );
                    } else {
                      TextEditingController messageController = TextEditingController();
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Write a message'),
                            content: TextField(
                              controller: messageController,
                              decoration: InputDecoration(
                                hintText: 'Enter your message',
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Pop-up'ı kapat
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  String message = messageController.text;
                                  final data = {
                                    "user1_id": _userId.toString(),
                                    "user2_id": advertisementApplication.user.id.toString(),
                                    "advertisement_id": widget.advertisementId.toString(),
                                    "content": message.toString(),
                                  };
                                  messageController.clear();
                                  setState(() {
                                    loading = true;
                                  });
                                  _messageService.store(data).then((value) {
                                    getConversations();
                                    setState(() {
                                      loading = false;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Message Successfully Sent'),
                                        backgroundColor: Colors.green,
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                    setState(() {
                                      Navigator.pop(context); // Pop-up'ı kapat
                                    });
                                  });
                                },
                                child: Text('Send'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  text: btnText('Send Message'),
                  height: 28,
                  width: 120,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
