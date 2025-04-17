import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memberlike/api/api.dart';
import 'package:memberlike/models/response/base_response.dart';
import 'package:memberlike/modules/language/lang_controller.dart';
import 'package:memberlike/shared/widgets/custom_snackbar_widget.dart';

import '../../models/response/user_response.dart';

class WalletController extends GetxController {
  WalletController({required this.apiRepository});
  RxDouble balance = 0.0.obs;
  RxString selectedImcrementBalance = "wallet0".obs;
  var selectedIndex = 0.obs;
  RxBool isTransactionLoading = false.obs;
  final box = GetStorage();
  ApiRepository apiRepository;
  RxList transactions = [].obs;

  final List<String> amounts = ["50.000", "50.000", "50.000"]; // Button labels
  // Initialize controller

  final List<int> irAmounts = [1000, 2000, 3000];

  // Method to update the selected index
  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  Future getBalance({bool force = false}) async {
    if (balance.value == 0.0 || force) {
      int userId = box.read("userId");
      var res = await apiRepository.getUserInfo(userId.toString());
      if (res != null) {
        UserInfoResponse userInfo = UserInfoResponse.fromJson(res.data);
        balance.value =
            Get.find<LangController>().currentLang() == "fa"
                ? double.parse(userInfo.balance!) *
                    double.parse(res.pricedo!) *
                    .1
                : double.parse(userInfo.balance!);
      }
    }
  }

  confitm(body) async {
    BaseResponse? res = await apiRepository.confirmPayment(body);
    if (res != null) {
      if (res.status == "200") {
        await Get.find<WalletController>().getBalance(force: true);
        showDarkSnackbar("success".tr, res.message);
      } else {
        showDarkSnackbar("error".tr, res.message);
      }
    }
  }

  Future getTransactions() async {
    isTransactionLoading.value = true;
    int userId = box.read("userId");

    var res = await apiRepository.getTransactions(userId.toString());
    if (res != null) {
      transactions.value = res.data;
      transactions.refresh();
      isTransactionLoading.value = false;
    }
    isTransactionLoading.value = false;
  }
}
