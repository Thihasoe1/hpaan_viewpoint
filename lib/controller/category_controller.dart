import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hpaan_viewpoint/model/categories_model.dart';

class CategoryController extends GetxController {
  var isLoading = false;

  var categoryList = <Category>[];
  var popularPlaces = <dynamic>[].obs;

  Future<void> getCategoryList() async {
    try {
      isLoading = true;
      update();
      QuerySnapshot categories = await FirebaseFirestore.instance
          .collection("categories")
          .orderBy("id")
          .get();
      categoryList.clear();
      for (var category in categories.docs) {
        categoryList.add(
          Category(
            id: category["id"],
            name: category["name"],
            count: category["count"],
            icon: category["icon"],
            place: category["place"],
          ),
        );
      }
      var popularPlacesList = categoryList
          .expand((category) => category.place)
          .where((pp) => (double.tryParse(pp['rating']) ?? 0.0) >= 4.5)
          .toList();

      popularPlaces.value = popularPlacesList;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }
}
