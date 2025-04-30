import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberlike/core/routes/app_pages.dart';
import 'package:memberlike/shared/widgets/directinality_handler_widgets/custom_directionality.dart';

import '../../../app_controller.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/common.dart';
import '../../../shared/constants/image_constant.dart';
import '../../../shared/widgets/button.dart';
import '../../../shared/widgets/custom_radio_button.dart';
import 'lang_controller.dart';

class LanguageScreen extends GetView<LangController> {
  LanguageScreen({super.key});

  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            Get.find<AppController>().isDarkModeOn.value
                ? ColorConstants.darkScaffoldBackgroundColor
                : ColorConstants.white,
        resizeToAvoidBottomInset: false,
        body: Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.18),
              customAlign(
                child: Padding(
                  padding:
                      Get.find<LangController>().isRtl()
                          ? const EdgeInsets.only(
                            right: CommonConstants.defaultPadding,
                          )
                          : const EdgeInsets.only(
                            left: CommonConstants.defaultPadding,
                          ),
                  child: Text(
                    CommonConstants.chooseYourDesiredLanguage.tr,
                    style: CommonConstants.kTitleTextStyle.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              CustomRadioButton(
                hasCustomColor: true,
                imagePath: ImageConstant.iconEnglish,
                value: 'english'.tr,
                groupValue: controller.selectedValue.value,
                onChanged: (value) {
                  controller.selectedValue.value = value!;
                },
              ),
              CustomRadioButton(
                hasCustomColor: true,
                imagePath: ImageConstant.iconPersian,
                value: 'persian'.tr,
                groupValue: controller.selectedValue.value,
                onChanged: (value) {
                  controller.selectedValue.value = value!;
                },
              ),
              // CustomRadioButton(
              //   hasCustomColor: true,
              //   imagePath: ImageConstant.iconArabic,
              //   value: 'arabic'.tr,
              //   groupValue: controller.selectedValue.value,
              //   onChanged: (value) {
              //     controller.selectedValue.value = value!;
              //   },
              // ),
              const Spacer(),
              Container(
                margin: EdgeInsets.only(bottom: Get.height * 0.1),
                padding: const EdgeInsets.symmetric(
                  horizontal: CommonConstants.defaultPadding,
                ),
                child: CommonWidgets.primaryButton(
                  text: CommonConstants.confirm.tr,
                  onPressed: () {
                    if (controller.selectedValue.value == 'english'.tr) {
                      controller.handleLanguageSelection(controller.langs[0]);
                    } else if (controller.selectedValue.value == "persian".tr) {
                      controller.handleLanguageSelection(controller.langs[1]);
                    } else if (controller.selectedValue.value == "arabic".tr) {
                      controller.handleLanguageSelection(controller.langs[2]);
                    }

                    Get.toNamed(Routes.LOG_IN);
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
