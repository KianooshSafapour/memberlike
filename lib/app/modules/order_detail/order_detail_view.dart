// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberlike/app/modules/category/category.dart';
import 'package:memberlike/app/modules/category/category_view.dart';
import 'package:memberlike/app/modules/language/lang_controller.dart';
import 'package:memberlike/shared/constants/common.dart';
import 'package:memberlike/shared/utils/price_util.dart';
import 'package:memberlike/shared/widgets/service_title_widget.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../../app_controller.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/widgets/app_check_box.dart';
import '../../../shared/widgets/button.dart';
import '../../../shared/widgets/custom_icon_button.dart';
import '../../../shared/widgets/directinality_handler_widgets/custom_directionality.dart';
import '../../../shared/widgets/input_field.dart';
import 'order_detail_controller.dart';

class OrderDetail extends GetView<OrderDetailController> {
  OrderDetail({super.key}) {
    controller.quantity.value =
        Get.find<CategoryController>().selectedService.value!.min.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor:
          Get.find<AppController>().isDarkModeOn.value
              ? ColorConstants.darkScaffoldBackgroundColor
              : ColorConstants.white,
      appBar: AppBar(
        backgroundColor:
            Get.find<AppController>().isDarkModeOn.value
                ? ColorConstants.darkScaffoldBackgroundColor
                : ColorConstants.white,
        toolbarHeight: 50,
        title: Text(
          "orderDetail".tr,
          style: CommonConstants.kSecondaryTextStyle.copyWith(
            color:
                Get.find<AppController>().isDarkModeOn.value
                    ? ColorConstants.white
                    : ColorConstants.kPrimaryColor,
          ),
        ),
        centerTitle: true,
        leading: CustomIconButton(
          height: 35,
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: ColorConstants.kSecondColor5,
            size: 20,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size(Get.width, 2),
          child: Container(height: 1, color: ColorConstants.kSecondColor10),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: Padding(
            padding: const EdgeInsets.all(CommonConstants.defaultPadding),
            child: Column(
              children: [
                Container(
                  width: Get.width,
                  constraints: const BoxConstraints(minHeight: 200),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: ColorConstants.kSecondColor9,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(
                      CommonConstants.defaultPadding,
                    ),
                    child: Column(
                      children: [
                        RateOrderWidget(
                          service:
                              Get.find<CategoryController>()
                                  .selectedService
                                  .value!,
                        ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        SizedBox(
                          height: Get.height * 0.1,
                          child:
                              Get.find<CategoryController>()
                                          .selectedService
                                          .value!
                                          .atrebiutes !=
                                      null
                                  ? ListView.builder(
                                    itemCount:
                                        Get.find<CategoryController>()
                                            .selectedService
                                            .value!
                                            .atrebiutes!
                                            .length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          const SizedBox(height: 10),
                                          AppCheckbox(
                                            isChangable: false,
                                            checked: true,
                                            label:
                                                Get.find<CategoryController>()
                                                    .selectedService
                                                    .value!
                                                    .atrebiutes![index],
                                            onChecked: (value) {
                                              value = true;
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                  : Container(),
                        ),

                        const SizedBox(height: CommonConstants.mediumPadding),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ServiceTitle(
                  title: 'enterInformation'.tr,
                  horizontalPadding: 0,
                ),
                const SizedBox(height: CommonConstants.defaultPadding),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: CommonConstants.mediumPadding,
                  ),
                  width: Get.width,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Get.find<CategoryController>()
                                    .selectedService
                                    .value!
                                    .min !=
                                Get.find<CategoryController>()
                                    .selectedService
                                    .value!
                                    .max
                            ? Obx(
                              () => SfSliderTheme(
                                data: const SfSliderThemeData(
                                  activeTrackColor:
                                      ColorConstants.kPrimaryColor5,
                                  inactiveTrackColor:
                                      ColorConstants.kSecondColor9,
                                  thumbColor: ColorConstants.kPrimaryColor5,
                                  inactiveTrackHeight: 0.1,
                                  thumbStrokeWidth: 2.0,
                                ),
                                child: SfSlider(
                                  min:
                                      Get.find<CategoryController>()
                                          .selectedService
                                          .value!
                                          .min,
                                  max:
                                      Get.find<CategoryController>()
                                          .selectedService
                                          .value!
                                          .max,
                                  activeColor: ColorConstants.kPrimaryColor5,
                                  value: controller.quantity.value,
                                  inactiveColor:
                                      Get.find<AppController>()
                                              .isDarkModeOn
                                              .value
                                          ? ColorConstants.white
                                          : null,
                                  showTicks: false,
                                  showLabels: true,
                                  enableTooltip: false,
                                  onChanged: (newValues) {
                                    controller.quantity(newValues);
                                  },
                                ),
                              ),
                            )
                            : Container(),
                        const SizedBox(height: 10),
                        Obx(() {
                          return Row(
                            children: [
                              Text(
                                "quantity".tr,
                                style: CommonConstants.kSecondaryTextStyle
                                    .copyWith(fontSize: 14),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                width: Get.width * 0.15,
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
                                    '${controller.quantity.round()}',

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
                              const Spacer(),
                              Text(
                                "price".tr,
                                style: CommonConstants.kSecondaryTextStyle
                                    .copyWith(fontSize: 14),
                              ),
                              Text(
                                Get.find<LangController>().currentLang() == "fa"
                                    ? "(ریال)"
                                    : "",
                                style: CommonConstants.kSecondaryTextStyle
                                    .copyWith(fontSize: 9),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                width: Get.width * 0.4,
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
                                    Get.find<LangController>().currentLang() ==
                                            "fa"
                                        ? formatIranRial(
                                          controller.quantity.round() *
                                              Get.find<CategoryController>()
                                                  .selectedService
                                                  .value!
                                                  .final_price_irr /
                                              1000,
                                        )
                                        : (Get.find<CategoryController>()
                                                    .selectedService
                                                    .value!
                                                    .final_price_usd /
                                                1000 *
                                                controller.quantity.round())
                                            .toStringAsFixed(2),

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
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 4),
                  child: customAlign(
                    child: Text(
                      "Link".tr,
                      style: CommonConstants.kSecondaryTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                InputField(
                  keyboardType: TextInputType.text,
                  isBorder: true,
                  hintText: "link".tr,
                  onChanged: (p0) => controller.link(p0),
                ),
                SizedBox(height: Get.height * 0.2),
                CommonWidgets.primaryButton(
                  text: "confirm".tr,
                  onPressed: () {
                    controller.createOrder(
                      Get.find<CategoryController>().selectedService.value!,
                    );
                  },
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
