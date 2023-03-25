/*
  Authors : flutter_ninja (Flutter Ninja)
  Website : https://codecanyon.net/user/flutter_ninja/
  App Name : JobFinder Flutter Template
  This App Template Source code is licensed as per the
  terms found in the Website https://codecanyon.net/licenses/standard/
  Copyright and Good Faith Purchasers © 2022-present flutter_ninja.
*/
import 'package:flutter/material.dart';
import 'package:jobfinder/pages/categories.dart';
import 'package:jobfinder/pages/company.dart';
import 'package:jobfinder/pages/filter.dart';
import 'package:jobfinder/pages/job_details.dart';
import 'package:jobfinder/pages/view_jobs.dart';
import 'package:jobfinder/widget/elevated_button.dart';
import 'package:jobfinder/widget/navbar.dart';
import '../components/styles.dart';

class Home extends StatefulWidget {
  static const String id = 'Home';

  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Item> cateList = <Item>[
    const Item('assets/images/c1.png', 'Developer'),
    const Item('assets/images/c2.png', 'Technology'),
    const Item('assets/images/c3.png', 'Accounting'),
    const Item('assets/images/c4.png', 'Engineer'),
    const Item('assets/images/c1.png', 'Developer'),
    const Item('assets/images/c2.png', 'Technology'),
    const Item('assets/images/c3.png', 'Accounting'),
    const Item('assets/images/c4.png', 'Engineer'),
  ];

  List<Item> companyList = <Item>[
    const Item('assets/images/n3.png', 'Pionear Tech'),
    const Item('assets/images/n2.png', 'Golang Info'),
    const Item('assets/images/n1.png', 'ACC IT'),
    const Item('assets/images/n4.png', 'PVT. LTD.'),
    const Item('assets/images/n3.png', 'Pionear Tech'),
    const Item('assets/images/n2.png', 'Golang Info'),
    const Item('assets/images/n1.png', 'ACC IT'),
    const Item('assets/images/n4.png', 'PVT. LTD.'),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const NavBar(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Home'),
        centerTitle: true,
        titleSpacing: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Filter()));
              },
              icon: const Icon(Icons.filter_list)),
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
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                blackHeadingSmall('All Category'.toUpperCase()),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Categories()));
                    },
                    child: appcolorText('See All'))
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: cateList.map((e) {
                  return _buildCategory(context, e);
                }).toList(),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                blackHeadingSmall('Jobs'.toUpperCase()),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ViewJobs()));
                    },
                    child: appcolorText('See All'))
              ],
            ),
          ),
          SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 2,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, i) => Column(
                  children: [_buildJobs()],
                ),
              )),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                blackHeadingSmall('Companies'.toUpperCase()),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Company()));
                    },
                    child: appcolorText('See All'))
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: companyList.map((e) {
                  return _buildCategory(context, e);
                }).toList(),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                blackHeadingSmall('Featured jobs'.toUpperCase()),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ViewJobs()));
                    },
                    child: appcolorText('See All'))
              ],
            ),
          ),
          SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 2,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, i) => Column(
                  children: [_buildJobs()],
                ),
              )),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                blackHeadingSmall('Our Testimonial'.toUpperCase()),
                appcolorText('See All')
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: cateList.map((e) {
                  return _buildTestimonial(context, e);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategory(context, e) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          margin: const EdgeInsets.only(top: 16, bottom: 16, right: 12),
          width: 110,
          height: 90,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 8,
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(6))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                e.img,
                width: 30,
                height: 30,
                color: appColor,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 4),
              boldText(e.name),
              const SizedBox(height: 4),
              greyTextSmall('(450 jobs)')
            ],
          )),
    );
  }

  Widget _buildJobs() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const JobDetails()));
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
                    child: Image.asset('assets/images/n3.png',
                        width: 30, height: 30)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      blackHeadingSmall('Flutter Developer'),
                      greyTextSmall('Gobook Tech. los Angeles, CA')
                    ],
                  ),
                ),
                const Icon(Icons.bookmark, color: appColor, size: 16),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: greyTextSmall(
                  'It is a long established fact that a reader be distracted by content of page when looking at its layout..'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                boldText('\$35,000-\$85,000 a year'),
                MyElevatedButton(
                    onPressed: () {},
                    text: btnText('Apply'),
                    height: 28,
                    width: 80)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestimonial(context, e) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          margin: const EdgeInsets.only(top: 16, bottom: 16, right: 12),
          padding: const EdgeInsets.all(10),
          width: 220,
          height: 160,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 8,
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(6))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset('assets/images/p1.jpg',
                          fit: BoxFit.cover, width: 40, height: 40)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        blackHeadingSmall('Willie Loren'),
                        greyTextSmall('Support Manager @golang')
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 1, color: backgroundColor),
              Row(
                children: [
                  Row(children: const [
                    Icon(Icons.star, color: Colors.orange, size: 14),
                    Icon(Icons.star, color: Colors.orange, size: 14),
                    Icon(Icons.star, color: Colors.orange, size: 14),
                    Icon(Icons.star, color: Colors.orange, size: 14),
                    Icon(Icons.star, color: Colors.grey, size: 14)
                  ]),
                  const SizedBox(width: 8),
                  greyTextSmall('4.6 (453 Reviews)'),
                ],
              ),
              const SizedBox(height: 8),
              greyTextSmall(
                  'There are many variation of vailable but the majority have suffered alteraction in some fomr, by injected humors or randomize.')
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
