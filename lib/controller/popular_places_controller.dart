import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hpaan_viewpoint/model/popular_place_data.dart';

class PopularPlacesController extends GetxController {
  final popularPlaceList = <PopularPlaceData>[];

  var isLoading = false;

  Future<void> getPopularPlaces() async {
    try {
      isLoading = true;
      update();
      QuerySnapshot popularPlace = await FirebaseFirestore.instance
          .collection("popular")
          .get();

      print("query snapshot =======> ${popularPlace}");

      popularPlaceList.clear();
      for (var popularPlaces in popularPlace.docs) {

        popularPlaceList.add(
          PopularPlaceData(
            data: popularPlaces['data'],
          ),
        );
      }
      print("popular place ======> ${popularPlaceList}");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }
}
