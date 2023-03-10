import 'dart:async';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';
import 'package:example/screens/store_setup/model/user_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:example/constants/color_block.dart';

class BuildMapLocation extends StatefulWidget {
  final UserLocation? userLocation;
  const BuildMapLocation({Key? key, this.userLocation}) : super(key: key);

  @override
  State<BuildMapLocation> createState() => _BuildMapLocationState();
}

class _BuildMapLocationState extends State<BuildMapLocation> {
  final Completer<GoogleMapController> _controller = Completer();
  UserLocation _position = UserLocation(lat: 0, lng: 0, address: 'Apple Campus, CA, US');

  @override
  Widget build(BuildContext context) {
    if (widget.userLocation != null) {
      _position = widget.userLocation!;
    }
    return Stack(
      children: [
        _buildMap(),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 30,
          child: Center(
            child: Icon(FontAwesomeIcons.mapMarkerAlt, size: 30, color: ColorBlock.red),
          ),
        ),
        PositionedDirectional(
          bottom: 16,
          end: 20,
          child: GestureDetector(
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: ColorBlock.white,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.my_location, color: ColorBlock.blue),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildMap() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: LatLng(_position.lat ?? 0, _position.lng ?? 0),
        zoom: 1,
      ),
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      onCameraIdle: _onCameraIdle,
    );
  }

  /// Called when camera movement has ended
  Future<void> _onCameraIdle() async {
    LatLng center = await getCenter();
    List<Placemark> placements = await placemarkFromCoordinates(center.latitude, center.longitude);

    Placemark place = placements.first;

    UserLocation location = UserLocation(
      lat: center.latitude,
      lng: center.longitude,
      address: '${place.name}, ${place.administrativeArea}, ${place.isoCountryCode}',
      tag: '',
    );
    setState(() {
      if (location.lat != _position.lat || location.lng != _position.lng) {
        _position = location;
        context.read<StoreSettingBloc>().add(UpdateUserLocationEvent(userLocation: location));
      }
    });
  }

  /// Get center map
  Future<LatLng> getCenter() async {
    final GoogleMapController controller = await _controller.future;
    LatLngBounds bounds = await controller.getVisibleRegion();
    LatLng center = LatLng(
      (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
      (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
    );

    return center;
  }
}
