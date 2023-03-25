/*
  Authors : flutter_ninja (Flutter Ninja)
  Website : https://codecanyon.net/user/flutter_ninja/
  App Name : JobFinder Flutter Template
  This App Template Source code is licensed as per the
  terms found in the Website https://codecanyon.net/licenses/standard/
  Copyright and Good Faith Purchasers © 2022-present flutter_ninja.
*/
import 'package:flutter/material.dart';
import 'package:jobfinder/widget/elevated_button.dart';
import 'package:jobfinder/widget/rating.dart';
import '../components/styles.dart';

class JobDetails extends StatefulWidget {
  static const String id = 'JobDetails';

  const JobDetails({Key? key}) : super(key: key);

  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  int selectID = 1;
  double rating = 3.5;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Job Single Detail'),
          centerTitle: true,
          titleSpacing: 0,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
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
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            _buildJobName(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSelect('Description', 1),
                _buildSelect('Company', 2),
                _buildSelect('Reviews', 3),
              ],
            ),
            Column(children: [
              if (selectID == 1)
                _buildDescription()
              else if (selectID == 2)
                _buildCompany()
              else if (selectID == 3)
                _buildReviews()
            ]),
          ],
        ));
  }

  Widget _buildJobName() {
    return Container(
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
          children: [
            Image.asset('assets/images/n3.png', width: 40, height: 40),
            const SizedBox(height: 8),
            blackHeadingSmall('Flutter Developer'),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                greyText('\$75,000 - \$90,000 a year'),
                const SizedBox(width: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                  decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: greyTextSmall('Full Time'),
                ),
              ],
            ),
            const SizedBox(height: 16),
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
                      blackHeadingSmall('flutter_ninja Technology'),
                      greyTextSmall('Mumbai, India')
                    ],
                  ),
                ),
                greyTextSmall('15 Days Left')
              ],
            ),
          ],
        ));
  }

  Widget _buildSelect(title, id) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectID = id;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[appColor2, appColor]),
          color: selectID == id ? appColor : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(50.0)),
        ),
        child: Text(title,
            style: TextStyle(
                fontFamily: 'medium',
                fontSize: 14,
                color: selectID == id ? Colors.white : Colors.black54)),
      ),
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: blackHeading('Qualifications'.toUpperCase()),
        ),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
              children: [
                ListTile(
                  leading: const SizedBox(
                      height: double.infinity,
                      child: Icon(Icons.circle, size: 14)),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  minLeadingWidth: 0,
                  title: greyText(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco'),
                ),
                ListTile(
                  leading: const SizedBox(
                      height: double.infinity,
                      child: Icon(Icons.circle, size: 14)),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  minLeadingWidth: 0,
                  title: greyText(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco'),
                ),
              ],
            )),
        Container(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: blackHeading('About the job'.toUpperCase()),
        ),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
              children: [
                ListTile(
                  leading: const SizedBox(
                      height: double.infinity,
                      child: Icon(Icons.circle, size: 14)),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  minLeadingWidth: 0,
                  title: greyText(
                      'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor '),
                ),
                ListTile(
                  leading: const SizedBox(
                      height: double.infinity,
                      child: Icon(Icons.circle, size: 14)),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  minLeadingWidth: 0,
                  title: greyText(
                      'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor '),
                ),
              ],
            )),
        Container(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: blackHeading('Responsibilities'.toUpperCase()),
        ),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
              children: [
                ListTile(
                  leading: const SizedBox(
                      height: double.infinity,
                      child: Icon(Icons.circle, size: 14)),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  minLeadingWidth: 0,
                  title: greyText(
                      'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor '),
                ),
                ListTile(
                  leading: const SizedBox(
                      height: double.infinity,
                      child: Icon(Icons.circle, size: 14)),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  minLeadingWidth: 0,
                  title: greyText(
                      'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor '),
                ),
              ],
            )),
        Container(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: blackHeading('Releted Job'.toUpperCase()),
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
      ],
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

  Widget _buildCompany() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: blackHeading('Qualifications'.toUpperCase()),
        ),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
              children: [
                ListTile(
                  leading: const SizedBox(
                      height: double.infinity,
                      child: Icon(Icons.circle, size: 14)),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  minLeadingWidth: 0,
                  title: greyText(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco'),
                ),
                ListTile(
                  leading: const SizedBox(
                      height: double.infinity,
                      child: Icon(Icons.circle, size: 14)),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  minLeadingWidth: 0,
                  title: greyText(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco'),
                ),
              ],
            )),
      ],
    );
  }

  Widget _buildReviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: blackHeading('Review Summary'.toUpperCase()),
        ),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(children: const [
                      Icon(Icons.star, color: Colors.orange, size: 18),
                      Icon(Icons.star, color: Colors.orange, size: 18),
                      Icon(Icons.star, color: Colors.orange, size: 18),
                      Icon(Icons.star, color: Colors.orange, size: 18),
                      Icon(Icons.star, color: Colors.orange, size: 18)
                    ]),
                    const SizedBox(width: 10),
                    reviewText('(453 Reviews) 70%'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(children: const [
                      Icon(Icons.star, color: Colors.orange, size: 18),
                      Icon(Icons.star, color: Colors.orange, size: 18),
                      Icon(Icons.star, color: Colors.orange, size: 18),
                      Icon(Icons.star, color: Colors.orange, size: 18),
                      Icon(Icons.star, color: Colors.grey, size: 18)
                    ]),
                    const SizedBox(width: 10),
                    reviewText('(201 Reviews) 20%'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(children: const [
                      Icon(Icons.star, color: Colors.orange, size: 18),
                      Icon(Icons.star, color: Colors.orange, size: 18),
                      Icon(Icons.star, color: Colors.orange, size: 18),
                      Icon(Icons.star, color: Colors.grey, size: 18),
                      Icon(Icons.star, color: Colors.grey, size: 18)
                    ]),
                    const SizedBox(width: 10),
                    reviewText('(45 Reviews) 5%'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(children: const [
                      Icon(Icons.star, color: Colors.orange, size: 18),
                      Icon(Icons.star, color: Colors.orange, size: 18),
                      Icon(Icons.star, color: Colors.grey, size: 18),
                      Icon(Icons.star, color: Colors.grey, size: 18),
                      Icon(Icons.star, color: Colors.grey, size: 18)
                    ]),
                    const SizedBox(width: 10),
                    reviewText('(20 Reviews) 3%'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(children: const [
                      Icon(Icons.star, color: Colors.orange, size: 18),
                      Icon(Icons.star, color: Colors.grey, size: 18),
                      Icon(Icons.star, color: Colors.grey, size: 18),
                      Icon(Icons.star, color: Colors.grey, size: 18),
                      Icon(Icons.star, color: Colors.grey, size: 18)
                    ]),
                    const SizedBox(width: 10),
                    reviewText('(10 Reviews) 2%'),
                  ],
                ),
              ],
            )),
        Container(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: blackHeading('Your Rating'.toUpperCase()),
        ),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StarRating(
                        rating: rating,
                        onRatingChanged: (rating) =>
                            setState(() => this.rating = rating),
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter here',
                      labelStyle:
                          TextStyle(color: Colors.black38, fontSize: 14),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: appColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: MyElevatedButton(
                      onPressed: () {},
                      text: Text(
                        'Submit'.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'medium',
                            fontSize: 16),
                      ),
                      height: 45,
                      width: double.infinity),
                )
              ],
            )),
      ],
    );
  }
}
