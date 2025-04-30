import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberlike/app/modules/language/lang_controller.dart';
import 'package:memberlike/shared/constants/image_constant.dart';
import 'package:memberlike/shared/services/bazzar_controller.dart';
import 'package:memberlike/shared/utils/date_time_utils.dart';
import 'package:memberlike/shared/utils/price_util.dart';
import 'package:memberlike/shared/widgets/button.dart';
import 'package:memberlike/shared/widgets/custom_image_view.dart';
import 'package:memberlike/shared/widgets/directinality_handler_widgets/custom_directionality.dart';
import '../../../app_controller.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/common.dart';
import '../../../shared/widgets/custom_icon_button.dart';
import '../order_detail/order_detail_controller.dart';
import 'wallet_controller.dart';

class WalletView extends GetView<WalletController> {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OrderDetailController(apiRepository: Get.find()));
    var myketController = Get.put(MayketController(apiRepository: Get.find()));

    return Obx(() {
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
          toolbarHeight: 50,
          title: Text(
            "increaseBalance".tr,
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
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color:
                  Get.find<AppController>().isDarkModeOn.value
                      ? ColorConstants.white
                      : ColorConstants.kSecondColor5,
              size: 20,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size(Get.width, 2),
            child: Container(height: 1, color: ColorConstants.kSecondColor10),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(CommonConstants.defaultPadding),
          child: Column(
            children: [
              WalletCardWidget(controller: controller),
              const SizedBox(height: CommonConstants.defaultPadding),
              customAlign(
                child: Text(
                  "enterTheBalanceIncreaseAmount".tr,
                  style: CommonConstants.kTitleTextStyle.copyWith(
                    color:
                        Get.find<AppController>().isDarkModeOn.value
                            ? ColorConstants.white
                            : ColorConstants.kPrimaryColor4,
                    fontSize: CommonConstants.mediumText,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(() {
                return Text(
                  Get.find<LangController>().currentLang() == "fa"
                      ? "${controller.selectedImcrementBalance.value.contains("wallet") ? controller.selectedImcrementBalance.value.split("wallet")[1] : controller.selectedImcrementBalance.value} تومان"
                      : "${controller.selectedImcrementBalance.value.contains("wallet") ? controller.selectedImcrementBalance.value.split("wallet")[1] : controller.selectedImcrementBalance.value}\$",
                  style: CommonConstants.kTitleTextStyle.copyWith(
                    color:
                        Get.find<AppController>().isDarkModeOn.value
                            ? ColorConstants.white
                            : ColorConstants.kPrimaryColor4,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                );
              }),
              const SizedBox(height: 20),
              Text(
                "enteredAmountRules".tr,
                style: CommonConstants.kTitleTextStyle.copyWith(
                  color:
                      Get.find<AppController>().isDarkModeOn.value
                          ? ColorConstants.white
                          : ColorConstants.kPrimaryColor4,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: CommonConstants.defaultPadding),
              CustomButtonSelector(controller: controller),
              const SizedBox(height: 30),
              CommonWidgets.primaryButton(
                text: "continue".tr,
                onPressed: () async {
                  Get.find<LangController>().currentLang() == "fa"
                      ? controller.selectedImcrementBalance.value =
                          "wallet${controller.irAmounts[controller.selectedIndex.value]}"
                      : controller.selectedImcrementBalance.value =
                          controller.amounts[controller.selectedIndex.value]
                              .toString();
                  Get.find<OrderDetailController>().paymentMethod(
                    PaymentMethod.values[0],
                  );

                  await myketController.buyProduct(
                    controller.selectedImcrementBalance.value,
                  );
                },
              ),
              const SizedBox(height: 30),
              // GestureDetector(
              //   onTap: () {},
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(
              //         horizontal: CommonConstants.defaultPadding),
              //     width: Get.width,
              //     height: 50,
              //     decoration: BoxDecoration(
              //       color: Get.find<AppController>().isDarkModeOn.value
              //           ? ColorConstants.kPrimaryColor8
              //           : ColorConstants.kPrimaryColor10,
              //       borderRadius:
              //           BorderRadius.circular(CommonConstants.mediumRadius),
              //     ),
              //     child: Center(
              //         child: Text(
              //       "doYouHaveGiftCard".tr,
              //       style: CommonConstants.kSecondaryTextStyle.copyWith(
              //           fontWeight: FontWeight.w400,
              //           fontSize: 18,
              //           color: ColorConstants.kPrimaryColor5),
              //     )),
              //   ),
              // ),
              const SizedBox(height: CommonConstants.defaultPadding),
              Obx(() {
                // Observe the transactions list
                return controller.isTransactionLoading.value
                    ? SizedBox(
                      height: Get.height * 0.15,
                      child: const Center(child: CircularProgressIndicator()),
                    )
                    : controller.transactions.isEmpty
                    ? SizedBox(
                      height: Get.height * 0.15,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "noTransactionFound".tr,
                          style: CommonConstants.kTitleTextStyle.copyWith(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    )
                    : Expanded(
                      child: ListView.builder(
                        itemCount: controller.transactions.length,
                        itemBuilder: (context, index) {
                          final transaction = controller.transactions[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Card(
                              elevation: 0,
                              color: Colors.transparent,
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  backgroundColor:
                                      ColorConstants.kPrimaryColor9,
                                  child: CustomImageView(
                                    svgPath: ImageConstant.iconBottomWallet,
                                    color: ColorConstants.kPrimaryColor5,
                                  ),
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Get.find<LangController>()
                                                  .currentLang() ==
                                              "fa"
                                          ? " ${"walletCharge".tr}"
                                          : "${"walletCharge".tr} ",
                                      style: const TextStyle(
                                        color: ColorConstants.kPrimaryColor6,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18,
                                        fontFamily: "Yekan",
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0,
                                      ),
                                      child: Text(
                                        Get.find<LangController>()
                                                    .currentLang() ==
                                                "fa"
                                            ? "${transaction['amount']}+ تومان "
                                            : "+${transaction['amount']}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          fontFamily: "Yekan",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0,
                                  ),
                                  child: Text(
                                    transaction['type']!,
                                    style: TextStyle(
                                      color:
                                          Get.find<AppController>()
                                                  .isDarkModeOn
                                                  .value
                                              ? ColorConstants.white
                                              : ColorConstants.kPrimaryColor4,
                                    ),
                                  ),
                                ),
                                trailing: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: ColorConstants.kPrimaryColor9,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    Get.find<LangController>().currentLang() ==
                                            "fa"
                                        ? DateTimeUtils.convertToJalali(
                                          transaction['created']!,
                                        )
                                        : transaction['created']!,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: ColorConstants.kPrimaryColor4,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
              }),
            ],
          ),
        ),
      );
    });
  }
}

class WalletCardWidget extends StatelessWidget {
  const WalletCardWidget({super.key, required this.controller});

  final WalletController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: CommonConstants.defaultPadding,
      ),
      width: Get.width,
      height: 50,
      decoration: BoxDecoration(
        color:
            Get.find<AppController>().isDarkModeOn.value
                ? ColorConstants.kPrimaryColor8
                : ColorConstants.kPrimaryColor10,
        borderRadius: BorderRadius.circular(CommonConstants.mediumRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "balance".tr,
                style: CommonConstants.kSecondaryTextStyle.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: ColorConstants.kPrimaryColor5,
                ),
              ),
            ],
          ),
          Obx(
            () => Text(
              Get.find<LangController>().currentLang() == "fa"
                  ? "${formatIranRial(controller.balance.value)} تومان"
                  : "${controller.balance.value}\$",
              style: CommonConstants.kSecondaryTextStyle.copyWith(
                fontSize: 23,
                color: ColorConstants.kPrimaryColor6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButtonSelector extends StatelessWidget {
  const CustomButtonSelector({super.key, required this.controller});
  final WalletController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(controller.amounts.length, (index) {
        return Obx(() {
          // Observe the selected index
          bool isSelected = controller.selectedIndex.value == index;
          return GestureDetector(
            onTap: () {
              controller.updateSelectedIndex(index);
              Get.find<LangController>().currentLang() == "fa"
                  ? controller.selectedImcrementBalance.value =
                      "wallet${controller.irAmounts[controller.selectedIndex.value]}"
                  : controller.selectedImcrementBalance.value =
                      controller.amounts[controller.selectedIndex.value]
                          .toString(); // Update the selected index
            },
            child: Container(
              width: Get.width * 0.25,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? Get.find<AppController>().isDarkModeOn.value
                            ? Colors.white
                            : Colors.transparent
                        : Get.find<AppController>().isDarkModeOn.value
                        ? Colors.transparent
                        : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15.0),
                border:
                    isSelected
                        ? Border.all(
                          color: ColorConstants.kPrimaryColor4,
                          width: 1.2,
                        )
                        : Get.find<AppController>().isDarkModeOn.value
                        ? Border.all(
                          color: ColorConstants.kSecondColor8,
                          width: 1.2,
                        )
                        : null,
              ),
              child: Center(
                child: Text(
                  Get.find<LangController>().currentLang() == 'fa'
                      ? "${controller.irAmounts[index]} تومان"
                      : "${controller.amounts[index]} \$",
                  style: TextStyle(
                    fontFamily: 'Yekan',
                    color:
                        isSelected
                            ? ColorConstants.kPrimaryColor4
                            : Colors.grey,
                    fontSize: 17,
                    fontWeight:
                        isSelected ? FontWeight.w400 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        });
      }),
    );
  }
}
