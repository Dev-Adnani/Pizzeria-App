// ignore_for_file: void_checks, avoid_print, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart' as geo_co;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GenerateMaps with ChangeNotifier {
  Position? position;
  String finalAddress = 'Searching...';
  GoogleMapController? googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  String? countryName;
  String mainAddress = 'Please Select Any Place In Order To Get Address';
  String get getFinalAddress => finalAddress;
  String? get getCountryName => countryName;
  String get getMainAddress => mainAddress;
  double? intialLat;
  double? intialLong;

  Future getCurrentLocation() async {
    var postionData = await GeolocatorPlatform.instance.getCurrentPosition();
    final coords = geo_co.Coordinates(
      postionData.latitude,
      postionData.longitude,
    );
    intialLat = postionData.latitude;
    intialLong = postionData.longitude;
    var address =
        await geo_co.Geocoder.local.findAddressesFromCoordinates(coords);
    String mainAddress = address.first.addressLine!;
    finalAddress = mainAddress;
    notifyListeners();
  }

  getMarkers({required double lat, required double long}) {
    MarkerId markerId = MarkerId(lat.toString() + long.toString());
    Marker marker = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(lat, long),
      infoWindow: InfoWindow(title: getMainAddress, snippet: getCountryName),
    );
    markers[markerId] = marker;
  }

  Widget fetchMaps() {
    return GoogleMap(
      mapType: MapType.hybrid,
      mapToolbarEnabled: true,
      onTap: (loc) async {
        final coords = geo_co.Coordinates(loc.latitude, loc.longitude);
        var address =
            await geo_co.Geocoder.local.findAddressesFromCoordinates(coords);
        countryName = address.first.countryName;
        mainAddress = address.first.addressLine!;
        notifyListeners();
        markers == null
            ? getMarkers(lat: loc.latitude, long: loc.longitude)
            : markers.clear();

        print(loc);
        print(countryName);
        print(mainAddress);
      },
      markers: Set<Marker>.of(markers.values),
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      initialCameraPosition: CameraPosition(
        zoom: 17,
        target: LatLng(intialLat != null ? intialLat! : 20.20,
            intialLong != null ? intialLong! : 630.00),
      ),
      onMapCreated: (GoogleMapController mapController) {
        googleMapController = mapController;
        notifyListeners();
      },
    );
  }
}
