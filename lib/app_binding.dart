import 'package:get/get.dart';
import 'package:memberlike/app_controller.dart';
import 'package:memberlike/shared/utils/app_flavor_helper.dart';

import 'api/api_provider.dart';
import 'api/api_repository.dart';

class AppBinding implements Bindings {
  AppBinding(this.flavor) {
    dependencies();
  }

  final AppFlavor flavor;

  @override
  Future<void> dependencies() async {
    Get.put(ApiProvider(Get.find()), permanent: true);
    Get.put(ApiRepository(), permanent: true);
    Get.lazyPut(() => AppController(flavor), fenix: true);
  }
}
