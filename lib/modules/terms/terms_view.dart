import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberlike/modules/about/about.dart';
import 'package:memberlike/shared/constants/common.dart';
import '../../app_controller.dart';
import '../../shared/constants/colors.dart';
import 'package:flutter_html/flutter_html.dart';

class OurTermsPage extends GetView<AboutusController> {
  const OurTermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Get.find<AppController>().isDarkModeOn.value
              ? ColorConstants.darkScaffoldBackgroundColor
              : ColorConstants.white,
      appBar: AppBar(
        backgroundColor:
            Get.find<AppController>().isDarkModeOn.value
                ? ColorConstants.darkScaffoldBackgroundColor
                : ColorConstants.white,
        title: Text(
          "ourTerms".tr,
          style: CommonConstants.kSecondaryTextStyle.copyWith(
            color:
                Get.find<AppController>().isDarkModeOn.value
                    ? ColorConstants.white
                    : ColorConstants.kPrimaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Obx(() => Html(data: controller.terms.value)),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
