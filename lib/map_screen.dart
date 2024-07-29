import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_route_service/open_route_service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LatLng myPoint;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();
  Position? _position;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    myPoint = defaultPoint;
    _scrollController.addListener(_onScroll);
  }

  final defaultPoint = const LatLng(16.875061, 97.632339);
  LatLng? _currentPosition;

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
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = LatLng(_position!.latitude, _position!.longitude);
      mapController.move(_currentPosition!, 13.0);
    });
  }

  final List<LatLng> _markerPositions = const [
    LatLng(16.82442, 97.66831),
    LatLng(16.8119, 97.6568),
    LatLng(16.8084, 97.6691),
  ];
  var realMarkerPositions = [
    {
      "name": "Pagoda 1",
      "address": "Hpa an 2",
      "image": "",
      "lat": "16.82442",
      "long": "97.66831",
    },
    {
      "name": "Pagoda 2",
      "address": "Hpa an 2",
      "image": "",
      "lat": "16.8119",
      "long": "97.6568",
    },
    {
      "name": "Pagoda 3",
      "address": "Hpa an 3",
      "image": "",
      "lat": "16.8084",
      "long": "97.6691",
    },
  ];

  List listOfPoints = [];
  List<LatLng> points = [];
  List<Marker> markers = [];
  List<Marker> markerTwo = [
    const Marker(
      point: LatLng(16.9459346, 97.9592863),
      width: 80,
      height: 80,
      child: FlutterLogo(),
    ),
  ];

  Future<void> getCoordinates(LatLng lat1, LatLng lat2) async {
    setState(() {
      isLoading = true;
    });

    final OpenRouteService client = OpenRouteService(
      apiKey: '5b3ce3597851110001cf62484cc1689c02da4dc79972717d111b7ffc',
    );

    try {
      final List<ORSCoordinate> routeCoordinates =
          await client.directionsRouteCoordsGet(
        startCoordinate: ORSCoordinate(
            latitude: _position!.latitude, longitude: _position!.longitude),
        endCoordinate:
            ORSCoordinate(latitude: lat2.latitude, longitude: lat2.longitude),
      );

      final List<LatLng> routePoints = routeCoordinates
          .map(
              (coordinate) => LatLng(coordinate.latitude, coordinate.longitude))
          .toList();

      setState(() {
        points = routePoints;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Failed to fetch route coordinates: $e");
    }
  }

  final MapController mapController = MapController();

  void _onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double scrollPosition = _scrollController.position.pixels;
    double scrollFraction = scrollPosition / maxScroll;

    int targetIndex = (scrollFraction * (_markerPositions.length - 1)).round();
    mapController.move(_markerPositions[targetIndex], 13.0);
  }

  void _handleTap(LatLng latLng) {
    setState(() {
      if (markers.length < 2) {
        markers.add(
          Marker(
            point: latLng,
            width: 80,
            height: 80,
            child: Draggable(
              feedback: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.location_on),
                color: Colors.black,
                iconSize: 45,
              ),
              onDragEnd: (details) {
                setState(() {
                  print(
                      "Latitude: ${latLng.latitude}, Longitude: ${latLng.longitude}");
                });
              },
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.location_on),
                color: Colors.black,
                iconSize: 45,
              ),
            ),
          ),
        );
      }

      if (markers.length == 1) {
        double zoomLevel = 13;
        mapController.move(latLng, zoomLevel);
      }

      if (markers.length == 2) {
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            isLoading = true;
          });
        });

        getCoordinates(markers[0].point, markers[1].point);

        // Calcular a extensão (bounding box) que envolve os dois pontos marcados
        LatLngBounds bounds = LatLngBounds.fromPoints(
          markers.map((marker) => marker.point).toList(),
        );
        // Fazer um zoom out para que a extensão se ajuste à tela
        mapController.fitCamera(
          CameraFit.bounds(bounds: bounds),
        );
      }
    });
  }

  int _selectedMarkerIndex = -1;

  void _onMarkerTapped(int index) {
    setState(() {
      _selectedMarkerIndex = index;
    });
    mapController.move(_markerPositions[index], 13.0);
    _scrollController.animateTo(
      index * 200.0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialZoom: 13,
              initialCenter: myPoint,
              onTap: (tapPosition, latLng) => _handleTap(latLng),
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
              ),
              if (_currentPosition != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _currentPosition!,
                      child: const SizedBox(
                        child: Icon(
                          Icons.my_location_rounded,
                          color: Colors.blue,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              MarkerLayer(
                markers: _markerPositions.asMap().entries.map((entry) {
                  int index = entry.key;
                  LatLng position = entry.value;
                  return Marker(
                    width: 80.0,
                    height: 80.0,
                    point: position,
                    child: GestureDetector(
                      onTap: () => _onMarkerTapped(index),
                      child: Icon(
                        Icons.location_on,
                        color: _selectedMarkerIndex == index
                            ? Colors.blue
                            : Colors.red,
                        size: 40,
                      ),
                    ),
                  );
                }).toList(),
              ),
              PolylineLayer(
                polylineCulling: false,
                polylines: [
                  Polyline(
                    points: points,
                    color: Colors.black,
                    strokeWidth: 5,
                  ),
                ],
              ),
            ],
          ),
          Visibility(
            visible: isLoading,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          // Positioned(
          //   bottom: 0,
          //   child: SizedBox(
          //     height: 200,
          //     width: MediaQuery.of(context).size.width,
          //     child: PageView.builder(
          //       itemCount: 3,
          //       itemBuilder: (context, index) {
          //         return Container(
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(20),
          //             color: Colors.white,
          //           ),
          //           margin: const EdgeInsets.symmetric(
          //             horizontal: 10,
          //             vertical: 30,
          //           ),
          //           height: 100,
          //         );
          //       },
          //     ),
          //   ),
          // ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                itemCount: _markerPositions.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      mapController.move(_markerPositions[index], 13.0);
                    },
                    child: Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Location ${index + 1}'),
                            const SizedBox(height: 8.0),
                            Text(
                              'Lat: ${_markerPositions[index].latitude}, Lng: ${_markerPositions[index].longitude}',
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     const SizedBox(height: 10),
      //     FloatingActionButton(
      //       backgroundColor: Colors.black,
      //       onPressed: () {
      //         mapController.move(
      //           mapController.camera.center,
      //           mapController.camera.zoom + 1,
      //         );
      //       },
      //       child: const Icon(
      //         Icons.add,
      //         color: Colors.white,
      //       ),
      //     ),
      //     const SizedBox(height: 10),
      //     FloatingActionButton(
      //       backgroundColor: Colors.black,
      //       onPressed: () {
      //         mapController.move(mapController.center, mapController.zoom - 1);
      //       },
      //       child: const Icon(
      //         Icons.remove,
      //         color: Colors.white,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
