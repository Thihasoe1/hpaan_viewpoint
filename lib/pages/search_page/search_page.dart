import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hpaan_viewpoint/components/custom_text.dart';
import 'package:hpaan_viewpoint/pages/widgets/scale_tapper.dart';
import '../../controller/search_controller.dart';
import '../card_detail.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchPlaceController searchController =
      Get.put(SearchPlaceController());

  final TextEditingController searchCtrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "searchbar",
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
          scrolledUnderElevation: 0.0,
          elevation: 0.0,
          title: CustomText(
            text: "Search Page",
            fontFamily: "SF-Pro",
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        //width: double.infinity, // Use full width of the screen
                        child: MediaQuery(
                          data: const MediaQueryData(
                            textScaler: TextScaler.linear(1),
                          ),
                          child: TextFormField(
                            onFieldSubmitted: (newValue) {
                              searchController.searchPlaces(newValue);
                            },
                            controller: searchCtrl,
                            cursorColor: Colors.teal,
                            textInputAction: TextInputAction.search,
                            style: const TextStyle(
                              fontFamily: "SF-Pro",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              hintText: "Search your favourite places..",
                              hintStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'SF-Pro',
                                color: Colors.grey.shade400,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.8),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.teal,
                                  width: 1.4,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  width: 1.4,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 10,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1.4,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    ScaleTapper(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        searchController.searchPlaces(searchCtrl.text.trim());
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Center(
                          child: Icon(
                            CupertinoIcons.search,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Obx(() {
                  if (searchController.searchResults.isEmpty) {
                    return Center(
                      child: CustomText(
                        text: "No results found",
                        fontFamily: "SF-Pro",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  } else {
                    return GridView.builder(
                      padding: const EdgeInsets.only(bottom: 20),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: searchController.searchResults.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 0,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        final place = searchController.searchResults[index];
                        return Stack(
                          children: [
                            ScaleTapper(
                              onTap: () => Get.to(
                                CardDetail(
                                  singlePlace: place,
                                ),
                              ),
                              child: Container(
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
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          top: 8,
                                          left: 8,
                                          right: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.teal,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.asset(
                                            "${place['imageUrl']}",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
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
                                            color: Colors.teal,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: CustomText(
                                              text: "${place['location']}",
                                              fontFamily: "Lato",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              maxLine: 2,
                                            ),
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
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
