import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hpaan_viewpoint/model/categories_model.dart';
import 'package:hpaan_viewpoint/model/data.dart';

Future<List<MarkerData>> fetchMarkers() async {
  final String response =
      await rootBundle.loadString('assets/popular_data.json');
  final List<dynamic> data = jsonDecode(response);

  return MarkerData.fromJsonList(data);
}

// Future<List<Category>> fetchCategoryList() async {
//   final String response = await rootBundle.loadString("assets/category.json");
//   final List<dynamic> data = jsonDecode(response);

//   return Category.fromJson(data);
// }

Future<List<Category>> fetchCategories() async {
  final String response = await rootBundle.loadString('assets/category.json');
  final parsed =
      jsonDecode(response)['categories'].cast<Map<String, dynamic>>();
  return parsed.map<Category>((json) => Category.fromJson(json)).toList();
}

Stream<Position> getPositionStream() {
  return Geolocator.getPositionStream(
    locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // Update location every 10 meters
    ),
  );
}
