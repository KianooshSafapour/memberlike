import 'package:get/get.dart';

import 'profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    BindingsBuilder(
      () => Get.put<ProfileController>(
        permanent: true,
        ProfileController(
          apiRepository: Get.find(),
        ),
      ),
    ).dependencies();
  }
}
