import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memberlike/api/api.dart';
import 'package:memberlike/models/request/order_request.dart';
import 'package:memberlike/models/response/service_response.dart';
import 'package:memberlike/routes/app_pages.dart';
import 'package:memberlike/shared/constants/image_constant.dart';
import 'package:memberlike/shared/widgets/custom_snackbar_widget.dart';

enum PaymentMethod {
  inapp,
  paypal,
  test,
}

class OrderDetailController extends GetxController {
  OrderDetailController({required this.apiRepository});
  ApiRepository apiRepository;
  var dropDownSelected = 'Choose'.obs;
  final box = GetStorage();

  RxDouble quantity = 1.0.obs;
  RxString link = ''.obs;
  Rxn<PaymentMethod> paymentMethod = Rxn<PaymentMethod>();
  List<String> paymentImages = [
    ImageConstant.iconBottomWalletBold,
    ImageConstant.iconApple,
    ImageConstant.iconGoogle
  ];

  Future createOrder(ServiceResponse service) async {
    final userid = await box.read("userId");
    final OrderRequest order = OrderRequest(
        ids: service.ids,
        uid: userid.toString(),
        status: "pending",
        charge: quantity.value,
        type: "service",
        cateId: service.cate_id.toString(),
        serviceId: service.id.toString(),
        mainOrderId: 1,
        serviceType: "premium",
        apiProviderId: int.parse(service.apiServiceId),
        apiServiceId: service.apiProviderId.toString(),
        apiOrderId: 1,
        link: link.value,
        quantity: quantity.value.toString(),
        usernames: "user1,user2,user3",
        hashtag: "#example",
        media: "https://example.com/media.jpg",
        comments: "No comments",
        subPosts: 5,
        subMin: 1,
        subMax: 10,
        subDelay: 2,
        subExpiry: 99999,
        note: service.name,
        changed: DateTime.now(),
        created: DateTime.now());
    var res = await apiRepository.createOrder(order.toJson());
    if (res != null) {
      showDarkSnackbar("success".tr, "order created successfuly");
      Get.toNamed(Routes.ORDERS);
      //if success go to wallet page to show the order
    } else {
      // showDarkSnackbar("error".tr, "noInternet");
    }
  }
}
