import 'package:flutter/material.dart';
import '../../components/custom_text.dart';

class PopularPlaces extends StatelessWidget {
  const PopularPlaces({
    super.key,
    required this.popularPlace,
  });

  final List<dynamic> popularPlace;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 215,
      child: ListView.builder(
        itemCount: popularPlace.first.data.length,
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
          final popularPlaceResult = popularPlace.first.data;
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
                    Expanded(
                      child: Container(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        top: 5,
                        right: 6,
                      ),
                      child: CustomText(
                        text: "${popularPlaceResult[index]['name']}",
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
    );
  }
}
