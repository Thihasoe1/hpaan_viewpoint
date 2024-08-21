// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hpaan_viewpoint/components/custom_shimmer.dart';
import 'package:hpaan_viewpoint/components/custom_text.dart';
import 'package:hpaan_viewpoint/controller/category_controller.dart';
import 'package:hpaan_viewpoint/controller/popular_places_controller.dart';
import 'package:hpaan_viewpoint/pages/category_detail_page.dart';
import 'package:hpaan_viewpoint/pages/widgets/category_card.dart';
import 'package:hpaan_viewpoint/pages/widgets/fade_animation.dart';
import 'package:hpaan_viewpoint/pages/widgets/home_page_app_bar.dart';
import 'package:hpaan_viewpoint/pages/widgets/popular_place.dart';
import 'package:hpaan_viewpoint/pages/widgets/scale_tapper.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../model/data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<MarkerData>> futureMarkers;

  CategoryController categoryController = Get.put(CategoryController());
  PopularPlacesController popularPlacesController =
      Get.put(PopularPlacesController());

  @override
  void initState() {
    super.initState();
    categoryController.getCategoryList();
    popularPlacesController.getPopularPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFadeInAnimation(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomePageAppBar(),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomText(
                  text: "Category",
                  fontFamily: "SF-Pro",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GetBuilder<CategoryController>(
                init: CategoryController(),
                builder: (GetxController controller) {
                  debugPrint(
                      "category list ==> ${categoryController.categoryList}");
                  return categoryController.isLoading
                      ? GridView.builder(
                          padding: const EdgeInsets.only(
                            left: 16,
                            top: 12,
                            bottom: 12,
                            right: 16,
                          ),
                          shrinkWrap: true,
                          itemCount: 6,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.4,
                          ),
                          itemBuilder: (context, index) {
                            return CustomShimmer(
                              child: Container(
                                // width: 100,
                                // height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.shade100,
                                ),
                              ),
                            );
                          },
                        )
                      : Skeletonizer(
                          enabled: categoryController.isLoading,
                          child: GridView.builder(
                            padding: const EdgeInsets.only(
                              left: 16,
                              top: 12,
                              bottom: 12,
                              right: 16,
                            ),
                            shrinkWrap: true,
                            itemCount: categoryController.categoryList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1.4,
                            ),
                            itemBuilder: (context, index) {
                              return ScaleTapper(
                                onTap: () {
                                  HapticFeedback.mediumImpact();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => CategoryDetailPage(
                                        categoryModel: categoryController
                                            .categoryList[index],
                                      ),
                                    ),
                                  );
                                },
                                child: CategoryCard(
                                  categoryController: categoryController,
                                  categoryIndex: index,
                                ),
                              );
                            },
                          ),
                        );
                },
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomText(
                  text: "Popular places",
                  fontFamily: "SF-Pro",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GetBuilder<PopularPlacesController>(
                builder: (controller) {
                  //print("controller =========>${popularPlacesController.popularPlaceList.first.data.first}");
                  return popularPlacesController.isLoading
                      ? SizedBox(
                          height: 180,
                          child: ListView.builder(
                            itemCount: 4,
                            physics: const BouncingScrollPhysics(
                              decelerationRate: ScrollDecelerationRate.fast,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return CustomShimmer(
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      width: 170,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(13),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.white,
                                            offset:  Offset(0, 2),
                                            spreadRadius: 3,
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                top: 8,
                                                left: 8,
                                                right: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8,
                                              top: 5,
                                              right: 6,
                                            ),
                                            child: Container(
                                              color: Colors.white,
                                              height: 10,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8,
                                              top: 5,
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.location_on_rounded,
                                                  size: 15,
                                                  color: Color(0xFF252525),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  height: 10,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: 20,
                                      top: 10,
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black12,
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.favorite_rounded,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      : PopularPlaces(
                          popularPlace:
                              popularPlacesController.popularPlaceList,
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
