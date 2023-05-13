import 'package:flutter/material.dart';
import 'package:jobfinder/pages/company_detail.dart';
import 'package:jobfinder/pages/settings/general_settings.dart';
import 'package:jobfinder/provider/UserProvider.dart';
import 'package:jobfinder/services/Advertisement/JobService.dart';
import 'package:jobfinder/widget/navbar.dart';
import 'package:provider/provider.dart';
import '../components/styles.dart';

class Categories extends StatefulWidget {
  static const String id = 'Categories';

  const Categories({Key? key}) : super(key: key);

  @override
  CategoriesState createState() => CategoriesState();
}

class CategoriesState extends State<Categories> {
  late String _authToken;
  late int _userId;
  late int _selectedUserAddress;
  late JobService _jobService;

  List<Map<String, dynamic>>? jobs = null;

  @override
  void initState() {
    super.initState();
    _authToken = context.read<UserProvider>().auth!.accessToken;
    _userId = context.read<UserProvider>().auth!.user.id;
    _selectedUserAddress = context.read<UserProvider>().address!.id;
    _jobService = JobService(_authToken);
    _loadJobs();
  }

  Future<void> _loadJobs() async {
    List<Map<String, dynamic>> loadedJobs = await _jobService.activeByAddress(_selectedUserAddress);
    setState(() {
      jobs = loadedJobs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        drawer: const NavBar(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Categories'),
          centerTitle: true,
          titleSpacing: 0,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const GeneralSettings()));
                },
                icon: const Icon(Icons.location_city))
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
        body: _buildBody());
  }

  Widget _buildBody() {
    if (jobs == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Container(
        margin: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          shrinkWrap: true,
          children: jobs!.map((e) {
            return _buildCompany(context, e);
          }).toList(),
        ),
      );
    }
  }


  Widget _buildCompany(context, e) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CompanyDetail(companyId: 1)));
      },
      child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 1,
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(6))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_city,
                size: 30,
                color: appColor,
              ),
              const SizedBox(height: 4),
              boldText(e['job'].name),
              const SizedBox(height: 4),
              greyTextSmall('('+ e['advertisement_count'].toString() +')')
            ],
          )),
    );
  }
}

class Item {
  const Item(this.img, this.name);
  final String img;
  final String name;
}
