import 'package:get/get.dart';
import 'category_controller.dart';

class CategoryBinding extends Bindings {
  CategoryBinding() {
    dependencies();
  }
  @override
  void dependencies() {
    Get.put<CategoryController>(CategoryController(
      apiRepository: Get.find(),
    ));
  }
}
