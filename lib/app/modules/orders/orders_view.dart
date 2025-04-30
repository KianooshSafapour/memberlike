import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberlike/app/models/response/orders_response.dart';
import 'package:memberlike/app/modules/orders/orders_controller.dart';
import 'package:memberlike/core/routes/app_pages.dart';
import 'package:memberlike/shared/constants/common.dart';
import 'package:memberlike/shared/widgets/custom_icon_button.dart';
import 'package:memberlike/shared/widgets/custom_image_view.dart';
import 'package:memberlike/shared/widgets/directinality_handler_widgets/custom_directionality.dart';

import '../../../app_controller.dart';

import '../../../shared/constants/colors.dart';
import '../../../shared/constants/image_constant.dart';

// ignore: must_be_immutable
class OrdersView extends GetView<OrdersController> {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Get.find<AppController>().isDarkModeOn.value
                ? ColorConstants.darkScaffoldBackgroundColor
                : ColorConstants.white,
        toolbarHeight: 50,
        title: Text(
          "orders".tr,
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
      backgroundColor:
          Get.find<AppController>().isDarkModeOn.value
              ? ColorConstants.darkScaffoldBackgroundColor
              : Colors.white,
      body: Obx(() {
        return controller.orders.isEmpty
            ? SizedBox(
              height: Get.height,
              width: Get.width,
              child: Center(
                child: Text(
                  "ordernotfound".tr,
                  style: CommonConstants.kTitleTextStyle,
                ),
              ),
            )
            : SizedBox(
              height: Get.height,
              child: ListView.builder(
                itemCount: controller.orders.length,
                itemBuilder: (context, index) {
                  return customAlign(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: CommonConstants.defaultPadding,
                        vertical: CommonConstants.smallPadding,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          CommonConstants.mediumRadius,
                        ),
                        color: ColorConstants.kSecondColor10,
                      ),
                      child: ListTile(
                        leading: CustomImageView(
                          svgPath: orderIconHandler(controller.orders[index]),
                        ),
                        contentPadding: const EdgeInsets.all(
                          CommonConstants.defaultPadding,
                        ),
                        title: Text(
                          controller.orders[index].note ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        // subtitle: Text(controller.orders[index].created ?? ""),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "price".tr,
                              style: CommonConstants.kSecondaryTextStyle
                                  .copyWith(
                                    color: ColorConstants.kSecondColor6,
                                    fontSize: 17,
                                  ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              controller.orders[index].charge ?? "",
                              style: CommonConstants.kSecondaryTextStyle
                                  .copyWith(
                                    color: ColorConstants.kPrimaryColor4,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
      }),
    );
  }
}

String orderIconHandler(OrdersResponse order) {
  if (order.note!.contains("Instagram")) return ImageConstant.iconInstagram;
  if (order.note!.contains("Telegram")) return ImageConstant.iconTelegram;
  if (order.note!.contains("Tiktok")) return ImageConstant.iconTiktok;
  if (order.note!.contains("facebook")) return ImageConstant.iconFacebook;
  if (order.note!.contains("snapchat")) return ImageConstant.iconSnapchat;
  return ImageConstant.iconGlobal;
}
