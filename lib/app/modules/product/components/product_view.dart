import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberlike/app/modules/category/category_controller.dart';
import 'package:memberlike/app/modules/category/category_view.dart';
import 'package:memberlike/shared/shared.dart';
import 'package:memberlike/shared/utils/price_util.dart';
import 'package:memberlike/shared/widgets/custom_bottomsheet.dart';
import '../../../../app_controller.dart';
import '../../../../core/routes/app_pages.dart';
import '../../../../shared/constants/image_constant.dart';
import '../../../../shared/widgets/button.dart';
import '../../../../shared/widgets/custom_icon_button.dart';
import '../../../../shared/widgets/custom_image_view.dart';
import '../../language/lang_controller.dart';

class ProductsScreen extends GetView<CategoryController> {
  ProductsScreen({super.key, this.catId}) {
    // Get.put(CategoryController(
    //   apiRepository: Get.find()
    // ));
    if (catId != null) {
      controller.filterByCatId(catId!);
    } else {
      controller.filterProductByCategory();
    }
  }
  final int? catId;

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
        toolbarHeight: 50,
        title: Text(
          "services".tr,
          style: CommonConstants.kSecondaryTextStyle.copyWith(
            color:
                Get.find<AppController>().isDarkModeOn.value
                    ? ColorConstants.white
                    : ColorConstants.kPrimaryColor,
          ),
        ),
        centerTitle: true,
        leading: CustomIconButton(
          height: 40,
          width: 40,
          margin: const EdgeInsets.only(left: CommonConstants.smallPadding),
          onTap: () => Get.toNamed(Routes.NOTIFICATION),
          child: CustomImageView(
            color:
                Get.find<AppController>().isDarkModeOn.value
                    ? ColorConstants.white
                    : null,
            svgPath: ImageConstant.iconNotification,
            height: 25,
            width: 25,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size(Get.width, 2),
          child: Container(height: 1, color: ColorConstants.kSecondColor10),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: CommonConstants.defaultPadding),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.symmetric(
          //           horizontal: CommonConstants.defaultPadding),
          //       child: ServiceTitle(title: "services".tr),
          //     ),
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Obx(() => controller.isFiltered.value
          //             ? TextButton(
          //                 onPressed: () {
          //                   controller.removeFilter();
          //                 },
          //                 child: Text(
          //                   "removeFilter".tr,
          //                   style: TextStyle(
          //                       color: const Color.fromARGB(255, 255, 92, 80)),
          //                 ))
          //             : Container()),
          //         FilterMenu(controller: controller),
          //       ],
          //     )
          //   ],
          // ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(CommonConstants.defaultPadding),
              child: Obx(() {
                return controller.products.isEmpty
                    ? Center(
                      child: Text(
                        "noServiceFound".tr,
                        style: CommonConstants.kSecondaryTextStyle.copyWith(
                          color:
                              Get.find<AppController>().isDarkModeOn.value
                                  ? ColorConstants.white
                                  : null,
                        ),
                      ),
                    )
                    : NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        // Check if the user has scrolled to the bottom
                        if (scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent &&
                            !controller.isLoading) {
                          controller
                              .loadPaginatedServices(); // Load more services
                        }
                        return true;
                      },
                      child: ListView.builder(
                        itemCount:
                            controller.products.length +
                            1, // Add 1 for the loader
                        itemBuilder: (context, index) {
                          // Show a loading indicator at the end of the list
                          if (index == controller.products.length) {
                            return controller.isLoading
                                ? const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                                : const SizedBox.shrink();
                          }

                          // Display the service item
                          final service = controller.products[index];
                          return service.status == 1
                              ? GestureDetector(
                                onTap: () {},
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    bottom: CommonConstants.defaultPadding,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1.5,
                                      color: ColorConstants.kSecondColor10,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        CommonConstants.mediumRadius,
                                      ),
                                    ),
                                  ),
                                  height: 75,
                                  width: Get.width,
                                  child: Center(
                                    child: ListTile(
                                      contentPadding:
                                          Get.find<LangController>().isRtl()
                                              ? const EdgeInsets.only(right: 12)
                                              : const EdgeInsets.only(left: 12),
                                      dense: false,
                                      horizontalTitleGap: 0,
                                      subtitle: Row(
                                        children: [
                                          Text(
                                            Get.find<LangController>()
                                                        .currentLang() ==
                                                    "fa"
                                                ? formatIranRial(
                                                  double.parse(
                                                    service.final_price_irr
                                                        .toStringAsFixed(0),
                                                  ),
                                                )
                                                : "${(service.final_price_usd).toStringAsFixed(2)}\$",
                                            style: CommonConstants
                                                .kSecondaryTextStyle
                                                .copyWith(color: Colors.green),
                                          ),
                                          Text(
                                            "/",
                                            style: CommonConstants
                                                .kSecondaryTextStyle
                                                .copyWith(
                                                  color:
                                                      Get.find<AppController>()
                                                              .isDarkModeOn
                                                              .value
                                                          ? ColorConstants.white
                                                          : ColorConstants
                                                              .kSecondColor8,
                                                  fontSize: 12,
                                                ),
                                          ),
                                          Text(
                                            "1000",
                                            style: CommonConstants
                                                .kSecondaryTextStyle
                                                .copyWith(
                                                  color:
                                                      Get.find<AppController>()
                                                              .isDarkModeOn
                                                              .value
                                                          ? ColorConstants.white
                                                          : ColorConstants
                                                              .kSecondColor8,
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ],
                                      ),
                                      title: Container(
                                        margin: const EdgeInsets.only(right: 6),
                                        width: Get.width * 0.35,
                                        child: Text(
                                          service.name,
                                          style: CommonConstants
                                              .kSecondaryTextStyle
                                              .copyWith(
                                                color:
                                                    Get.find<AppController>()
                                                            .isDarkModeOn
                                                            .value
                                                        ? ColorConstants.white
                                                        : null,
                                              ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      trailing: Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal:
                                              CommonConstants.defaultPadding,
                                        ),
                                        height: 35,
                                        width: 95,
                                        child: CommonWidgets.primaryButton(
                                          radius: CommonConstants.mediumPadding,
                                          text: "buy".tr,
                                          onPressed: () {
                                            CustomBottomSheet2.show(
                                              context,
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  CommonConstants.mediumPadding,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const SizedBox(),
                                                        CustomImageView(
                                                          color:
                                                              Get.find<
                                                                        AppController
                                                                      >()
                                                                      .isDarkModeOn
                                                                      .value
                                                                  ? ColorConstants
                                                                      .white
                                                                  : null,
                                                          onTap:
                                                              () => Get.back(),
                                                          height: 30,
                                                          width: 30,
                                                          svgPath:
                                                              ImageConstant
                                                                  .iconClose,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 14),
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        service.name,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: CommonConstants
                                                            .kSecondaryTextStyle
                                                            .copyWith(
                                                              color:
                                                                  Get.find<
                                                                            AppController
                                                                          >()
                                                                          .isDarkModeOn
                                                                          .value
                                                                      ? ColorConstants
                                                                          .white
                                                                      : null,
                                                              fontSize: 17,
                                                            ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    RateOrderWidget(
                                                      service: service,
                                                    ),
                                                    Expanded(
                                                      child:
                                                          service.atrebiutes !=
                                                                  null
                                                              ? ListView.builder(
                                                                itemCount:
                                                                    service
                                                                        .atrebiutes!
                                                                        .length,
                                                                itemBuilder: (
                                                                  context,
                                                                  index,
                                                                ) {
                                                                  return Column(
                                                                    children: [
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      AppCheckbox(
                                                                        isChangable:
                                                                            false,
                                                                        checked:
                                                                            true,
                                                                        label:
                                                                            service.atrebiutes![index],
                                                                        onChecked: (
                                                                          value,
                                                                        ) {
                                                                          value =
                                                                              true;
                                                                        },
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              )
                                                              : Container(),
                                                    ),
                                                    CommonWidgets.primaryButton(
                                                      radius:
                                                          CommonConstants
                                                              .mediumPadding,
                                                      text: "continue".tr,
                                                      onPressed: () {
                                                        controller
                                                            .selectedService
                                                            .value = service;
                                                        Get.toNamed(
                                                          Routes.ORDERDETAIL,
                                                        );
                                                      },
                                                    ),
                                                    const SizedBox(height: 20),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              : Container();
                        },
                      ),
                    );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
