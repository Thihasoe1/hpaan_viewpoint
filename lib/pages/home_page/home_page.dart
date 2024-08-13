// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hpaan_viewpoint/components/custom_text.dart';
import 'package:hpaan_viewpoint/controller/category_controller.dart';
import 'package:hpaan_viewpoint/controller/popular_places_controller.dart';
import 'package:hpaan_viewpoint/pages/category_detail_page.dart';
import 'package:hpaan_viewpoint/pages/widgets/category_card.dart';
import 'package:hpaan_viewpoint/pages/widgets/fade_animation.dart';
import 'package:hpaan_viewpoint/pages/widgets/home_page_app_bar.dart';
import 'package:hpaan_viewpoint/pages/widgets/popular_place.dart';
import 'package:hpaan_viewpoint/pages/widgets/scale_tapper.dart';
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
                  fontFamily: "Lato",
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
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : GridView.builder(
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
                        );
                },
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomText(
                  text: "Popular places",
                  fontFamily: "Lato",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GetBuilder<PopularPlacesController>(
                builder: (controller) {

                  print("controller =========>${popularPlacesController.popularPlaceList.first.data.first}");
                  return popularPlacesController.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const PopularPlaces();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
