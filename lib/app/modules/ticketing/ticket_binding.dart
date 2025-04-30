import 'package:get/get.dart';
import 'package:memberlike/app/modules/ticketing/ticket_controller.dart';

class TicketBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<TicketController>(TicketController(apiRepository: Get.find()));
  }
}
