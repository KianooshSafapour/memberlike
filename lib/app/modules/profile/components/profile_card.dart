import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberlike/app/modules/profile/profile.dart';

import '../../../../app_controller.dart';
import '../../../../shared/constants/colors.dart';
import '../../../../shared/constants/common.dart';

class ProfileCard extends StatelessWidget {
  final ProfileController controller;
  const ProfileCard({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(CommonConstants.defaultPadding),
        child: Container(
          height: 200,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(CommonConstants.largeRadius),
            color:
                Get.find<AppController>().isDarkModeOn.value
                    ? ColorConstants.kPrimaryColor
                    : ColorConstants.kPrimaryColor11,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 80.0,
                width: 80.0,
                decoration: BoxDecoration(
                  color:
                      Get.find<AppController>().isDarkModeOn.value
                          ? ColorConstants.kPrimaryColor6
                          : ColorConstants.kPrimaryColor5,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        controller.userInfo.value?.first_name != null
                            ? "${controller.userInfo.value!.first_name![0].capitalize}"
                            : "N",
                        style: CommonConstants.kSecondaryTextStyle.copyWith(
                          color: ColorConstants.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),

                  //hasImage
                  //     ? Image.network(
                  //         imageUrl,
                  //         fit: BoxFit.contain,
                  //       )
                  //     : Center(
                  //         child: Text('$nameInitial'),
                  //       ),
                ),
              ),
              const SizedBox(height: CommonConstants.mediumPadding),
              Text(
                controller.userInfo.value?.first_name != null
                    ? "${controller.userInfo.value!.first_name} ${controller.userInfo.value!.last_name}"
                    : "******** ******",
                style: CommonConstants.kTitleTextStyle.copyWith(
                  color:
                      Get.find<AppController>().isDarkModeOn.value
                          ? ColorConstants.white
                          : ColorConstants.kPrimaryColor3,
                ),
              ),
              Text(
                controller.userInfo.value?.email ?? "*******@gmail.com",
                style: CommonConstants.kSecondaryTextStyle.copyWith(
                  fontWeight: FontWeight.normal,
                  color:
                      Get.find<AppController>().isDarkModeOn.value
                          ? ColorConstants.white
                          : ColorConstants.kSecondColor6,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
