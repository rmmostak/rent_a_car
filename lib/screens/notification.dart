import 'dart:async';
import 'package:geocoding/geocoding.dart' as geoCoding;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:permission_handler/permission_handler.dart';

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
    zoom: 14,
  );
  Set<Marker> markers=Set<Marker>();
  String? _mapStyle;
  GoogleMapController? myMapController;
  late LatLng destination;

  Future<bool> requestPerm() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.locationWhenInUse,
      Permission.storage
    ].request();

    if (statuses[Permission.location] != null &&
        statuses[Permission.bluetooth] != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      if (!await requestPerm()) {
        requestPerm();
      } else {
        rootBundle.loadString('assets/files/map_style.txt').then((value) => {
              _mapStyle = value,
            });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: 100,
        left: 0,
        right: 0,
        bottom: -30,
        child: GoogleMap(
          zoomControlsEnabled: false,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            myMapController = controller;
            myMapController!.setMapStyle(_mapStyle);
          },
        ),
      ),
      buildProfileTile(),
      buildSearch(),
      buildMyLocation(),
      buildNotification(),
    ]);
  }

  Widget buildProfileTile() {
    return Positioned(
      top: 33,
      left: 20,
      right: 20,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  border: Border.all(color: Colors.grey.shade400)),
              child: const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.blueGrey,
                backgroundImage: AssetImage('assets/images/bmw.png'),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Good Morning',
                ),
                Text(
                  'Where are you going?',
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

  TextEditingController destinationController = TextEditingController();
  TextEditingController sourceController = TextEditingController();

  bool showSourceField = false;

  Widget buildSearch() {
    return Positioned(
      top: 120,
      left: 20,
      height: 50,
      right: 20,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade400),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 4,
              blurRadius: 14,
            )
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: TextFormField(
          controller: destinationController,
          readOnly: true,
          onTap: () async {
            Prediction? p =
                await showAutoComplete();

          },
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.transparent,
            )),
            suffixIcon: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.search,
              ),
            ),
            hintText: 'Search your destination',
            contentPadding: EdgeInsets.all(10),
          ),
        ),
      ),
    );
  }

  Future<Prediction?> showAutoComplete() async {
    const googleMapAPI = 'AIzaSyAzvyjC2BBggfQL8itXKwLd5kLf_k9AV_w';

    Prediction? p = await PlacesAutocomplete.show(
      offset: 0,
      radius: 1000,
      strictbounds: false,
      region: "bd",
      language: "en",
      context: context,
      mode: Mode.overlay,
      apiKey: googleMapAPI,
      components: [Component(Component.country, "bd")],
      types: ["(cities)"],
      hint: "Search City",
    );

    return p;
  }

  Widget buildMyLocation() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
          padding: const EdgeInsets.only(right: 20, bottom: 20),
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.blueGrey.shade700,
            child: const Icon(
              Icons.my_location,
              color: Colors.white,
            ),
          )),
    );
  }

  Widget buildNotification() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 20),
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.notifications,
              color: Colors.blueGrey.shade700,
            ),
          )),
    );
  }
}
