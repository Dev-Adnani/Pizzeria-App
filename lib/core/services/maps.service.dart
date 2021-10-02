import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart' as geo_co;
import 'package:geolocator/geolocator.dart';

class GenerateMaps with ChangeNotifier {
  Position? position;
  String finalAddress = 'Searching Address';

  Future getCurrentLocation() async {
    var postionData = await GeolocatorPlatform.instance.getCurrentPosition();
    final coords = geo_co.Coordinates(
      postionData.latitude,
      postionData.longitude,
    );
    var address =
        await geo_co.Geocoder.local.findAddressesFromCoordinates(coords);
    String mainAddress = address.first.addressLine!;
    finalAddress = mainAddress;
    notifyListeners();
  }
}
