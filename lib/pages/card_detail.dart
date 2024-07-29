import 'package:flutter/material.dart';
import 'package:hpaan_viewpoint/components/custom_text.dart';
import 'package:hpaan_viewpoint/model/categories_list_model.dart';
import 'package:hpaan_viewpoint/pages/widgets/scale_tapper.dart';

class CardDetail extends StatefulWidget {
  const CardDetail({
    super.key,
    required this.singlePlace,
  });

  final Place? singlePlace;

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
      // body: Stack(
      //   children: [
      //     SizedBox(
      //       width: double.infinity,
      //       height: 300,
      //       child: Image.asset(
      //         "${widget.singlePlace?.imageUrl}",
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      //     Positioned(
      //       top: 0,
      //       left: 0,
      //       right: 0,
      //       child: Container(
      //         height: 120,
      //         padding: const EdgeInsets.symmetric(
      //           horizontal: 12,
      //         ),
      //         child: Padding(
      //           padding: const EdgeInsets.only(top: 30),
      //           child: Row(
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               ScaleTapper(
      //                 onTap: () => Navigator.pop(context),
      //                 child: Container(
      //                   width: 40,
      //                   height: 40,
      //                   decoration: BoxDecoration(
      //                     color: Colors.black38,
      //                     borderRadius: BorderRadius.circular(5),
      //                   ),
      //                   child: const Center(
      //                     child: Icon(
      //                       Icons.arrow_back_rounded,
      //                       size: 22,
      //                       color: Colors.white,
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               Container(
      //                 width: 40,
      //                 height: 40,
      //                 decoration: BoxDecoration(
      //                   color: Colors.black38,
      //                   borderRadius: BorderRadius.circular(5),
      //                 ),
      //                 child: const Center(
      //                   child: Icon(
      //                     Icons.share_location,
      //                     size: 22,
      //                     color: Colors.white,
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            scrolledUnderElevation: 0.0,
            leadingWidth: 70,
            leading: ScaleTapper(
              onTap: () => Navigator.pop(context),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(4),
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "${widget.singlePlace?.imageUrl}",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              CustomText(
                text: "${widget.singlePlace?.name}",
                fontFamily: "Lato",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_rounded,
                    color: Colors.teal,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  CustomText(
                    text: "${widget.singlePlace?.location}",
                    fontFamily: "Lato",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              CustomText(
                text: "${widget.singlePlace?.description}",
                fontFamily: "Lato",
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
