// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class AddressPickerCard extends FormField<LatLng> {
//   AddressPickerCard({
//     Key key,
//     @required String label,
//     @required FormFieldSetter<LatLng> onSaved,
//     @required FormFieldValidator<LatLng> validator,
//     @required LatLng initialValue,
//     @required
//         void Function(
//                 FormFieldSetter<LatLng> onSaved, FormFieldState<LatLng> state)
//             openMapScreen,
//     // bool autovalidate = false,
//   }) : super(
//           key: key,
//           onSaved: onSaved,
//           validator: validator,
//           initialValue: initialValue,
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           builder: (FormFieldState<LatLng> state) {
//             return InputDecorator(
//               decoration: InputDecoration(
//                 labelText: label,
//                 border: InputBorder.none,
//                 errorText: state.errorText,
//               ),
//               child: SizedBox(
//                 height: 200,
//                 child: Card(
//                   child: InkWell(
//                     onTap: () => openMapScreen(onSaved, state),
//                     child: () {
//                       if (state.value == null && initialValue == null) {
//                         return Container(
//                           color: state.hasError
//                               ? Colors.red.withOpacity(.5)
//                               : null,
//                           child: const Icon(
//                             Icons.add,
//                             color: Colors.black,
//                           ),
//                         );
//                       } else if (state.value == null && initialValue != null) {
//                         return GoogleMap(
//                           onMapCreated: (controller) =>
//                               onMapCreated(controller, initialValue),
//                           initialCameraPosition:
//                               const CameraPosition(target: LatLng(0, 0)),
//                           onTap: (_) => openMapScreen(onSaved, state),
//                           markers: {
//                             Marker(
//                               markerId: MarkerId(''),
//                               position: initialValue,
//                             ),
//                           },
//                         );
//                       }

//                       return GoogleMap(
//                         onMapCreated: (controller) =>
//                             onMapCreated(controller, state.value),
//                         initialCameraPosition:
//                             const CameraPosition(target: LatLng(0, 0)),
//                         onTap: (_) => openMapScreen(onSaved, state),
//                         markers: {
//                           Marker(
//                             markerId: MarkerId(''),
//                             position: state.value,
//                           ),
//                         },
//                       );
//                     }(),
//                   ),
//                 ),
//               ),
//             );
//           },
//         );

//   static Future<void> onMapCreated(
//       GoogleMapController controller, LatLng location) async {
//     await controller.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: location,
//           zoom: 20,
//         ),
//       ),
//     );
//   }
// }
