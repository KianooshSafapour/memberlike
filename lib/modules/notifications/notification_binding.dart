import 'package:get/get.dart';
import 'package:memberlike/modules/notifications/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    // Using BindingsBuilder to register LangController
    BindingsBuilder(() {
      Get.put<NotificationController>(
          permanent: true, NotificationController(apiRepository: Get.find()));
    }).dependencies();
  }
}
 