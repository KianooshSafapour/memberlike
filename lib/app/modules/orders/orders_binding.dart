import 'package:get/get.dart';
import 'package:memberlike/app/modules/orders/orders_controller.dart';

class OrdersBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrdersController>(
      () => OrdersController(apiRepository: Get.find()),
    );
  }
}
