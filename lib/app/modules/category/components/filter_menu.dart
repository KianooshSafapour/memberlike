import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberlike/app/modules/language/lang_controller.dart';
import 'package:memberlike/shared/widgets/custom_bottomsheet.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'package:memberlike/app_controller.dart';

import '../../../../shared/constants/colors.dart';
import '../../../../shared/constants/common.dart';
import '../../../../shared/constants/image_constant.dart';
import '../../../../shared/widgets/button.dart';
import '../../../../shared/widgets/custom_image_view.dart';
import '../../../../shared/widgets/custom_radio_button.dart';
import '../../../../shared/widgets/service_title_widget.dart';
import '../category_controller.dart';

class FilterMenu extends StatelessWidget {
  const FilterMenu({super.key, required this.controller});

  final CategoryController controller;

  @override
  Widget build(BuildContext context) {
    return CustomImageView(
      color:
          Get.find<AppController>().isDarkModeOn.value
              ? ColorConstants.white
              : null,
      onTap: () {
        CustomBottomSheet2.show(
          context,
          Padding(
            padding: const EdgeInsets.all(CommonConstants.mediumPadding),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CustomImageView(
                            color:
                                Get.find<AppController>().isDarkModeOn.value
                                    ? ColorConstants.white
                                    : null,
                            height: 30,
                            width: 30,
                            svgPath: ImageConstant.iconFilter,
                          ),
                          ServiceTitle(title: "filter".tr),
                        ],
                      ),
                      CustomImageView(
                        onTap: () => Get.back(),
                        height: 30,
                        width: 30,
                        svgPath: ImageConstant.iconClose,
                        color:
                            Get.find<AppController>().isDarkModeOn.value
                                ? ColorConstants.white
                                : null,
                      ),
                    ],
                  ),
                  const SizedBox(height: CommonConstants.defaultPadding),
                  ServiceTitle(title: "sortBy".tr),
                  const SizedBox(height: CommonConstants.mediumPadding),
                  Obx(() {
                    return SingleChildScrollView(
                      child: Row(
                        children: [
                          SizedBox(
                            width: Get.width * 0.43,
                            child: CustomRadioButton(
                              fontSize: 16,
                              padding: 0,
                              fontWeight: FontWeight.normal,
                              value: 'Cheap',
                              groupValue: controller.selectedValue.value,
                              onChanged: (value) {
                                controller.prevSelectedValue.value =
                                    controller.selectedValue.value;
                                controller.selectedValue.value = value!;
                              },
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.43,
                            child: CustomRadioButton(
                              padding: 0,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              value: 'Garanteed',
                              groupValue: controller.selectedValue.value,
                              onChanged: (value) {
                                controller.prevSelectedValue.value =
                                    controller.selectedValue.value;
                                controller.selectedValue.value = value!;
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: CommonConstants.defaultPadding),
                  Obx(() {
                    return SingleChildScrollView(
                      child: Row(
                        children: [
                          SizedBox(
                            width: Get.width * 0.43,
                            child: CustomRadioButton(
                              padding: 0,
                              fontWeight: FontWeight.normal,
                              value: 'Hot',
                              fontSize: 16,
                              groupValue: controller.selectedValue.value,
                              onChanged: (value) {
                                controller.prevSelectedValue.value =
                                    controller.selectedValue.value;
                                controller.selectedValue.value = value!;
                              },
                            ),
                          ),
                          SizedBox(
                            child: CustomRadioButton(
                              padding: 0,
                              fontWeight: FontWeight.normal,
                              value: 'Top Sold',
                              fontSize: 16,
                              groupValue: controller.selectedValue.value,
                              onChanged: (value) {
                                controller.prevSelectedValue.value =
                                    controller.selectedValue.value;
                                controller.selectedValue.value = value!;
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: CommonConstants.defaultPadding),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: CommonConstants.mediumPadding,
                    ),
                    width: Get.width,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: ColorConstants.kSecondColor9),
                    ),
                    child: Obx(() {
                      return Center(
                        child: DropdownButton<String>(
                          dropdownColor:
                              Get.find<AppController>().isDarkModeOn.value
                                  ? ColorConstants.grey800
                                  : ColorConstants.white,
                          isExpanded: true,
                          isDense: true,
                          borderRadius: BorderRadius.circular(7),
                          elevation: 16,
                          icon: Transform.rotate(
                            angle: pi * 1.5,
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 20,
                              color: ColorConstants.kSecondColor7,
                            ),
                          ),
                          underline: Container(
                            height: 0,
                            color: Colors.transparent,
                          ),
                          menuWidth: Get.width,
                          hint: const Text('Select an option'),
                          value: controller.dropDownSelected.value,
                          items:
                              <String>[
                                '',
                                'Telegram',
                                'Instagram',
                                'Tiktok',
                                'Facebook',
                                'Snapchat',
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: CommonConstants.kSecondaryTextStyle
                                        .copyWith(
                                          color:
                                              Get.find<AppController>()
                                                      .isDarkModeOn
                                                      .value
                                                  ? ColorConstants.white
                                                  : ColorConstants
                                                      .kPrimaryColor,
                                        ),
                                  ),
                                );
                              }).toList(),
                          onChanged: (String? newValue) {
                            controller.prevDropDownSelected.value =
                                controller.dropDownSelected.value;
                            controller.dropDownSelected.value = newValue!;
                          },
                        ),
                      );
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.9),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Obx(
                          () => SfSliderTheme(
                            data: const SfSliderThemeData(
                              activeTrackColor: ColorConstants.kPrimaryColor5,
                              inactiveTrackColor: ColorConstants.kSecondColor9,
                              thumbColor: ColorConstants.kPrimaryColor5,
                              inactiveTrackHeight: 0.1,
                              thumbStrokeWidth: 2.0,
                            ),
                            child: SfRangeSlider(
                              min: 0.0,
                              max: 200000.0,
                              activeColor: ColorConstants.kPrimaryColor5,
                              values: controller.rangeValues.value,
                              inactiveColor:
                                  Get.find<AppController>().isDarkModeOn.value
                                      ? ColorConstants.white
                                      : null,
                              interval: 200000,
                              showTicks: false,
                              showLabels: true,
                              enableTooltip: false,
                              onChanged: (newValues) {
                                controller.updateRange(newValues);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Obx(() {
                          return Row(
                            children: [
                              Text("from".tr),
                              const SizedBox(width: 10),
                              Container(
                                width: 90,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: ColorConstants.kSecondColor9,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    //round to 2 digits
                                    '${controller.rangeValues.value.start.round()}',

                                    style: CommonConstants.kSecondaryTextStyle
                                        .copyWith(
                                          color:
                                              Get.find<AppController>()
                                                      .isDarkModeOn
                                                      .value
                                                  ? ColorConstants.white
                                                  : ColorConstants
                                                      .kPrimaryColor,
                                        ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 40),
                              Text("to".tr),
                              const SizedBox(width: 10),
                              Container(
                                width: 90,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: ColorConstants.kSecondColor9,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    //round to 2 digits
                                    '${controller.rangeValues.value.end.round()}',
                                    style: CommonConstants.kSecondaryTextStyle
                                        .copyWith(
                                          color:
                                              Get.find<AppController>()
                                                      .isDarkModeOn
                                                      .value
                                                  ? ColorConstants.white
                                                  : ColorConstants
                                                      .kPrimaryColor,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                        SizedBox(height: Get.height * 0.1),
                        CommonWidgets.primaryButton(
                          text: "done".tr,
                          onPressed: () {
                            controller.filterServices();
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      svgPath: ImageConstant.iconFilter,
      margin:
          Get.find<LangController>().isRtl()
              ? const EdgeInsets.only(left: CommonConstants.defaultPadding * 2)
              : const EdgeInsets.only(
                right: CommonConstants.defaultPadding * 2,
              ),
    );
  }
}
