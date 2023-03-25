/*
  Authors : flutter_ninja (Flutter Ninja)
  Website : https://codecanyon.net/user/flutter_ninja/
  App Name : JobFinder Flutter Template
  This App Template Source code is licensed as per the
  terms found in the Website https://codecanyon.net/licenses/standard/
  Copyright and Good Faith Purchasers © 2022-present flutter_ninja.
*/
import 'package:flutter/material.dart';
import 'package:jobfinder/pages/company_detail.dart';
import 'package:jobfinder/widget/navbar.dart';
import '../components/styles.dart';

class Categories extends StatefulWidget {
  static const String id = 'Categories';

  const Categories({Key? key}) : super(key: key);

  @override
  CategoriesState createState() => CategoriesState();
}

class CategoriesState extends State<Categories> {
  @override
  void initState() {
    super.initState();
  }

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
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
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
    return Container(
      margin: const EdgeInsets.all(16),
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        shrinkWrap: true,
        children: cateList.map((e) {
          return _buildCompany(context, e);
        }).toList(),
      ),
    );
  }

  Widget _buildCompany(context, e) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CompanyDetail()));
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
}

class Item {
  const Item(this.img, this.name);
  final String img;
  final String name;
}
