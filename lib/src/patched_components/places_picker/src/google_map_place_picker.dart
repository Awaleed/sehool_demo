// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';

// import '../../../../generated/l10n.dart';
// import '../providers/place_provider.dart';
// import 'components/animated_pin.dart';
// import 'place_picker.dart';

// class GoogleMapPlacePicker extends StatefulWidget {
//   const GoogleMapPlacePicker({
//     Key key,
//     @required this.initialTarget,
//     this.onMoveStart,
//     this.onMapCreated,
//     this.onMyLocation,
//     @required this.onSaveLocation,
//     this.enableMyLocationButton,
//   }) : super(key: key);

//   final LatLng initialTarget;
//   final VoidCallback onMoveStart;
//   final MapCreatedCallback onMapCreated;
//   final VoidCallback onMyLocation;
//   final VoidCallback onSaveLocation;
//   final bool enableMyLocationButton;

//   @override
//   _GoogleMapPlacePickerState createState() => _GoogleMapPlacePickerState();
// }

// class _GoogleMapPlacePickerState extends State<GoogleMapPlacePicker> {
//   bool showPickBtn = true;

//   @override
//   Widget build(BuildContext context) {
//     final PlaceProvider provider = PlaceProvider.of(context, listen: false);
//     provider.addListener(() {
//       setState(() {
//         showPickBtn = provider.pinState != PinState.dragging;
//       });
//     });
//     return Stack(
//       alignment: Alignment.center,
//       children: <Widget>[
//         _buildGoogleMap(context),
//         _buildPin(),
//         Positioned(
//           bottom: 10,
//           child: SafeArea(
//             child: IgnorePointer(
//               ignoring: !showPickBtn,
//               child: AnimatedOpacity(
//                 opacity: showPickBtn ? 1 : 0,
//                 duration: const Duration(milliseconds: 150),
//                 child: ElevatedButton(
//                   onPressed: () => widget.onSaveLocation(),
//                   child: Text(
//                     S.of(context).save,
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildGoogleMap(BuildContext context) {
//     final PlaceProvider provider = PlaceProvider.of(context, listen: false);

//     final CameraPosition initialCameraPosition =
//         CameraPosition(target: widget.initialTarget, zoom: 15);

//     return GoogleMap(
//       initialCameraPosition: initialCameraPosition,
//       myLocationEnabled: true,
//       onMapCreated: (GoogleMapController controller) {
//         provider.mapController = controller;
//         provider.pinState = PinState.idle;
//       },
//       onCameraIdle: () {
//         provider.pinState = PinState.idle;
//       },
//       onCameraMoveStarted: () {
//         provider.setPrevCameraPosition(provider.cameraPosition);

//         // Cancel any other timer.

//         // Update state, dismiss keyboard and clear text.
//         provider.pinState = PinState.dragging;
//       },
//       onCameraMove: (CameraPosition position) {
//         provider.setCameraPosition(position);
//       },
//     );
//   }

//   Widget _buildPin() {
//     return Center(
//       child: Selector<PlaceProvider, PinState>(
//         selector: (_, provider) => provider.pinState,
//         builder: (context, state, __) => _defaultPinBuilder(context, state),
//       ),
//     );
//   }

//   Widget _defaultPinBuilder(BuildContext context, PinState state) {
//     if (state == PinState.preparing) {
//       return Container();
//     } else if (state == PinState.idle) {
//       return Stack(
//         children: <Widget>[
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const <Widget>[
//                 Icon(Icons.place, size: 36, color: Colors.red),
//                 SizedBox(height: 42),
//               ],
//             ),
//           ),
//           Center(
//             child: Container(
//               width: 5,
//               height: 5,
//               decoration: const BoxDecoration(
//                 color: Colors.black,
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//         ],
//       );
//     } else {
//       return Stack(
//         children: <Widget>[
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const <Widget>[
//                 AnimatedPin(
//                     child: Icon(Icons.place, size: 36, color: Colors.red)),
//                 SizedBox(height: 42),
//               ],
//             ),
//           ),
//           Center(
//             child: Container(
//               width: 5,
//               height: 5,
//               decoration: const BoxDecoration(
//                 color: Colors.black,
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//         ],
//       );
//     }
//   }
// }
