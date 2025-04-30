import 'package:get/get.dart';

import 'product_controller.dart';


class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProductController>(ProductController());
  }
}
