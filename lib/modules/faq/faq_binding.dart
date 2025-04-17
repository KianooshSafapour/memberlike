import 'package:get/get.dart';
import 'faq_controller.dart';

class FaqBinding extends Bindings {
  @override
  void dependencies() {
    BindingsBuilder(
      () => Get.put<FaqController>(
        permanent: true,
        FaqController(apiRepository: Get.find()),
      ),
    ).dependencies();
  }
}
