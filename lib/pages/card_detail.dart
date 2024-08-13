import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hpaan_viewpoint/components/custom_text.dart';
import 'package:hpaan_viewpoint/pages/tracking_location_page.dart';
import 'package:hpaan_viewpoint/pages/widgets/expandable_text.dart';
import 'package:hpaan_viewpoint/pages/widgets/scale_tapper.dart';

class CardDetail extends StatefulWidget {
  const CardDetail({
    super.key,
    required this.singlePlace,
    required this.marker,
  });

  final dynamic singlePlace;
  final List<Marker> marker;

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: CustomText(
      //     text: "${widget.singlePlace['name']}",
      //     fontFamily: "Lato",
      //     fontSize: 13,
      //     fontWeight: FontWeight.w400,
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  child: Image.asset(
                    "${widget.singlePlace['imageUrl']}",
                    fit: BoxFit.cover,
                  ),
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
            const SizedBox(
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomText(
                text: "${widget.singlePlace['name']}",
                fontFamily: "Pyidaungsu",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          color: Colors.teal,
                          size: 18,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: CustomText(
                            text: "${widget.singlePlace['location']}",
                            fontFamily: "SF-Pro",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ScaleTapper(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TrackingLocationPage(
                            // currentLocation: _currentPosition,
                            // routePoints: _routePoints,
                            lat: double.tryParse(
                                    "${widget.singlePlace['lat']}") ??
                                0.2,
                            long: double.tryParse(
                                    "${widget.singlePlace['long']}") ??
                                0.2,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(218, 237, 237, 237),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            CustomText(
                              text: "Bring me there",
                              fontFamily: "SF-Pro",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.teal,
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              CupertinoIcons.location_fill,
                              color: Colors.teal,
                              size: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: CustomText(
                text: "About this point of interest",
                fontFamily: "SF-Pro",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomText(
                text: "${widget.singlePlace['description']}",
                fontFamily: 'Pyidaungsu',
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
