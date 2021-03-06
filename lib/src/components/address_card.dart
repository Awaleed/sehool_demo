import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../generated/l10n.dart';

import '../models/address_model.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({Key key, @required this.address, this.hideDetails = true}) : super(key: key);
  final AddressModel address;
  final bool hideDetails;
  @override
  Widget build(BuildContext context) {
    if (hideDetails) {
      return SizedBox(
        height: 150,
        child: _HomeCard(address: address),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            elevation: 2,
            clipBehavior: Clip.hardEdge,
            margin: EdgeInsets.zero,
            color: Colors.white70,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 80, bottom: 8, left: 8, right: 8),
              child: ListTile(
                title: Text(address?.address ?? S.current.none),
              ),
            ),
          ),
          Positioned(
            top: -80,
            left: 15,
            right: 15,
            height: 150,
            child: _HomeCard(address: address),
          ),
        ],
      ),
    );
  }
}

class _HomeCard extends StatelessWidget {
  const _HomeCard({Key key, this.address}) : super(key: key);
  final AddressModel address;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Card(
          elevation: 2,
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: () {
              if (address == null) {
                return Image.asset(
                  'assets/images/map.png',
                  fit: BoxFit.cover,
                );
              }
              return !address.hasLocation
                  ? Image.asset(
                      'assets/images/map.png',
                      fit: BoxFit.cover,
                    )
                  : GoogleMap(
                      key: ValueKey('${address.latLng.latitude},${address.latLng.longitude}'),
                      onMapCreated: (controller) async {
                        await controller.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: address.latLng,
                              zoom: 15,
                            ),
                          ),
                        );
                      },
                      initialCameraPosition: const CameraPosition(target: LatLng(0, 0)),
                      markers: {
                        Marker(
                          markerId: MarkerId(''),
                          position: address.latLng,
                        ),
                      },
                    );
            }(),
          ),
        ),
      ],
    );
  }
}
