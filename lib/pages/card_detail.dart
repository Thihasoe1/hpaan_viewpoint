import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:hpaan_viewpoint/components/custom_text.dart';
import 'package:hpaan_viewpoint/controller/comment_controller.dart';
import 'package:hpaan_viewpoint/pages/tracking_location_page.dart';
import 'package:hpaan_viewpoint/pages/widgets/scale_tapper.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
  TextEditingController reviewController = TextEditingController();

  CommentController commentController = Get.put(CommentController());

  @override
  void initState() {
    super.initState();
    commentController.fetchComments(widget.singlePlace['placeId']);
  }

  @override
  void dispose() {
    super.dispose();
    reviewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formatTimestamp(Timestamp timestamp) {
      DateTime dateTime = timestamp.toDate();
      return DateFormat('dd/MM/yyyy').format(dateTime);
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
      body: RefreshIndicator(
        onRefresh: () async {
          commentController.fetchComments(widget.singlePlace['placeId']);
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: double.infinity,
                    child: Image.asset(
                      "${widget.singlePlace['imageUrl']}",
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16),
                  //   child: CustomText(
                  //     text: "Photos",
                  //     fontFamily: "SF-Pro",
                  //     fontSize: 15,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 6,
                      ),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(
                            left: 0,
                            right: 10,
                            top: 15,
                            bottom: 15,
                          ),
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade200,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 3),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomText(
                      text: "${widget.singlePlace['name']}",
                      fontFamily: "SF-Pro",
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
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 20,
                    ),
                    child: ReadMoreText(
                      "${widget.singlePlace['description']}",
                      trimMode: TrimMode.Line,
                      textScaler: const TextScaler.linear(1),
                      trimLines: 8,
                      colorClickableText: Colors.blue,
                      trimCollapsedText: '  Show more',
                      trimExpandedText: '  Show less',
                      moreStyle: const TextStyle(
                        fontSize: 14,
                        fontFamily: "SF-Pro",
                        fontWeight: FontWeight.w400,
                        color: Colors.blue,
                      ),
                      lessStyle: const TextStyle(
                        fontSize: 14,
                        fontFamily: "SF-Pro",
                        fontWeight: FontWeight.w400,
                        color: Colors.blue,
                      ),
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: "Pyidaungsu",
                        fontWeight: FontWeight.w400,
                        height: 1.8,
                      ),
                    ),
                  ),
                  // const SizedBox(height: 5),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 5,
                    ),
                    child: Row(
                      children: [
                        CustomText(
                          text: "Reviews",
                          fontFamily: "SF-Pro",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(width: 10),
                        ScaleTapper(
                          onTap: () {
                            Get.defaultDialog(
                              titlePadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              title: "",
                              content: MediaQuery(
                                data: const MediaQueryData(
                                  textScaler: TextScaler.linear(1),
                                ),
                                child: TextFormField(
                                  //key: widget.formKey,
                                  maxLines: 4,
                                  controller: reviewController,
                                  cursorColor: Colors.teal,

                                  style: const TextStyle(
                                    fontFamily: "SF-Pro",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                  //validator: widget.validator,
                                  //obscureText: !_isVisible && widget.isPassword,
                                  decoration: InputDecoration(
                                    hintText: "Write your suggestions",
                                    hintStyle: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'SF-Pro',
                                      color: Colors.grey.shade400,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.8),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: const BorderSide(
                                        color: Colors.teal,
                                        width: 1.4,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: const BorderSide(
                                        width: 1.4,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 18,
                                      horizontal: 10,
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1.4,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              actions: [
                                ScaleTapper(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 44,
                                    width: MediaQuery.of(context).size.width *
                                        0.23,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Center(
                                      child: CustomText(
                                        text: "Cancel",
                                        fontFamily: "SF-Pro",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ScaleTapper(
                                  onTap: () {
                                    if (reviewController.text.isNotEmpty) {
                                      commentController.addComment(
                                        widget.singlePlace['placeId'],
                                        reviewController.text,
                                      );
                                      reviewController.clear();
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Container(
                                    height: 45,
                                    width: MediaQuery.of(context).size.width *
                                        0.23,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue,
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            text: "Send",
                                            fontFamily: "SF-Pro",
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 5),
                                          const Icon(
                                            Icons.send_rounded,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          child: Container(
                            width: 18,
                            height: 18,
                            //padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.teal,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add_rounded,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Obx(
                    () {
                      if (commentController.comments.isEmpty) {
                        return Center(
                          child: CustomText(
                            text: "No have review.",
                            fontFamily: "SF-Pro",
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade400,
                          ),
                        );
                      } else {
                        return Skeletonizer(
                          enabled: commentController.isLoading.value,
                          child: SizedBox(
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: commentController.comments.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey.shade200,
                                  ),
                                  //height: 90,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    top: 14,
                                    bottom: 18,
                                    right: 8,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.amberAccent,
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              CustomText(
                                                text: "username",
                                                fontFamily: "SF-Pro",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey,
                                              ),
                                              const SizedBox(width: 9),
                                              CustomText(
                                                text: formatTimestamp(
                                                    commentController
                                                                .comments[index]
                                                            ['timestamp']
                                                        as Timestamp),
                                                fontFamily: "SF-Pro",
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.blue.shade400,
                                              ),
                                            ],
                                          ),
                                          CustomText(
                                            text:
                                                "${commentController.comments[index]['commentText']}",
                                            fontFamily: "SF-Pro",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
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
                        Icons.arrow_back_rounded,
                        size: 18,
                      ),
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
