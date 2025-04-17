import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberlike/app_controller.dart';
import 'package:memberlike/modules/product/components/product_view.dart';
import 'package:memberlike/modules/profile/profile_view.dart';
import 'package:memberlike/routes/app_pages.dart';

import '../../../shared/constants/colors.dart';
import '../../../shared/constants/common.dart';
import '../../../shared/constants/image_constant.dart';

import '../../../shared/widgets/custom_icon_button.dart';
import '../../../shared/widgets/custom_image_view.dart';
import '../home_controller.dart';

// ignore: must_be_immutable
class CategoryView extends GetView<HomeController> {
  String categorieName;
  CategoryView({super.key, required this.categorieName}) {
    controller.getCategories(categorieName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.find<AppController>().isDarkModeOn.value
            ? ColorConstants.darkScaffoldBackgroundColor
            : ColorConstants.white,
        toolbarHeight: 50,
        title: Text(
          "categories".tr,
          style: CommonConstants.kSecondaryTextStyle.copyWith(
              color: Get.find<AppController>().isDarkModeOn.value
                  ? ColorConstants.white
                  : ColorConstants.kPrimaryColor),
        ),
        centerTitle: true,
        leading: CustomIconButton(
          height: 40,
          width: 40,
          margin: const EdgeInsets.only(left: CommonConstants.smallPadding),
          onTap: () => Get.toNamed(Routes.NOTIFICATION),
          child: CustomImageView(
            color: Get.find<AppController>().isDarkModeOn.value
                ? ColorConstants.white
                : null,
            svgPath: ImageConstant.iconNotification,
            height: 25,
            width: 25,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size(Get.width, 2),
          child: Container(
            height: 1,
            color: ColorConstants.kSecondColor10,
          ),
        ),
      ),
      backgroundColor: Get.find<AppController>().isDarkModeOn.value
          ? ColorConstants.darkScaffoldBackgroundColor
          : Colors.white,
      body: Column(
        children: [
          Expanded(child: Obx(() {
            return controller.categoriesName.isEmpty
                ? Center(
                    child: Text(
                    "noServiceFound".tr,
                    style: CommonConstants.kSecondaryTextStyle.copyWith(
                        color: Get.find<AppController>().isDarkModeOn.value
                            ? ColorConstants.white
                            : null),
                  ))
                : ListView.separated(
                    itemCount: controller.categories.length,
                    separatorBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.only(
                            left: CommonConstants.defaultPadding,
                            right: CommonConstants.defaultPadding + 5),
                        child: Divider(
                          height: 1,
                          thickness: 0.5,
                        ),
                      );
                    },
                    itemBuilder: (context, index) {
                      return menuListTile(
                        title: controller.categories[index].name,
                        onTap: () {
                          Get.to(ProductsScreen(
                            catId: controller.categories[index].id,
                          ));
                        },
                      );
                    },
                  );
          })),
        ],
      ),
    );
  }
}
