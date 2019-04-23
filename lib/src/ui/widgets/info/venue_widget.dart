import 'dart:async';

import 'package:devfest_flutter_app/src/ui/widgets/common/expanded_widget.dart';
import 'package:devfest_flutter_app/src/utils/colors.dart';
import 'package:devfest_flutter_app/src/utils/icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//TODO описание площадки

class MapsDemo extends StatefulWidget {
  @override
  State createState() => MapsDemoState();
}

class MapsDemoState extends State<MapsDemo> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kVenue = CameraPosition(
    target: LatLng(56.268383, 44.025361),
    zoom: 13.0,
  );

  @override
  Widget build(BuildContext context) {
    Marker m = Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId('venuePosition'),
      position: LatLng(56.268383, 44.025361),
      infoWindow: InfoWindow(
        title: 'DevFest Venue',
        snippet: 'IT-Park Ankudinovka',
      ),
      icon: BitmapDescriptor.defaultMarker,
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: _goToTheVenue, child: IconHelper.gdg(color: Colors.white)),
      body: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
        GoogleMap(
          mapType: MapType.normal,
          markers: {m},
          initialCameraPosition: _kVenue,
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
            Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
            ),
          ].toSet(),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        Container(
            margin: EdgeInsets.only(bottom: 20.0),
            child: Row(children: <Widget>[
              Expanded(
                  child: TransparentWidget(
                    height: 150.0,
                    child: _VenueInfoCard(
                        "IT-Park Ankudinovka is a new modernized venue, combining"
                            " a business center, a technopark in the sphere of high"
                            " technologies, conference facilities and exhibition opportunities"),
                  ))
            ]))
      ]),
    );
  }

  Future<void> _goToTheVenue() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kVenue));
  }
}

class _VenueInfoCard extends StatelessWidget {
  _VenueInfoCard(this.text) : assert(text != null);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(children: <Widget>[
          Container(
              width: 320.0,
              child: Text(
                "IT-Park Ankudinovka is a new modernized venue, combining"
                    " a business center, a technopark in the sphere of high"
                    " technologies, conference facilities and exhibition opportunities",
                style: Utils.subHeaderTextStyle2(),
                textAlign: TextAlign.center,
              ))
        ]));
  }
}
