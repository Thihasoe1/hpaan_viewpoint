import 'package:get/get.dart';
import 'package:hpaan_viewpoint/controller/category_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CategoryController>(CategoryController());
  }
}
