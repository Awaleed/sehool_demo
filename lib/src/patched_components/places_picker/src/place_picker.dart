import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/place_provider.dart';
import 'google_map_place_picker.dart';

enum PinState { preparing, idle, dragging }

class PlacePicker extends StatefulWidget {
  const PlacePicker({
    Key key,
    this.initialPosition,
    this.cameraMoveDebounceInMilliseconds = 750,
    this.enableMyLocationButton = true,
    @required this.onSave,
  }) : super(key: key);

  final LatLng initialPosition;

  final int cameraMoveDebounceInMilliseconds;

  final bool enableMyLocationButton;
  final void Function(LatLng, int) onSave;

  @override
  _PlacePickerState createState() => _PlacePickerState();
}

class _PlacePickerState extends State<PlacePicker> {
  PlaceProvider provider;

  @override
  void initState() {
    super.initState();

    provider = PlaceProvider();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(),
            body: _buildMapWithLocation(),
          );
        },
      ),
    );
  }

  Future<void> _moveTo(double latitude, double longitude) async {
    final GoogleMapController controller = provider.mapController;
    if (controller == null) return;

    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 16,
        ),
      ),
    );
  }

  Future<void> _moveToCurrentPosition() async {
    if (provider.currentPosition != null) {
      await _moveTo(provider.currentPosition.latitude,
          provider.currentPosition.longitude);
    }
  }

  Widget _buildMapWithLocation() {
    provider.updateCurrentLocation().then((_) {
      if (provider.mapController != null && provider.currentPosition != null) {
        provider.mapController.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(
              provider.currentPosition.latitude,
              provider.currentPosition.longitude,
            ),
          ),
        );
      }
    });
    return _buildMap(widget.initialPosition);
  }

  Widget _buildMap(LatLng initialTarget) {
    return GoogleMapPlacePicker(
      initialTarget: initialTarget,
      enableMyLocationButton: widget.enableMyLocationButton,
      onMapCreated: (controller) => provider.mapController = controller,
      onSaveLocation: () => widget.onSave(
        LatLng(
          provider.currentPosition.latitude,
          provider.currentPosition.longitude,
        ),
        provider.currentRegion,
      ),
      onMyLocation: () async {
        // Prevent to click many times in short period.
        if (provider.isOnUpdateLocationCooldown == false) {
          provider.isOnUpdateLocationCooldown = true;
          Timer(const Duration(seconds: 5), () {
            provider.isOnUpdateLocationCooldown = false;
          });
          await provider.updateCurrentLocation();
          await _moveToCurrentPosition();
        }
      },
    );
  }
}
