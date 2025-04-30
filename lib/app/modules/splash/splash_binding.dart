import 'package:get/get.dart';
import 'splash_controller.dart';

class SplashBinding extends Bindings {
  SplashBinding() {
    dependencies();
  }
  @override
  void dependencies() {
    Get.put<SplashController>(
      SplashController(apiRepository: Get.find()),
    );
  }
}
