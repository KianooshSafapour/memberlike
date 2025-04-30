import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberlike/app_controller.dart';
import 'package:memberlike/app/modules/main/components/category_view.dart';
import 'package:memberlike/app/modules/profile/profile_view.dart';
import 'package:memberlike/app/modules/splash/splash_controller.dart';
import 'package:memberlike/core/routes/app_pages.dart';

import '../../../../shared/constants/colors.dart';
import '../../../../shared/constants/common.dart';
import '../../../../shared/constants/image_constant.dart';

import '../../../../shared/widgets/carusel_widget.dart';
import '../../../../shared/widgets/custom_icon_button.dart';
import '../../../../shared/widgets/custom_image_view.dart';
import '../../../../shared/widgets/service_title_widget.dart';
import '../home_controller.dart';
import 'dummy_data.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> serviceIcons = [
      ImageConstant.iconTelegram,
      ImageConstant.iconTiktok,
      ImageConstant.iconInstagram,
      ImageConstant.iconSnapchat,
      ImageConstant.iconFacebook,
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Get.find<AppController>().isDarkModeOn.value
                ? ColorConstants.darkScaffoldBackgroundColor
                : ColorConstants.white,
        toolbarHeight: 50,
        title: Text(
          "home".tr,
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
        actions: [
          CustomIconButton(
            margin: const EdgeInsets.only(left: 9),
            height: 40,
            width: 40,
            child: Icon(
              Icons.shopping_cart_outlined,
              color:
                  Get.find<AppController>().isDarkModeOn.value
                      ? ColorConstants.white
                      : ColorConstants.kPrimaryColor,
              fill: .1,
              opticalSize: .1,
              grade: 1,
              size: 25,
            ),
            onTap: () {
              Get.toNamed(Routes.ORDERS);
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size(Get.width, 2),
          child: Container(height: 1, color: ColorConstants.kSecondColor10),
        ),
      ),
      backgroundColor:
          Get.find<AppController>().isDarkModeOn.value
              ? ColorConstants.darkScaffoldBackgroundColor
              : Colors.white,
      body: Column(
        children: [
          CaruselWidget(
            imgList: Get.find<SplashController>().images,
            controller: controller,
          ),
          const SizedBox(height: CommonConstants.height45),
          ServiceTitle(title: "ourServices".tr),
          Padding(
            padding: const EdgeInsets.all(CommonConstants.defaultPadding),
            child: SizedBox(
              height: 80,
              width: Get.width,
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 25,
                crossAxisCount: 5,
                children: [
                  ...List.generate(dummyCategories.length, (int index) {
                    return GestureDetector(
                      onTap: () {
                        controller.selectedCategory(
                          dummyCategories[index].name,
                        );
                        Get.toNamed(Routes.PRODUCTS);
                      },
                      child: CustomImageView(svgPath: serviceIcons[index]),
                    );
                  }),
                ],
              ),
            ),
          ),
          ServiceTitle(title: "topselledProduct".tr),
          Expanded(
            child: Obx(() {
              return controller.categoriesName.isEmpty
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
                  : ListView.separated(
                    itemCount: controller.categoriesName.length,
                    separatorBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.only(
                          left: CommonConstants.defaultPadding,
                          right: CommonConstants.defaultPadding + 5,
                        ),
                        child: Divider(height: 1, thickness: 0.5),
                      );
                    },
                    itemBuilder: (context, index) {
                      return menuListTile(
                        title: controller.categoriesName[index],
                        onTap: () {
                          Get.to(
                            CategoryView(
                              categorieName: controller.categoriesName[index],
                            ),
                          );
                        },
                      );
                    },
                  );
            }),
          ),
        ],
      ),
    );
  }
}
