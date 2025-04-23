import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared/utils/app_flavor_helper.dart';

class AppController extends GetxController {
  AppController(AppFlavor flavor) : currentFlavor = flavor.obs;

  RxBool isDarkModeOn = false.obs;
  RxBool isNotificationOn = true.obs;
  RxString currentRoute = ''.obs;
  final box = GetStorage();
  final Rx<AppFlavor> currentFlavor;

  @override
  void onInit() async {
    Get.lazyPut(() => SharedPreferences.getInstance(), fenix: true);
    var isDarkMode = await box.read('isDarkModeOn');
    if (isDarkMode != null) {
      isDarkModeOn.value = isDarkMode;
    }
    super.onInit();
  }

  void updateCurrentRoute() => currentRoute.value = Get.currentRoute;

  void toggleDarkMode() {
    isDarkModeOn.toggle();
    box.write('isDarkModeOn', isDarkModeOn.value);
  }

  void toggleNotificationMode() => isNotificationOn.toggle();

  String get environmentLabel {
    switch (currentFlavor.value) {
      case AppFlavor.development:
        return "UAT";
      case AppFlavor.production:
        return "";
    }
  }
}
