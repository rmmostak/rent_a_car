import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Notifications extends StatefulWidget {
  Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(23.7905223, 90.3518688),
    zoom: 14.4746,
  );

  String? _mapStyle;
  GoogleMapController? myMapController;

  @override
  void initState() {
    super.initState();

    rootBundle.loadString('assets/files/map_style.txt').then((value) => {
          _mapStyle = value,
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: 100,
        left: 0,
        right: 0,
        bottom: 0,
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            myMapController:
            controller;
            myMapController!.setMapStyle(_mapStyle);
          },
        ),
      ),
      buildProfileTile(),
    ]);
  }

  Widget buildProfileTile() {
    return Positioned(
      top: 30,
      left: 20,
      right: 20,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blueGrey,
              //backgroundImage: AssetImage('assets/images/bmw.png'),
            ),
            const SizedBox(width: 15,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Good Morning',
                ),
                Text(
                  'Where do you want to go?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
