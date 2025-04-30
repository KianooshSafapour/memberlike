import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:myket_iap/myket_iap.dart';
import 'package:myket_iap/util/iab_result.dart';
import 'package:myket_iap/util/purchase.dart';

import '../../app/api/api.dart';
import '../../app/modules/wallet/wallet.dart';
import '../widgets/custom_snackbar_widget.dart';

class MayketController extends GetxController {
  MayketController({required this.apiRepository});
  final logger = Logger();
  IabResult? iabResult;
  final box = GetStorage();
  final ApiRepository apiRepository;

  @override
  void onInit() async {
    iabResult = await MyketIAP.init(
      rsaKey:
          "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCabLVv/LX/JO3n2CDSwc0EA9cLPCstZRkw8imTUiq1hsiOke2MlRTAD7NR+C6bKu0KCa7eMRul/rRYPrmg0oROdIcWvilD2Y2rYU4VMrV/VnKzYwwUpu4zSP8RqE9IaF8wQ16DHDizkhihG8zNmtQWN5YUM55w6IKaPq+NV0w2LwIDAQAB",
      enableDebugLogging: true,
    );
    logger.d(iabResult.toString());
    super.onInit();
  }

  Future buyProduct(dynamic productId) async {
    Map<dynamic, dynamic> result = await MyketIAP.launchPurchaseFlow(
      sku: productId.toString(),
      payload: "payload",
    );
    IabResult purchaseResult = result[MyketIAP.RESULT];
    if (purchaseResult.isSuccess()) {
      Purchase purchase = result[MyketIAP.PURCHASE];
      Map<dynamic, dynamic> pResult = await MyketIAP.consume(
        purchase: purchase,
      );
      IabResult consumePurchaseResult = pResult[MyketIAP.RESULT];
      Purchase consumepurchase = pResult[MyketIAP.PURCHASE];
      var body = {
        "SKU_ID": purchase.mSku,
        "TOKEN": purchase.mToken,
        'user_id': await box.read("userId"),
      };
      var res = await apiRepository.confirmPayment(body);
      if (res != null) {
        if (res["code"].toString() == "200") {
          await Get.find<WalletController>().getBalance(force: true);
          showDarkSnackbar("success".tr, res["message"]);
        } else {
          showDarkSnackbar("error".tr, res["message"]);
        }
      }
      logger.d("purchase: $consumepurchase, result: $consumePurchaseResult");
    } else {
      showDarkSnackbar("error".tr, purchaseResult.mMessage);
    }
  }
}
