import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memberlike/api/api_repository.dart';
import 'package:memberlike/models/response/orders_response.dart';
import 'package:memberlike/shared/widgets/custom_snackbar_widget.dart';

class OrdersController extends GetxController {
  OrdersController({required this.apiRepository});
  final ApiRepository apiRepository;
  final box = GetStorage();
  RxList<OrdersResponse> orders = <OrdersResponse>[].obs;

  Future<void> getOrders() async {
    final userId = box.read("userId");

    try {
      final res = await apiRepository.getOrders(userId);
      if (res != null) {
        orders.clear();
        for (var i = 0; i < res.data.length; i++) {
          orders.add(OrdersResponse.fromJson(res.data[i]));
        }
      } else {
        showDarkSnackbar("error".tr, "noInternetError".tr);
      }
    } catch (e) {}
  }

  @override
  void onInit() {
    getOrders();
    super.onInit();
  }
}
