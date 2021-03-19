import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../src/place_picker.dart';

class PlaceProvider extends ChangeNotifier {
  static PlaceProvider of(BuildContext context, {bool listen = true}) => Provider.of<PlaceProvider>(context, listen: listen);

  bool isOnUpdateLocationCooldown = false;

  Future<void> updateCurrentLocation() async {
    try {
      final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;

      currentPosition = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      if (await geolocator.isLocationServiceEnabled()) {
      } else {
        currentPosition = null;
      }
    } catch (e) {
      currentPosition = null;
    }

    notifyListeners();
  }

  Position _currentPoisition;
  int currentRegion = -1;

  Position get currentPosition => _currentPoisition;

  set currentPosition(Position newPosition) {
    _currentPoisition = newPosition;
    notifyListeners();
  }

  CameraPosition _previousCameraPosition;

  CameraPosition get prevCameraPosition => _previousCameraPosition;

  void setPrevCameraPosition(CameraPosition prePosition) {
    if (prePosition != _previousCameraPosition) {
      _previousCameraPosition = prePosition;
    }
  }

  CameraPosition _currentCameraPosition;

  CameraPosition get cameraPosition => _currentCameraPosition;

  void setCameraPosition(CameraPosition newPosition) {
    if (newPosition != _currentCameraPosition) {
      _currentCameraPosition = newPosition;
    }
  }

  GoogleMapController _mapController;

  GoogleMapController get mapController => _mapController;

  set mapController(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }

  PinState _pinState = PinState.preparing;

  PinState get pinState => _pinState;

  set pinState(PinState newState) {
    _pinState = newState;
    notifyListeners();
  }
}
