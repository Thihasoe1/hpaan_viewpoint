// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hpaan_viewpoint/components/custom_text.dart';
import 'package:hpaan_viewpoint/pages/category_detail_page.dart';
import 'package:hpaan_viewpoint/pages/widgets/scale_tapper.dart';

import '../model/data.dart';
import '../services/service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<MarkerData>> futureMarkers;

  @override
  void initState() {
    super.initState();
    futureMarkers = fetchMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: Colors.white,
      //   title: Text(
      //     'Hpa an',
      //     style: Theme.of(context).textTheme.headlineLarge,
      //   ),
      //   actions: const [
      //     CircleAvatar(
      //       radius: 16,
      //     ),
      //     SizedBox(
      //       width: 16,
      //     ),
      //   ],
      // ),
      body: FutureBuilder<List<MarkerData>>(
        future: futureMarkers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<MarkerData>? data = snapshot.data;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.31,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.28,
                          width: double.infinity,
                          child: Image.asset(
                            "assets/images/bg.jpeg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.28,
                          width: double.infinity,
                          color: Colors.black.withOpacity(0.3),
                        ),
                        Positioned(
                          top: 55,
                          left: 16,
                          right: 16,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    //color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 4,
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.location_pin,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      CustomText(
                                        text: "My Location",
                                        fontFamily: "Lato",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 120,
                          left: 16,
                          // right: 16,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.44,
                            //color: Colors.teal,
                            child: CustomText(
                              text: "Where you want to go?",
                              fontFamily: "Lato",
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 16,
                          right: 16,
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 0.6,
                                color: Colors.black54,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.search_rounded,
                                    size: 23,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CustomText(
                                    text: "Search destination",
                                    fontFamily: "Lato",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Container(
                        //   color: Colors.amber,
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Padding(
                        //         padding: const EdgeInsets.only(
                        //           left: 16,
                        //           right: 16,
                        //           top: 20,
                        //         ),
                        //         child: Text(
                        //           "Popular places",
                        //           style: Theme.of(context).textTheme.bodyLarge,
                        //         ),
                        //       ),
                        //       Container(
                        //         margin: const EdgeInsets.only(top: 15),
                        //         height: 250,
                        //         child: Swiper(
                        //           itemHeight: 200,
                        //           itemWidth: MediaQuery.of(context).size.width,
                        //           curve: Curves.linear,
                        //           itemCount: data?.length ?? 0,
                        //           itemBuilder: (context, index) {
                        //             return Stack(
                        //               children: [
                        //                 Container(
                        //                   height: 220,
                        //                   decoration: BoxDecoration(
                        //                     borderRadius: BorderRadius.circular(15),
                        //                     color: Colors.white,
                        //                     boxShadow: [
                        //                       BoxShadow(
                        //                         color: Colors.grey.shade100,
                        //                         offset: const Offset(2, 1),
                        //                         spreadRadius: 8,
                        //                         blurRadius: 10,
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   child: Column(
                        //                     crossAxisAlignment:
                        //                         CrossAxisAlignment.start,
                        //                     children: [
                        //                       SizedBox(
                        //                         height: 140,
                        //                         width: MediaQuery.of(context)
                        //                             .size
                        //                             .width,
                        //                         child: ClipRRect(
                        //                           borderRadius:
                        //                               const BorderRadius.only(
                        //                             topLeft: Radius.circular(15),
                        //                             topRight: Radius.circular(15),
                        //                           ),
                        //                           child: Image.asset(
                        //                             data?[index].image ?? "",
                        //                             fit: BoxFit.cover,
                        //                           ),
                        //                         ),
                        //                       ),
                        //                       Padding(
                        //                         padding: const EdgeInsets.only(
                        //                             top: 8, left: 9),
                        //                         child: Column(
                        //                           crossAxisAlignment:
                        //                               CrossAxisAlignment.start,
                        //                           children: [
                        //                             Text(
                        //                               "${data?[index].name}",
                        //                               style: const TextStyle(
                        //                                 fontSize: 16,
                        //                                 fontWeight: FontWeight.w500,
                        //                               ),
                        //                             ),
                        //                             const SizedBox(
                        //                               height: 8,
                        //                             ),
                        //                             Row(
                        //                               children: [
                        //                                 const Icon(
                        //                                   Icons.location_on_rounded,
                        //                                   size: 17,
                        //                                   color: Colors.teal,
                        //                                 ),
                        //                                 const SizedBox(
                        //                                   width: 5,
                        //                                 ),
                        //                                 CustomText(
                        //                                   text:
                        //                                       "${data?[index].addres}",
                        //                                   fontFamily: "Pyidaungsu",
                        //                                   fontSize: 14,
                        //                                   fontWeight:
                        //                                       FontWeight.w400,
                        //                                 ),
                        //                               ],
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ],
                        //             );
                        //           },
                        //           indicatorLayout: PageIndicatorLayout.COLOR,
                        //           autoplay: true,
                        //           duration: kDefaultAutoplayTransactionDuration,
                        //           pagination: const SwiperPagination(
                        //             builder: DotSwiperPaginationBuilder(
                        //               size: 8,
                        //               space: 6,
                        //               color: Colors.grey,
                        //             ),
                        //           ),
                        //           viewportFraction: 0.8,
                        //           scale: 0.9,
                        //           //control: const SwiperControl(),
                        //         ),
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.only(
                        //           top: 18,
                        //           left: 16,
                        //           right: 16,
                        //           bottom: 10,
                        //         ),
                        //         child: Text(
                        //           "Category",
                        //           style: Theme.of(context).textTheme.bodyLarge,
                        //         ),
                        //       ),
                        //       FutureBuilder(
                        //         future: fetchCategories(),
                        //         builder: (context, snapshot) {
                        //           debugPrint("category list ===> ${snapshot.data}");
                        //           final categoryList = snapshot.data;

                        //           if (snapshot.connectionState ==
                        //               ConnectionState.waiting) {
                        //             return const Center(
                        //               child: CircularProgressIndicator(),
                        //             );
                        //           }
                        //           if (snapshot.connectionState ==
                        //               ConnectionState.done) {
                        //             return GridView.builder(
                        //               shrinkWrap: true,
                        //               itemCount: categoryList?.length ?? 0,
                        //               padding: const EdgeInsets.symmetric(
                        //                 horizontal: 16,
                        //                 vertical: 8,
                        //               ),
                        //               gridDelegate:
                        //                   const SliverGridDelegateWithFixedCrossAxisCount(
                        //                 crossAxisCount: 3,
                        //                 mainAxisSpacing: 30,
                        //                 crossAxisSpacing: 20,
                        //                 childAspectRatio: 0.8,
                        //               ),
                        //               itemBuilder: (context, index) {
                        //                 return ScaleTapper(
                        //                   onTap: () {
                        //                     Navigator.push(
                        //                       context,
                        //                       MaterialPageRoute(
                        //                         builder: (context) =>
                        //                             CategoryDetailPage(
                        //                           categoryModel:
                        //                               categoryList?[index],
                        //                         ),
                        //                       ),
                        //                     );
                        //                   },
                        //                   child: Container(
                        //                     decoration: BoxDecoration(
                        //                       borderRadius:
                        //                           BorderRadius.circular(20),
                        //                       color: Colors.white,
                        //                       boxShadow: [
                        //                         BoxShadow(
                        //                           color: Colors.blueGrey.shade50,
                        //                           offset: const Offset(0, 2),
                        //                           blurRadius: 10,
                        //                           spreadRadius: 2,
                        //                         ),
                        //                       ],
                        //                     ),
                        //                     child: Column(
                        //                       crossAxisAlignment:
                        //                           CrossAxisAlignment.center,
                        //                       mainAxisAlignment:
                        //                           MainAxisAlignment.center,
                        //                       children: [
                        //                         SizedBox(
                        //                           width: 40,
                        //                           height: 40,
                        //                           child: Image.asset(
                        //                             categoryList?[index].icon ?? "",
                        //                             fit: BoxFit.cover,
                        //                           ),
                        //                         ),
                        //                         const SizedBox(
                        //                           height: 10,
                        //                         ),
                        //                         CustomText(
                        //                           text: categoryList?[index].name ??
                        //                               "",
                        //                           fontFamily: "Lato",
                        //                           fontSize: 12,
                        //                           fontWeight: FontWeight.w500,
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 );
                        //               },
                        //             );
                        //           } else {
                        //             return Center(
                        //               child: CustomText(
                        //                 text: "${snapshot.error}",
                        //                 fontFamily: "Lato",
                        //                 fontSize: 14,
                        //                 fontWeight: FontWeight.w400,
                        //               ),
                        //             );
                        //           }
                        //         },
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomText(
                      text: "Category",
                      fontFamily: "Lato",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    //color: Colors.teal,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 100,
                          margin: const EdgeInsets.only(
                            right: 13,
                            top: 12,
                            bottom: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 245, 245, 245),
                                offset: Offset(0, 1),
                                spreadRadius: 3,
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text("$index"),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

Stream<Position> getPositionStream() {
  return Geolocator.getPositionStream(
    locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // Update location every 10 meters
    ),
  );
}
