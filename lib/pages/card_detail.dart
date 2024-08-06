import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hpaan_viewpoint/components/custom_text.dart';
import 'package:hpaan_viewpoint/model/categories_list_model.dart';
import 'package:hpaan_viewpoint/pages/widgets/scale_tapper.dart';
import 'package:latlong2/latlong.dart';

class CardDetail extends StatefulWidget {
  const CardDetail(
      {super.key,
      required this.singlePlace,
      required this.marker,
      required this.currentPosition});

  final dynamic singlePlace;
  final List<Marker> marker;
  final LatLng currentPosition;

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  @override
  Widget build(BuildContext context) {
    //print("this is card detail ==> ${widget.singlePlace}");

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        appBar: AppBar(
          centerTitle: true,
          title: CustomText(
            text: "${widget.singlePlace['name']}",
            fontFamily: "Lato",
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 230,
              width: double.infinity,
              child: Image.asset(
                "${widget.singlePlace['imageUrl']}",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: AppBar(
                backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
                automaticallyImplyLeading: false,
                bottom: const TabBar(
                  physics: NeverScrollableScrollPhysics(),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.teal,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  indicatorColor: Colors.teal,
                  tabs: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Tab(
                          text: "About",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Tab(
                          text: "Review",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Tab(
                          text: "Tracking",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 15,
                    ),
                    child: Column(
                      children: [
                        CustomText(
                          text: "${widget.singlePlace['description']}",
                          fontFamily: "Lato",
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                        const SizedBox(height: 20),
                        // Container(
                        //   height: 60,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(16),
                        //     color: Colors.green,
                        //   ),
                        //   child: Center(
                        //     child: CustomText(
                        //       text: "Tracking Location",
                        //       fontFamily: "Lato",
                        //       fontSize: 16,
                        //       fontWeight: FontWeight.w500,
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  // second tab bar view widget
                  Container(
                    color: Colors.amberAccent,
                  ),
                  Container(
                    color: Colors.redAccent,
                    child: FlutterMap(
                      options: const MapOptions(
                        initialCenter: LatLng(16.875061, 97.632339),
                        initialZoom: 13,
                        minZoom: 8,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        RichAttributionWidget(
                          attributions: [
                            TextSourceAttribution(
                              'OpenStreetMap contributors',
                              onTap: () {},
                            ),
                          ],
                        ),
                        MarkerLayer(markers: widget.marker),
                        MarkerLayer(
                          markers: [
                            Marker(
                              width: 80.0,
                              height: 80.0,
                              point: widget.currentPosition,
                              child: const SizedBox(
                                child: Icon(
                                  Icons.my_location_rounded,
                                  color: Colors.blueAccent,
                                  size: 20.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        PolylineLayer(
                          polylines: [
                            Polyline(
                              strokeWidth: 2,
                              color: Colors.black,
                              points: [
                                widget.currentPosition,
                                LatLng(
                                  double.tryParse(
                                          "${widget.singlePlace['lat']}") ??
                                      0.0,
                                  double.tryParse(
                                          "${widget.singlePlace['long']}") ??
                                      0.0,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
