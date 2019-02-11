import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsDemo extends StatefulWidget {
  @override
  State createState() => MapsDemoState();
}

class MapsDemoState extends State<MapsDemo> {

  GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child:GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
    bearing: 270.0,
    target: LatLng(56.268383, 44.025361),
    tilt: 30.0,
    zoom: 17.0,
    ),
    ));
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() { mapController = controller; });
  }
}