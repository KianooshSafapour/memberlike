import 'package:get/get.dart';
import 'package:memberlike/app/modules/language/lang_controller.dart';
import 'package:memberlike/app/modules/profile/profile.dart';
import 'package:memberlike/app/modules/ticketing/ticket_controller.dart';

import '../wallet/wallet_controller.dart';
import 'home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LangController>(
      () => LangController(apiRepository: Get.find()),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(apiRepository: Get.find()),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(apiRepository: Get.find()),
    );
    Get.lazyPut(() => WalletController(apiRepository: Get.find()));
    Get.lazyPut(() => TicketController(apiRepository: Get.find()));
  }
}
