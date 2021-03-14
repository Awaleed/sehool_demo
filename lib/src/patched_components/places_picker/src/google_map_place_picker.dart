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

  List<LatLng> get _northRegion => const [
        LatLng(25.058447599999997, 46.5468074),
        LatLng(24.897222200000005, 46.3731562),
        LatLng(24.793451999999995, 46.4103813),
        LatLng(24.78780240000001, 46.5698884),
        LatLng(24.7372821, 46.59047279999999),
        LatLng(24.696806000000006, 46.633103),
        LatLng(24.6786309, 46.7195805),
        LatLng(24.757802099999996, 46.7444733),
        LatLng(24.811768700000012, 46.7125423),
        LatLng(24.86015090000002, 46.73674840000001),
        LatLng(24.901378800000014, 46.7113846),
        // LatLng(24.913536400000005, 46.7251219),
        LatLng(24.9414138, 46.7527536),
        LatLng(24.9776899, 46.749996),
        LatLng(25.123447100000003, 46.67458150000001),
        LatLng(25.058447599999997, 46.5468074),
      ];
  List<LatLng> get _southRegion => const [
        LatLng(24.676370799999997, 46.6365654),
        // LatLng(24.58706480000001, 46.6350112),
        LatLng(24.4996319, 46.63500299999999),
        LatLng(24.490197999999985, 46.7564148),
        LatLng(24.492738299999996, 46.9333606),
        LatLng(24.635827000000006, 46.9331827),
        LatLng(24.697547200000006, 46.9221757),
        LatLng(24.719960200000006, 46.8442531),
        // LatLng(24.702619800000022, 46.7796754),
        LatLng(24.6786309, 46.7195805),
        LatLng(24.696806000000006, 46.633103),
        LatLng(24.676370799999997, 46.6365654),
      ];
  List<LatLng> get _westRegion => const [
        LatLng(24.696806000000006, 46.633103),
        LatLng(24.7372821, 46.59047279999999),
        LatLng(24.78780240000001, 46.5698884),
        LatLng(24.793451999999995, 46.4103813),
        LatLng(24.577782100000004, 46.4189677),
        LatLng(24.547597400000004, 46.4624684),
        LatLng(24.53684010000001, 46.5013508),
        // LatLng(24.531381400000008, 46.5424593),
        LatLng(24.4996319, 46.63500299999999),
        // LatLng(24.542381299999995, 46.63613990000001),
        // LatLng(24.58513070000001, 46.6352169),
        LatLng(24.676370799999997, 46.6365654),
        LatLng(24.696806000000006, 46.633103),
      ];

  List<LatLng> get _eastRegion => const [
        LatLng(24.771138100000005, 46.9149658),
        LatLng(24.899817100000014, 46.9678376),
        LatLng(25.123447100000003, 46.67458150000001),
        LatLng(24.9776899, 46.749996),
        LatLng(24.9414138, 46.7527536),
        LatLng(24.901378800000014, 46.7113846),
        LatLng(24.86015090000002, 46.73674840000001),
        LatLng(24.811768700000012, 46.7125423),
        // LatLng(24.780839600000007, 46.730485),
        LatLng(24.757802099999996, 46.7444733),
        LatLng(24.6786309, 46.7195805),
        // LatLng(24.70324769999999, 46.78825739999999),
        LatLng(24.719960200000006, 46.8442531),
        LatLng(24.697547200000006, 46.9221757),
        LatLng(24.771138100000005, 46.9149658),
      ];

  int _getRegion(LatLng point) {
    if (_checkIfValidMarker(point, _northRegion)) {
      return 1;
    } else if (_checkIfValidMarker(point, _southRegion)) {
      return 2;
    } else if (_checkIfValidMarker(point, _eastRegion)) {
      return 4;
    } else if (_checkIfValidMarker(point, _westRegion)) {
      return 3;
    } else {
      return -1;
    }
  }

  bool _checkIfValidMarker(LatLng tap, List<LatLng> vertices) {
    int intersectCount = 0;
    for (int j = 0; j < vertices.length - 1; j++) {
      if (rayCastIntersect(tap, vertices[j], vertices[j + 1])) {
        intersectCount++;
      }
    }

    return ((intersectCount % 2) == 1); // odd = inside, even = outside;
  }

  bool rayCastIntersect(LatLng tap, LatLng vertA, LatLng vertB) {
    double aY = vertA.latitude;
    double bY = vertB.latitude;
    double aX = vertA.longitude;
    double bX = vertB.longitude;
    double pY = tap.latitude;
    double pX = tap.longitude;

    if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
      return false; // a and b can't both be above or below pt.y, and a or
      // b must be east of pt.x
    }

    double m = (aY - bY) / (aX - bX); // Rise over run
    double bee = (-aX) * m + aY; // y = mx + b
    double x = (pY - bee) / m; // algebra is neat!

    return x > pX;
  }

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

    final CameraPosition initialCameraPosition =
        CameraPosition(target: widget.initialTarget, zoom: 15);

    return GoogleMap(
      initialCameraPosition: initialCameraPosition,
      myLocationEnabled: true,
      // circles: {
      //   Circle(
      //     center: center,
      //     radius: distance,
      //     strokeWidth: 0,
      //     fillColor: Colors.amber.withOpacity(.15),
      //     circleId: CircleId('id'),
      //   )
      // },
      onTap: (value) {
        print('map tapped: $value');
      },
      polygons: {
        Polygon(
          polygonId: PolygonId('north'),
          fillColor: Colors.orange.withOpacity(.2),
          strokeWidth: 0,
          points: _northRegion,
        ),
        Polygon(
          polygonId: PolygonId('south'),
          fillColor: Colors.green.withOpacity(.2),
          strokeWidth: 0,
          points: _southRegion,
        ),
        Polygon(
          polygonId: PolygonId('west'),
          fillColor: Colors.red.withOpacity(.2),
          strokeWidth: 0,
          points: _westRegion,
        ),
        Polygon(
          polygonId: PolygonId('east'),
          fillColor: Colors.teal.withOpacity(.2),
          strokeWidth: 0,
          points: _eastRegion,
        ),
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
        provider.currentPosition = Position(
          latitude: position.target.latitude,
          longitude: position.target.longitude,
        );
        final region = _getRegion(position.target);
        provider.currentRegion = region;

        setState(() {
          canChoose = region != -1;
        });
        // _checkIfValidMarker(latLng, _area);
        /* 24.733721, 46.706886 */
        // final vertical =
        //     position.target.latitude > 24.733721 ? 'north' : 'south';
        // final horizontal =
        //     position.target.longitude > 46.706886 ? 'east' : 'west';
        // print('position.target.latitude: $horizontal');
        // print('distance ${Geolocator.distanceBetween(
        //   widget.initialTarget.latitude,
        //   widget.initialTarget.longitude,
        //   position.target.latitude,
        //   position.target.longitude,
        // )}');
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
                AnimatedPin(
                    child: Icon(Icons.place, size: 36, color: Colors.red)),
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
