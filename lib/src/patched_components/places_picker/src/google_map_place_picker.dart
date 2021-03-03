import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../providers/place_provider.dart';
import 'components/animated_pin.dart';
import 'place_picker.dart';

class GoogleMapPlacePicker extends StatefulWidget {
  const GoogleMapPlacePicker({
    Key key,
    @required this.initialTarget,
    this.onMoveStart,
    this.onMapCreated,
    this.onMyLocation,
    @required this.onSaveLocation,
    this.enableMyLocationButton,
  }) : super(key: key);

  final LatLng initialTarget;
  final VoidCallback onMoveStart;
  final MapCreatedCallback onMapCreated;
  final VoidCallback onMyLocation;
  final VoidCallback onSaveLocation;
  final bool enableMyLocationButton;

  @override
  _GoogleMapPlacePickerState createState() => _GoogleMapPlacePickerState();
}

class _GoogleMapPlacePickerState extends State<GoogleMapPlacePicker> {
  bool showPickBtn = true;
  bool canChoose = true;

  final center = const LatLng(
    24.860667,
    46.674167,
  );
  final distance = 50000.0;

  @override
  Widget build(BuildContext context) {
    final PlaceProvider provider = PlaceProvider.of(context, listen: false);
    provider.addListener(() {
      setState(() {
        showPickBtn = provider.pinState != PinState.dragging;
      });
    });
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        _buildGoogleMap(context),
        _buildPin(),
        Positioned(
          bottom: 10,
          left: 60,
          right: 60,
          child: SafeArea(
            child: canChoose
                ? IgnorePointer(
                    ignoring: !showPickBtn,
                    child: AnimatedOpacity(
                      opacity: showPickBtn ? 1 : 0,
                      duration: const Duration(milliseconds: 150),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () => widget.onSaveLocation(),
                          child: Text(
                            S.current.select,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                : Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        S.current.sorry_we_can_not_deliver_to_this_area,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    final PlaceProvider provider = PlaceProvider.of(context, listen: false);

    final CameraPosition initialCameraPosition = CameraPosition(target: widget.initialTarget, zoom: 15);

    return GoogleMap(
      initialCameraPosition: initialCameraPosition,
      myLocationEnabled: true,
      circles: {
        Circle(
          center: center,
          radius: distance,
          strokeWidth: 0,
          fillColor: Colors.amber.withOpacity(.15),
          circleId: CircleId('id'),
        )
      },
      onMapCreated: (GoogleMapController controller) {
        provider.mapController = controller;
        provider.pinState = PinState.idle;
      },
      onCameraIdle: () {
        provider.pinState = PinState.idle;
      },
      onCameraMoveStarted: () {
        provider.setPrevCameraPosition(provider.cameraPosition);

        // Cancel any other timer.

        // Update state, dismiss keyboard and clear text.
        provider.pinState = PinState.dragging;
      },
      onCameraMove: (CameraPosition position) {
        provider.setCameraPosition(position);
        provider.currentPosition = Position(latitude: position.target.latitude, longitude: position.target.longitude);

        setState(() {
          canChoose = Geolocator.distanceBetween(
                center.latitude,
                center.longitude,
                position.target.latitude,
                position.target.longitude,
              ) <=
              distance;
        });
        print('distance ${Geolocator.distanceBetween(
          widget.initialTarget.latitude,
          widget.initialTarget.longitude,
          position.target.latitude,
          position.target.longitude,
        )}');
      },
    );
  }

  Widget _buildPin() {
    return Center(
      child: Selector<PlaceProvider, PinState>(
        selector: (_, provider) => provider.pinState,
        builder: (context, state, __) => _defaultPinBuilder(context, state),
      ),
    );
  }

  Widget _defaultPinBuilder(BuildContext context, PinState state) {
    if (state == PinState.preparing) {
      return Container();
    } else if (state == PinState.idle) {
      return Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(Icons.place, size: 36, color: Colors.red),
                SizedBox(height: 42),
              ],
            ),
          ),
          Center(
            child: Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      );
    } else {
      return Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                AnimatedPin(child: Icon(Icons.place, size: 36, color: Colors.red)),
                SizedBox(height: 42),
              ],
            ),
          ),
          Center(
            child: Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      );
    }
  }
}
