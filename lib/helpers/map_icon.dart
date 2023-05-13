import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BitmapDescriptorSingleton {
  static BitmapDescriptorSingleton? _instance;

  BitmapDescriptor companyIcon;
  BitmapDescriptor userIcon;
  BitmapDescriptor youIcon;

  factory BitmapDescriptorSingleton() {
    if (_instance == null) {
      _instance = BitmapDescriptorSingleton._internal();
    }
    return _instance!;
  }

  BitmapDescriptorSingleton._internal()
      : companyIcon = BitmapDescriptor.defaultMarker,
        userIcon = BitmapDescriptor.defaultMarker,
        youIcon = BitmapDescriptor.defaultMarker;

  Future<void> initialize() async {
    final ImageConfiguration config = ImageConfiguration(devicePixelRatio: 2.0);
    companyIcon = await BitmapDescriptor.fromAssetImage(
      config,
      'assets/images/marker-company.png',
    );
    userIcon = await BitmapDescriptor.fromAssetImage(
      config,
      'assets/images/marker-user.png',
    );
    youIcon = await BitmapDescriptor.fromAssetImage(
      config,
      'assets/images/marker-you.png',
    );
  }
}
