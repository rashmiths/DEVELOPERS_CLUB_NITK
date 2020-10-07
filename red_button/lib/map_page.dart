import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:permission_handler/permission_handler.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  List<Marker> allMarkers = [];
  Completer<GoogleMapController> _controller = Completer();
  bool normalMap = true;

  CameraPosition _kGooglePlex;
  var currentLocation;
  var first;
  bool error = false;
  @override
  void initState() {
    // Permission.location.request();
    Location location = Location();

    location.getLocation().then((value) {
      setState(() {
        currentLocation = value;
      });
      if (currentLocation != null) {
        final coordinates = new Coordinates(
          currentLocation.latitude,
          currentLocation.longitude,
        );
        Geocoder.local.findAddressesFromCoordinates(coordinates).then((value) {
          setState(() {
            first = value.first;
          });

          allMarkers.add(Marker(
              markerId: MarkerId('current location'),
              draggable: true,
              onTap: () {
                print('TAPPED');
              },
              position: LatLng(
                currentLocation.latitude,
                currentLocation.longitude,
              ),
              infoWindow: InfoWindow(
                  title: first.locality, snippet: first.addressLine)));
        });
      }
    }).catchError((err) {
      print('please enable location permission');
      setState(() {
        error = true;
      });
    });

    super.initState();
  }

  // LatLngBounds bounds = LatLngBounds(
  //   southwest: LatLng(13.004748, 74.791336),
  //   northeast: LatLng(13.01603, 74.801060),
  // );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'MAAPS',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.info,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  // showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return InfoDialog();
                  //     });
                })
          ],
        ),
        body: currentLocation == null && first == null
            ? Container(
                child: Center(
                    child: error == false
                        ? Text('LOADING.')
                        : Text('PLEASE ENABLE LOCATION PERMISSION')),
              )
            : GoogleMap(
                myLocationButtonEnabled: true,
                markers: Set.from(allMarkers),
                onLongPress: (argument) async {
                  final Coordinates temp =
                      Coordinates(argument.latitude, argument.longitude);
                  final check =
                      await Geocoder.local.findAddressesFromCoordinates(temp);

                  setState(() {
                    allMarkers.add(
                      Marker(
                          markerId: MarkerId(argument.toString()),
                          draggable: true,
                          position:
                              LatLng(argument.latitude, argument.longitude),
                          infoWindow: InfoWindow(
                              title: check.first.locality,
                              snippet: check.first.addressLine)),
                    );
                  });
                },
                //cameraTargetBounds: CameraTargetBounds(bounds),
                mapType: normalMap ? MapType.normal : MapType.hybrid,
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        currentLocation.latitude, currentLocation.longitude),
                    zoom: 15),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                myLocationEnabled: true,
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: Container(
          width: 80,
          height: 80,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  normalMap = !normalMap;
                });
              },
              child: Icon(Icons.map),
            ),
          ),
        ),
      ),
    );
  }
}
