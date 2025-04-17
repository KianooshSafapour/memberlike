import 'package:get/get.dart';

import 'order_detail_controller.dart';

class OrderDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<OrderDetailController>(
      OrderDetailController(apiRepository: Get.find()),
    );
  }
}
