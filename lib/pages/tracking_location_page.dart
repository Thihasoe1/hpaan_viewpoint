import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hpaan_viewpoint/pages/widgets/current_position_animation.dart';
import 'package:hpaan_viewpoint/pages/widgets/scale_tapper.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:math' show cos, sqrt, asin;

import '../const/const.dart';

class TrackingLocationPage extends StatefulWidget {
  const TrackingLocationPage({
    super.key,
    required this.lat,
    required this.long,
  });

  final double lat;
  final double long;

  @override
  State<TrackingLocationPage> createState() => _TrackingLocationPageState();
}

class _TrackingLocationPageState extends State<TrackingLocationPage>
    with WidgetsBindingObserver {
  MapController controller = MapController();

  LatLng _currentPosition = const LatLng(16.8076, 96.1544);
  bool _loading = true;
  late LatLng _destination;
  List<LatLng> _routePoints = [];
  double distance = 0.0;

  ///16.8076, 96.1544
  StreamSubscription<Position>? _positionStreamSubscription;

  @override
  void initState() {
    super.initState();
    debugPrint("init state working");
    WidgetsBinding.instance.addObserver(this);
    _getCurrentLocation();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _positionStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (_currentPosition != null && _destination != null) {
        _fetchRoute(_currentPosition, _destination);
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // Update every 10 meters
    );

    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position position) {
      setState(() {
        _destination = const LatLng(16.8455, 96.1190);
        _currentPosition = LatLng(position.latitude, position.longitude);
        _loading = false;
      });
      _fetchRoute(_currentPosition, _destination);
    });
  }

  Future<void> _fetchRoute(LatLng start, LatLng end) async {
    final String url =
        'https://api.mapbox.com/directions/v5/mapbox/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?geometries=geojson&access_token=$accessToken';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final route = data['routes'][0]['geometry']['coordinates'];
      var distanceResult = data['routes'][0]['distance'];

      List<LatLng> points = [];
      for (var point in route) {
        points.add(LatLng(point[1], point[0]));
      }
      setState(() {
        distance = distanceResult / 1000;
        _routePoints = points;
      });
    } else {
      throw Exception('Failed to load route');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: controller,
            options: MapOptions(
              initialCenter: _currentPosition,
              initialZoom: 13,
              minZoom: 7,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=$accessToken',
                additionalOptions: const {
                  'accessToken': accessToken,
                  'id': mapboxStyle,
                },
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: _currentPosition,
                    child: const WaveAnimation(
                      size: 22,
                      color: Colors.blue,
                      centerChild: Icon(
                        CupertinoIcons.location_fill,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                  const Marker(
                    alignment: Alignment.center,
                    width: 80.0,
                    height: 80.0,
                    //point: LatLng(widget.lat, widget.long),
                    point: LatLng(16.8455, 96.1190),
                    child: SizedBox(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Icon(
                          Icons.location_on_rounded,
                          color: Colors.red,
                          size: 30.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    strokeWidth: 4,
                    color: Colors.blueAccent,
                    points: _routePoints,
                  ),
                ],
              ),
              // RichAttributionWidget(
              //   attributions: [
              //     TextSourceAttribution(
              //       'OpenStreetMap contributors',
              //       onTap: () {},
              //     ),
              //   ],
              // ),
              //MarkerLayer(markers: markers),
              // MarkerLayer(
              //   markers: [
              //     Marker(
              //       width: 80.0,
              //       height: 80.0,
              //       point: ,
              //       child: const SizedBox(
              //         child: Icon(
              //           Icons.my_location,
              //           color: Colors.red,
              //           size: 25.0,
              //         ),
              //       ),
              //     ),
              //     Marker(
              //       width: 80.0,
              //       height: 80.0,
              //       alignment: Alignment.topCenter,
              //       point: ,
              //       child: const SizedBox(
              //         child: Icon(
              //           Icons.location_on,
              //           color: Colors.red,
              //           size: 40.0,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
          Positioned(
            top: 50,
            left: 16,
            child: Row(
              children: [
                ScaleTapper(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: const Color.fromARGB(232, 255, 255, 255),
                    ),
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.keyboard_arrow_left_rounded,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 50,
              color: Colors.white,
              child: Center(
                child: Text("$distance km"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
