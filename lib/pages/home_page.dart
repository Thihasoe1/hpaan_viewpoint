// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hpaan_viewpoint/components/custom_text.dart';
import 'package:hpaan_viewpoint/controller/category_controller.dart';
import 'package:hpaan_viewpoint/pages/widgets/scale_tapper.dart';

import '../model/data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<MarkerData>> futureMarkers;

  CategoryController categoryController = Get.put(CategoryController());

  @override
  void initState() {
    super.initState();
    //futureMarkers = fetchMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
      body: SingleChildScrollView(
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
            GetBuilder<CategoryController>(
              init: CategoryController(),
              builder: (GetxController controller) {
                categoryController.getCategoryList();

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
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xFFC0C0C0).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(1, 1),
                                  ),
                                  const BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(-1, -1),
                                    blurRadius: 2,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                          left: 4,
                                          top: 5,
                                        ),
                                        width: 40,
                                        height: 40,
                                        padding: const EdgeInsets.all(5),
                                        child: Image.asset(
                                          categoryController
                                              .categoryList[index].icon,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      top: 6,
                                    ),
                                    child: SizedBox(
                                      child: CustomText(
                                        text: categoryController
                                            .categoryList[index].name,
                                        fontFamily: 'Lato',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF252525),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomText(
                text: "Popular places",
                fontFamily: "Lato",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 215,
              child: ListView.builder(
                itemCount: 5,
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
                  return Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 170,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade100,
                              offset: const Offset(0, 2),
                              spreadRadius: 3,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 100,
                              margin: const EdgeInsets.only(
                                top: 8,
                                left: 8,
                                right: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                top: 5,
                                right: 6,
                              ),
                              child: CustomText(
                                text:
                                    "This is title This is title This is title",
                                fontFamily: "Lato",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                maxLine: 2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                top: 5,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.location_on_rounded,
                                    size: 15,
                                    color: Color(0xFF252525),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  CustomText(
                                    text: "Location",
                                    fontFamily: "Lato",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
