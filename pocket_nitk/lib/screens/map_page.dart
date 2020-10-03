import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:pocket_nitk/widgets/info_dialog.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  List<Marker> allMarkers = [];
  Completer<GoogleMapController> _controller = Completer();
  bool normalMap = true;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(
      13.011292,
      74.794336,
    ),
    zoom: 16,
  );
  @override
  void initState() {
    allMarkers.add(Marker(
        markerId: MarkerId('NitkLocation'),
        draggable: true,
        onTap: () {
          print('TAPPED');
        },
        position: LatLng(
          13.011292,
          74.794336,
        )));
    allMarkers.add(Marker(
        markerId: MarkerId('IT Dept'),
        draggable: true,
        onTap: () {
          print('TAPPED');
        },
        position: LatLng(
          13.011109,
          74.792301,
        )));
    allMarkers.add(Marker(
        markerId: MarkerId('CSE Dept'),
        draggable: true,
        onTap: () async {
          print('TAPPED');
          final coordinates = new Coordinates(
            13.012956,
            74.791482,
          );
          final addresses =
              await Geocoder.local.findAddressesFromCoordinates(coordinates);
          final first = addresses.first;
          print("${first.featureName} : ${first.addressLine}");
        },
        position: LatLng(
          13.012956,
          74.791482,
        )));
    allMarkers.add(Marker(
        markerId: MarkerId('Main Gate'),
        draggable: true,
        onTap: () async {
          final coordinates = new Coordinates(
            13.012576,
            74.793058,
          );
          final addresses =
              await Geocoder.local.findAddressesFromCoordinates(coordinates);
          final first = addresses.first;
          print("${first.featureName} : ${first.addressLine}");
        },
        position: LatLng(
          13.012576,
          74.793058,
        )));

    allMarkers.add(Marker(
        markerId: MarkerId('Main Ground'),
        draggable: true,
        onTap: () async {
          final coordinates = Coordinates(
            13.009943,
            74.797423,
          );
          final addresses =
              await Geocoder.local.findAddressesFromCoordinates(coordinates);
          final first = addresses.first;
          print("${first.featureName} : ${first.addressLine}");
        },
        position: LatLng(
          13.009943,
          74.797423,
        )));
    allMarkers.add(Marker(
        markerId: MarkerId('nitk library'),
        draggable: true,
        onTap: () async {
          final coordinates = Coordinates(
            13.009884,
            74.794873,
          );
          final addresses =
              await Geocoder.local.findAddressesFromCoordinates(coordinates);
          final first = addresses.first;
          print("${first.featureName} : ${first.addressLine}");
        },
        position: LatLng(
          13.009884,
          74.794873,
        )));
    allMarkers.add(Marker(
        markerId: MarkerId('mega tower'),
        draggable: true,
        onTap: () async {
          final coordinates = new Coordinates(
            13.007224,
            74.79524,
          );
          final addresses =
              await Geocoder.local.findAddressesFromCoordinates(coordinates);
          final first = addresses.first;
          print("${first.featureName} : ${first.addressLine}");
        },
        position: LatLng(
          13.007224,
          74.79524,
        )));
    allMarkers.add(Marker(
        markerId: MarkerId('food court'),
        draggable: true,
        onTap: () async {
          final coordinates = new Coordinates(
            13.008526,
            74.795311,
          );
          final addresses =
              await Geocoder.local.findAddressesFromCoordinates(coordinates);
          final first = addresses.first;
          print("${first.featureName} : ${first.addressLine}");
        },
        position: LatLng(
          13.008526,
          74.795311,
        )));
    allMarkers.add(Marker(
        markerId: MarkerId('Girls Hostel'),
        draggable: true,
        onTap: () async {
          final coordinates = new Coordinates(
            13.008526,
            74.795311,
          );
          final addresses =
              await Geocoder.local.findAddressesFromCoordinates(coordinates);
          final first = addresses.first;
          print("${first.featureName} : ${first.addressLine}");
        },
        position: LatLng(
          13.008526,
          74.795311,
        )));
    super.initState();
  }

  LatLngBounds bounds = LatLngBounds(
    southwest: LatLng(13.004748, 74.791336),
    northeast: LatLng(13.01603, 74.801060),
  );
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
                  showDialog(
                      context: context,
                      builder: (context) {
                        return InfoDialog();
                      });
                })
          ],
        ),
        body: GoogleMap(
          myLocationButtonEnabled: true,
          markers: Set.from(allMarkers),
          onLongPress: (argument) {
            setState(() {
              allMarkers.add(Marker(
                  markerId: MarkerId(argument.toString()),
                  draggable: true,
                  onTap: () {
                    print('TAPPED');
                  },
                  position: LatLng(argument.latitude, argument.longitude)));
            });
          },
          cameraTargetBounds: CameraTargetBounds(bounds),
          mapType: normalMap ? MapType.normal : MapType.hybrid,
          initialCameraPosition: _kGooglePlex,
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
