import 'package:get/get.dart';

import 'shared/services/services.dart';
import 'shared/utils/app_flavor_helper.dart';

class DenpendencyInjection {
  static Future<void> init() async =>
      await Get.putAsync(() => StorageService().init());

  static Future<void> inject(AppFlavor appFlavor) async =>
      Get.put<AppFlavor>(appFlavor);
}
