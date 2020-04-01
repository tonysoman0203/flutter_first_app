import 'package:flutter/material.dart';
import 'package:flutter_first_app/src/locations.dart' as locations;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMap extends StatefulWidget {
  MyMap({Key key}) : super(key: key);

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Google Map"),
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: _markers.values.toSet(),
          initialCameraPosition: CameraPosition(
            target: const LatLng(0, 0),
            zoom: 2.0,
          ),
        ));
  }
}
