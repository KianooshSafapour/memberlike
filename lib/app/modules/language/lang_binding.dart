import 'package:get/get.dart';

import 'lang_controller.dart';

class LangBinding implements Bindings {
  LangBinding() {
    dependencies();
  }
  @override
  void dependencies() {
    Get.lazyPut<LangController>(
      fenix: true,
      () => LangController(
        apiRepository: Get.find(),
      ),
    );
  }
}
