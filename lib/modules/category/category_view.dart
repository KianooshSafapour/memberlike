import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memberlike/models/response/service_response.dart';
import 'package:memberlike/modules/category/category_controller.dart';
import 'package:memberlike/shared/shared.dart';
import 'package:memberlike/shared/utils/price_util.dart';
import 'package:memberlike/shared/widgets/custom_bottomsheet.dart';
import 'package:memberlike/shared/widgets/service_title_widget.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constants/image_constant.dart';
import '../../../shared/widgets/button.dart';
import '../../../shared/widgets/custom_icon_button.dart';
import '../../../shared/widgets/custom_image_view.dart';
import '../../app_controller.dart';
import '../language/lang_controller.dart';
import 'components/filter_menu.dart';

class CategoryView extends GetView<CategoryController> {
  CategoryView({super.key}) {
    // Get.put(CategoryController(
    //   apiRepository: Get.find()
    // ));
  }

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: CommonConstants.defaultPadding,
                ),
                child: ServiceTitle(title: "services".tr),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () =>
                        controller.isFiltered.value
                            ? TextButton(
                              onPressed: () {
                                controller.removeFilter();
                              },
                              child: Text(
                                "removeFilter".tr,
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 255, 92, 80),
                                ),
                              ),
                            )
                            : Container(),
                  ),
                  FilterMenu(controller: controller),
                ],
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(CommonConstants.defaultPadding),
              child: Obx(() {
                return controller.services.isEmpty
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
                            controller.services.length +
                            1, // Add 1 for the loader
                        itemBuilder: (context, index) {
                          // Show a loading indicator at the end of the list
                          if (index == controller.services.length) {
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
                          final service = controller.services[index];
                          return GestureDetector(
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
                                  Radius.circular(CommonConstants.mediumRadius),
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
                                                'fa'
                                            ? '${formatIranRial(service.final_price_irr)} ریال'
                                            : '${service.final_price_usd} \$',
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
                                      style: CommonConstants.kSecondaryTextStyle
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
                                                      onTap: () => Get.back(),
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
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    service.name,
                                                    textAlign: TextAlign.center,
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
                                                  child: ListView.builder(
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
                                                            height: 10,
                                                          ),
                                                          AppCheckbox(
                                                            isChangable: false,
                                                            checked: true,
                                                            label:
                                                                service
                                                                    .atrebiutes![index],
                                                            onChecked: (value) {
                                                              value = true;
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
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
                          );
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

class RateOrderWidget extends StatelessWidget {
  RateOrderWidget({super.key, required this.service});
  final ServiceResponse service;

  final box = GetStorage();
  currentLang() => box.read('lang');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Add padding around the widget
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Space between columns
        children: [
          // Column for "Rate per 1000"
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'rateper1000'.tr,
                style: TextStyle(
                  fontSize: 14,
                  color:
                      Get.find<AppController>().isDarkModeOn.value
                          ? ColorConstants.white
                          : Colors.grey,
                ),
              ),
              const SizedBox(height: 8), // Space between the label and value
              Text(
                currentLang() == 'fa'
                    ? '${formatIranRial(service.final_price_irr)} ریال'
                    : '${service.final_price_usd} \$',
                style: TextStyle(
                  color:
                      Get.find<AppController>().isDarkModeOn.value
                          ? ColorConstants.white
                          : null,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // Column for "Min order Max"
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'minOrder'.tr,
                style: TextStyle(
                  fontSize: 14,
                  color:
                      Get.find<AppController>().isDarkModeOn.value
                          ? ColorConstants.white
                          : Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${service.min}',
                style: TextStyle(
                  color:
                      Get.find<AppController>().isDarkModeOn.value
                          ? ColorConstants.white
                          : null,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // Column for "Order"
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'maxOrder'.tr,
                style: TextStyle(
                  fontSize: 14,
                  color:
                      Get.find<AppController>().isDarkModeOn.value
                          ? ColorConstants.white
                          : Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${service.max}',
                style: TextStyle(
                  color:
                      Get.find<AppController>().isDarkModeOn.value
                          ? ColorConstants.white
                          : null,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
