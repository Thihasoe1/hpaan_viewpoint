import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hpaan_viewpoint/components/custom_text.dart';
import 'package:hpaan_viewpoint/model/categories_model.dart';
import 'package:hpaan_viewpoint/pages/card_detail.dart';
import 'package:hpaan_viewpoint/pages/widgets/scale_tapper.dart';
import 'package:latlong2/latlong.dart';

import '../const/const.dart';

class CategoryDetailPage extends StatelessWidget {
  const CategoryDetailPage({
    super.key,
    required this.categoryModel,
  });

  final Category? categoryModel;

  @override
  Widget build(BuildContext context) {
    return CategoryDeailBody(
      categoryModel: categoryModel,
    );
  }
}

class CategoryDeailBody extends StatefulWidget {
  const CategoryDeailBody({
    super.key,
    required this.categoryModel,
  });
  final Category? categoryModel;

  @override
  State<CategoryDeailBody> createState() => _CategoryDeailBodyState();
}

class _CategoryDeailBodyState extends State<CategoryDeailBody> {
  final MapController mapController = MapController();

  // ignore: unused_field

  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = [];
    if (widget.categoryModel?.place != null) {
      markers = widget.categoryModel!.place.map((place) {
        return Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(
            double.tryParse("${place['lat']}") ?? 0.0,
            double.tryParse("${place['long']}") ?? 0.0,
          ),
          child: const SizedBox(
            child: Icon(
              Icons.location_on,
              color: Colors.red,
              size: 40.0,
            ),
          ),
        );
      }).toList();
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
          centerTitle: true,
          elevation: 0.5,
          title: CustomText(
            text: widget.categoryModel?.name ?? "",
            fontFamily: "Lato",
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: MediaQuery(
                data: const MediaQueryData(textScaler: TextScaler.linear(1),),
                child: AppBar(
                  backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
                  bottom: TabBar(
                    physics: const NeverScrollableScrollPhysics(),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.teal,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: const TextStyle(
                      fontFamily: 'SF-Pro',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    indicatorColor: Colors.teal,
                    tabs: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.list_rounded,
                            size: 22,
                          ),
                          const SizedBox(width: 10),
                          const Tab(
                            text: "List",
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: CustomText(
                                text: "2",
                                fontFamily: "Lato",
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.teal,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.map_rounded,
                            size: 22,
                          ),
                          SizedBox(width: 10),
                          Tab(
                            text: "Map",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ListView.builder(
                    itemCount: widget.categoryModel?.place.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    itemBuilder: (context, index) {
                      return ScaleTapper(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CardDetail(
                                singlePlace: widget.categoryModel?.place[index],
                                marker: markers,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: 130,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  child: Image.asset(
                                    "${widget.categoryModel?.place[index]['imageUrl']}",
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[200]!,
                                        offset: const Offset(1, 2),
                                        blurRadius: 5,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    left: 16,
                                    right: 16,
                                  ),
                                  //width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text:
                                            "${widget.categoryModel?.place[index]['name']}",
                                        fontFamily: "Lato",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        maxLine: 1,
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on_rounded,
                                            size: 15,
                                            color: Colors.teal,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: CustomText(
                                              text:
                                                  "${widget.categoryModel?.place[index]['location']}",
                                              fontFamily: "Lato",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey,
                                              maxLine: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.reviews_rounded,
                                                size: 15,
                                                color: Colors.teal,
                                              ),
                                              const SizedBox(width: 5),
                                              CustomText(
                                                text:
                                                    "${widget.categoryModel?.place[index]['reviewCount']}",
                                                fontFamily: "Lato",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              const SizedBox(width: 3),
                                              CustomText(
                                                text: "Reviews",
                                                fontFamily: "Lato",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.timer_rounded,
                                                size: 15,
                                                color: Colors.teal,
                                              ),
                                              const SizedBox(width: 5),
                                              CustomText(
                                                text: (widget.categoryModel
                                                                ?.place[index]
                                                            ['isOpen'] ??
                                                        false)
                                                    ? "isOpen"
                                                    : "isClosed",
                                                fontFamily: "Lato",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on_rounded,
                                                size: 15,
                                                color: Colors.teal,
                                              ),
                                              const SizedBox(width: 5),
                                              CustomText(
                                                text:
                                                    "${widget.categoryModel?.place[index]['distance'] ?? ""} km",
                                                fontFamily: "Lato",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  // second tab bar view widget

                  SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: FlutterMap(
                      mapController: mapController,
                      options: const MapOptions(
                        initialCenter: LatLng(16.7907, 96.1590),
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
                        MarkerLayer(markers: markers),
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
