import 'package:flutter/material.dart';
import 'package:jobfinder/components/user/profile/user_addresses.dart';
import 'package:jobfinder/models/User/UserAddress.dart';
import 'package:jobfinder/pages/home.dart';
import 'package:jobfinder/provider/UserProvider.dart';
import 'package:jobfinder/services/User/UserAddressService.dart';
import 'package:jobfinder/widget/elevated_button.dart';
import 'package:provider/provider.dart';
import '../../components/styles.dart';

class GeneralSettings extends StatefulWidget {
  static const String id = 'GeneralSettings';

  const GeneralSettings({Key? key}) : super(key: key);

  @override
  _GeneralSettingsState createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  RangeValues distance = const RangeValues(40, 80);
  RangeValues age = const RangeValues(40, 80);
  String dropdownValueCountry = 'Yearly';

  bool _isChecked = true;
  // ignore: unused_field
  String _currText = '';
  int selectID = 1;

  List<String> text = [
    'Full Time (52)',
    'Freelance (100)',
    'Part Time (141)',
    'Internship (11)',
  ];

  late String _authToken;
  late int _userId;
  late UserAddress _address;
  int? selectedAddress;
  late UserAddressService _userAddressService;
  List<UserAddress> userAddesses = [];


  @override
  void initState() {
    super.initState();
    _authToken = context.read<UserProvider>().auth!.accessToken;
    _userId = context.read<UserProvider>().auth!.user.id;
    _address = context.read<UserProvider>().address!;
    selectedAddress = _address.id;
    _userAddressService = UserAddressService(_authToken, _userId);
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    List<UserAddress> loadedAddresses = await _userAddressService.index();
    setState(() {
      userAddesses = loadedAddresses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('GeneralSettings'),
          centerTitle: true,
          titleSpacing: 0,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
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
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: [

                FutureBuilder<List<UserAddress>>(
                  future: _userAddressService.index(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<DropdownMenuItem<int>> items = [];
                      for (UserAddress address in snapshot.data!) {
                        items.add(
                          DropdownMenuItem(
                            value: address.id,
                            child: Text(address.neighborhoodName + ' ' + address.remainingAddress!,overflow: TextOverflow.ellipsis,),

                          ),
                        );
                      }

                      return DropdownButton(
                        value: selectedAddress,
                        items: items,
                        onChanged: (value) {
                          setState(() {
                            selectedAddress = value as int;
                          });// Seçilen adresi kullanın
                        },
                        isExpanded: true,
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    return CircularProgressIndicator();
                  },
                ),
              ],
            ),
            MyElevatedButton(
                onPressed: () {
                  context.read<UserProvider>().setAddress(userAddesses.firstWhere((element) => element.id == selectedAddress));
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                },
                text: const Text(
                  'Select Address',
                  style: TextStyle(color: Colors.white, fontFamily: 'medium'),
                ),
                height: 45,
                width: double.infinity)
          ],
        ),
      ),
    );
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
}
