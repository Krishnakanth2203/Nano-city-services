import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CityScreens extends StatefulWidget {
  const CityScreens({super.key});

  @override
  State<CityScreens> createState() => _CityScreensState();
}

class _CityScreensState extends State<CityScreens> {
  GoogleMapController? _mapController;
  LatLng _initialPosition = const LatLng(20.5937, 78.9629); // Default to India
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) return;
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }

    final loc = await location.getLocation();
    setState(() {
      _initialPosition = LatLng(loc.latitude!, loc.longitude!);
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _initialPosition,
                  zoom: 15,
                ),
                myLocationEnabled: true,
                onMapCreated: (controller) {
                  _mapController = controller;
                },
              ),
      ),
    );
  }
}
