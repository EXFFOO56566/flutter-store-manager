// Flutter library
import 'dart:async';
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Repository packages
import 'package:google_place_repository/google_place_repository.dart';

// Bloc
import '../../../../bloc/store_setting_bloc.dart';

// Constants
import 'package:flutter_store_manager/constants/color_block.dart';
import 'package:flutter_store_manager/constants/constants.dart';

class BuildMapLocation extends StatefulWidget {
  final UserLocation? userLocation;
  const BuildMapLocation({Key? key, this.userLocation}) : super(key: key);

  @override
  State<BuildMapLocation> createState() => _BuildMapLocationState();
}

class _BuildMapLocationState extends State<BuildMapLocation> {
  final Completer<GoogleMapController> _controller = Completer();
  late UserLocation _position;
  @override
  void initState() {
    if (widget.userLocation != null) {
      _position = widget.userLocation!;
    } else {
      _position = UserLocation(lat: initLat, lng: initLng, address: 'Apple Campus, CA, US');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                boxShadow: initBoxShadow,
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
        target: LatLng(_position.lat ?? initLat, _position.lng ?? initLng),
        zoom: initZoom,
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
      address: '${place.street}, ${place.administrativeArea}, ${place.isoCountryCode}',
      tag: '',
    );
    if (location.lat?.toStringAsFixed(4) != _position.lat?.toStringAsFixed(4) ||
        location.lng?.toStringAsFixed(4) != _position.lng?.toStringAsFixed(4)) {
      setState(() {
        _position = location;
        context.read<StoreSettingBloc>().add(UpdateUserLocationEvent(userLocation: location));
      });
    }
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
