import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:memberlike/app/api/api.dart';
import 'package:memberlike/app/models/response/faq_response.dart';
import 'package:memberlike/shared/widgets/custom_snackbar_widget.dart';

class FaqController extends GetxController {
  final ApiRepository apiRepository;

  List<FaqResponse> faqItems = <FaqResponse>[].obs; // List of FAQs

  FaqController({required this.apiRepository});
  // List of FAQs

  @override
  void onInit() async {
    super.onInit();
    await getFaq();
  }

  Future<void> getFaq() async {
    final res = await apiRepository.getFaq();
    if (res != null) {
      faqItems.clear();
      res.data.forEach((element) {
        faqItems.add(FaqResponse.fromJson(element));
      });
    } else {
      EasyLoading.dismiss();
      showDarkSnackbar("error".tr, "noInternetError".tr);
    }
  }
}
