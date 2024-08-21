import 'package:flutter/material.dart';
import 'package:hpaan_viewpoint/components/custom_text.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Favourite places",
          fontFamily: "SF-Pro",
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Center(
        child: CustomText(
          text: "Coming Soon",
          fontFamily: "SF-Pro",
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
