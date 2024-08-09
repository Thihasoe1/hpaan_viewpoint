import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hpaan_viewpoint/pages/widgets/scale_tapper.dart';
import 'package:latlong2/latlong.dart';

class TrackingLocationPage extends StatefulWidget {
  const TrackingLocationPage({super.key});

  @override
  State<TrackingLocationPage> createState() => _TrackingLocationPageState();
}

class _TrackingLocationPageState extends State<TrackingLocationPage> {
  MapController controller = MapController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: controller,
            options: const MapOptions(
              initialCenter: LatLng(16.7907, 96.1590),
              initialZoom: 13,
              minZoom: 7,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
                errorImage: const NetworkImage(
                  'https://via.placeholder.com/256.png?text=Tile+Not+Available',
                ),
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
        ],
      ),
    );
  }
}
