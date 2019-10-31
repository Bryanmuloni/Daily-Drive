import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  Geolocator geoLocator = Geolocator()..forceAndroidLocationManager;
  String _currentAddress;

  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _nkoma = const LatLng(1.1027, 34.1970);
  static const LatLng _bugema = const LatLng(1.0456, 34.1824);
  static const LatLng _nakaloke = const LatLng(1.1430, 34.1650);

  LatLng _lastMapPosition = _nkoma;
  final Map<String, Marker> _newMmarkers = {};

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    final Set<Marker> _markers = {
      Marker(
          markerId: MarkerId('Nkoma'),
          position: _nkoma,
          infoWindow: InfoWindow(title: 'Nkoma', snippet: 'Mbale'),
          onTap: () {
            showModalBottomSheet(
                context: (context),
                builder: (context) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Column(
                      children: <Widget>[
                        Container(
                          color: Colors.pink,
                          height: 90,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Hansu Mobile Innovations',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22.0),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      'For your intelligent innovations',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.directions_bus,
                                    color: Colors.pink,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50.0, top: 10.0),
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.call,
                                    color: Colors.pink,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'CALL',
                                    style: TextStyle(color: Colors.pink),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 50.0,
                              ),
                              Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.web,
                                    color: Colors.pink,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'WEBSITE',
                                    style: TextStyle(color: Colors.pink),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 50.0,
                              ),
                              Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.share,
                                    color: Colors.pink,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'SHARE',
                                    style: TextStyle(color: Colors.pink),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Column(
                          children: <Widget>[
                            ListTile(
                              leading: Icon(
                                Icons.location_on,
                                color: Colors.pink,
                              ),
                              title: Text('Mission Road, Mbale'),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.access_time,
                                color: Colors.pink,
                              ),
                              title: Text('Open Monday to Friday'),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.link,
                                color: Colors.pink,
                              ),
                              title: Text('https://www.hansumi.com'),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                });
          },
          icon: BitmapDescriptor.defaultMarker),
      Marker(
          markerId: MarkerId('Bugema'),
          position: _bugema,
          infoWindow: InfoWindow(title: 'Bugema', snippet: 'Mbale'),
          icon: BitmapDescriptor.defaultMarker),
      Marker(
        markerId: MarkerId('Nakaloke'),
        position: _nakaloke,
        infoWindow: InfoWindow(title: 'Nakaloke', snippet: 'Mbale'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
      )
    };
    List<LatLng> polygons1 = [_nkoma, _bugema, _nakaloke];

    Set<Polygon> _polygons = {
      Polygon(
          polygonId: PolygonId('polygon1'),
          points: polygons1,
          fillColor: Colors.transparent,
          strokeColor: Colors.pinkAccent,
          strokeWidth: 8,
          geodesic: true)
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Drive'),
        backgroundColor: Colors.indigo,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationEnabled: true,
            polygons: _polygons,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _nkoma,
              zoom: 12.0,
            ),
            mapType: _currentMapType,
            markers: _markers,
            onCameraMove: _onCameraMove,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: _onMapTypeButtonPressed,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.pink,
                    child: const Icon(Icons.map, size: 36.0),
                  ),
                  SizedBox(height: 16.0),
                  FloatingActionButton(
                    onPressed: () {
                      _getLocation();
                    },
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.pink,
                    child: const Icon(Icons.add_location, size: 36.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _getLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    List<Placemark> placemark = await geoLocator.placemarkFromCoordinates(
        currentLocation.latitude, currentLocation.longitude);
    Placemark address = placemark[0];

    setState(() {
      _currentAddress = "${address.locality}, ${address.country}";
      final marker = Marker(
        markerId: MarkerId("curr_loc"),
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
        infoWindow: InfoWindow(title: _currentAddress),
      );
      _newMmarkers["Current Location"] = marker;
      print(currentLocation.longitude + currentLocation.latitude);
    });
  }
}
