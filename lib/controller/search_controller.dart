import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/categories_list_model.dart';
import '../model/categories_model.dart';

class SearchPlaceController extends GetxController {
  var categories = <Category>[].obs;
  var searchResults = <dynamic>[].obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      var categorySnapshot = await firestore.collection('categories').get();

      for (var doc in categorySnapshot.docs) {
        var placesSnapshot = await firestore
            .collection('categories')
            .doc(doc.id)
            .collection('place')
            .get();

        List<Place> places = placesSnapshot.docs
            .map((placeDoc) => Place.fromDocumentSnapshot(placeDoc))
            .toList();

        categories.add(Category.fromDocumentSnapshot(doc, places));
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  void searchPlaces(String query) {
    // Clear search results if query is null or empty
    if (query == null || query.isEmpty) {
      searchResults.clear();
    } else {
      var results = <dynamic>[];

      for (var category in categories) {
        print("Query in Category =========> ${category}");

        // Check if category.place is not null
        if (category.place != null) {
          results.addAll(
            category.place.where(
              (place) =>
                  place['name'].toLowerCase().contains(query.toLowerCase()),
            ),
          );
        }
      }

      // Logging before and after updating searchResults
      print("Results found =========> ${results}");
      print("SearchResults before update =========> ${searchResults}");

      // Update searchResults reactively
      searchResults.value = results;

      print("SearchResults after update =========> ${searchResults}");
    }
  }
}