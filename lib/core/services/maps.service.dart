import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart' as geoCo;
import 'package:geolocator/geolocator.dart';

class GenerateMaps with ChangeNotifier {
  Position? position;
  String finalAddress = 'Searching Address';

  Future getCurrentLocation() async {
    var postionData = await GeolocatorPlatform.instance.getCurrentPosition();
    final coords = geoCo.Coordinates(
      postionData.latitude,
      postionData.longitude,
    );
    var address =
        await geoCo.Geocoder.local.findAddressesFromCoordinates(coords);
    String mainAddress = address.first.addressLine!;
    print(mainAddress);
    finalAddress = mainAddress;
    notifyListeners();
  }
}
