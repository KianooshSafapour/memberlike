import 'package:get/get.dart';
import 'package:memberlike/modules/about/about_controller.dart';

class AboutusBinding extends Bindings {
  AboutusBinding() {
    dependencies();
  }
  @override
  void dependencies() {
    BindingsBuilder(
      () => Get.lazyPut<AboutusController>(
        () => AboutusController(apiRepository: Get.find()),
      ),
    ).dependencies();
  }
}
