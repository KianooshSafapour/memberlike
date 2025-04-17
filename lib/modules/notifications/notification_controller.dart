import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memberlike/api/api.dart';
import 'package:memberlike/models/response/notificaiton_response.dart';

class NotificationController extends GetxController {
  ApiRepository apiRepository;

  @override
  void onInit() {
    super.onInit();
    notifications.isEmpty ? getNotifications() : null;
  }

  final box = GetStorage();
  NotificationController({required this.apiRepository});
  RxList<NotificationResponse> notifications = <NotificationResponse>[].obs;

  Future<void> getNotifications() async {
    var res = await apiRepository.getNotification();
    if (res != null) {
      res.data.forEach((element) {
        notifications.add(NotificationResponse.fromJson(element));
      });
    }
  }
}
