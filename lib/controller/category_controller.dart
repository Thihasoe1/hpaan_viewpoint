import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hpaan_viewpoint/model/categories_model.dart';

class CategoryController extends GetxController {
  bool isLoading = false;

  var categoryList = <Category>[];

  Future<void> getCategoryList() async {
    try {
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
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
    isLoading = false;
    update();
  }
}
