import 'package:get/get.dart';
import 'package:memberlike/modules/order_detail/order_detail.dart';

import 'wallet_controller.dart';

class WalletBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderDetailController(apiRepository: Get.find()));
    Get.lazyPut(() => WalletController(apiRepository: Get.find()));
  }
}
