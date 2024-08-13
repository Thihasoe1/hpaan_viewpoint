import 'package:flutter/material.dart';

import '../../components/custom_text.dart';
import '../search_page/search_page.dart';

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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

            child: SizedBox(
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
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchPage(),),);
              },
              child: Center(
                child: Hero(
                  tag: "searchbar",
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
                          Image.asset(
                            "assets/images/search_icon.png",
                            height: 20,
                            fit: BoxFit.cover,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
