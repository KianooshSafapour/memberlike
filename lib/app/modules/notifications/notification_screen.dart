import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_controller.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/common.dart';
import '../../../shared/widgets/custom_icon_button.dart';
import 'components/notification_view.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

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
          "notification".tr,
          style: CommonConstants.kSecondaryTextStyle.copyWith(
            color:
                Get.find<AppController>().isDarkModeOn.value
                    ? ColorConstants.white
                    : ColorConstants.kPrimaryColor,
          ),
        ),
        centerTitle: true,
        leading: CustomIconButton(
          height: 20,
          width: 20,
          margin: const EdgeInsets.only(left: CommonConstants.smallPadding),
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color:
                Get.find<AppController>().isDarkModeOn.value
                    ? ColorConstants.white
                    : ColorConstants.kSecondColor4,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size(Get.width, 2),
          child: Container(height: 1, color: ColorConstants.kSecondColor10),
        ),
      ),
      body: const NotificationView(),
    );
  }
}
