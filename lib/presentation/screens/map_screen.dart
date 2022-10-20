import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:omar_ahmed_maps/business_logic/phone_auth/phone_auth_cubit.dart';
import 'package:omar_ahmed_maps/constants/my_colors.dart';
import 'package:omar_ahmed_maps/constants/strings.dart';
import 'package:omar_ahmed_maps/helpers/location_helper.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  AuthCubit authCubit = AuthCubit();

  static Position? position;
  Completer<GoogleMapController> _mapController = Completer();

  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
    target: LatLng(position!.latitude, position!.longitude),
    bearing: 0.0,
    tilt: 0.0,
    zoom: 17,
  );

  Future<void> getMyCurrentLocationNew() async {
    position = await LocationHelperNew.determinePosition().whenComplete(() {
      setState(() {});
    });
  }

  Widget buildMap() {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      initialCameraPosition: _myCurrentLocationCameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
    );
  }

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(_myCurrentLocationCameraPosition));
  }

  @override
  void initState() {
    super.initState();
    getMyCurrentLocationNew();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Scaffold(
      body: Stack(
        children: [
          position != null
              ? buildMap()
              : Center(
                  child: Container(
                  child: CircularProgressIndicator(
                    color: MyColors.blue,
                  ),
                ))
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 8, 30),
        child: FloatingActionButton(
          backgroundColor: MyColors.blue,
          onPressed: _goToMyCurrentLocation,
          child: Icon(
            Icons.place,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
