import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:memberlike/api/api.dart';

class AboutusController extends GetxController {
  ApiRepository apiRepository = Get.find();
  AboutusController({required this.apiRepository});
  var companyName = "memeber like".obs;
  RxString description = "".obs;
  RxString terms = "".obs;

  @override
  void onInit() async {
    super.onInit();
    await getGeneralInfo();
  }

  Future<void> getGeneralInfo() async {
    var res = await apiRepository.getGeneralOptions();
    if (res != null) {
      description.value = res.data[2]["value"];
      terms.value = res.data[67]["value"];
      debugPrint("object");
    } else {
      EasyLoading.dismiss();
      Get.snackbar("error".tr, "noInternetError".tr);
    }
  }
}
